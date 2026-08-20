#!/usr/bin/env python3
from __future__ import annotations

import argparse
import base64
import datetime as dt
import json
import pathlib
import re
import struct
import uuid
import zipfile
from dataclasses import dataclass
from typing import Iterable, Sequence
from xml.sax.saxutils import escape

PROJECT_ROOT = pathlib.Path(__file__).resolve().parent
OUTPUT_ROOT = PROJECT_ROOT / "output"
H2C_PROJECT_TEMPLATE = (
    PROJECT_ROOT / "templates" / "bambu_h2c_0.2mm_project_template.3mf"
)
H2C_PLATE_WIDTH = 330.0
H2C_PLATE_DEPTH = 320.0
LOGICAL_PLATE_GAP = 0.20

PNG_1X1 = base64.b64decode(
    "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO6pL9sAAAAASUVORK5CYII="
)


@dataclass
class MeshData:
    vertices: list[tuple[float, float, float]]
    triangles: list[tuple[int, int, int]]
    z_min: float


def _is_binary_stl(raw: bytes) -> bool:
    if len(raw) < 84:
        return False
    tri_count = struct.unpack_from("<I", raw, 80)[0]
    expected = 84 + tri_count * 50
    return expected == len(raw)


def _read_binary_stl(raw: bytes) -> MeshData:
    tri_count = struct.unpack_from("<I", raw, 80)[0]
    vertices: list[tuple[float, float, float]] = []
    triangles: list[tuple[int, int, int]] = []
    vmap: dict[tuple[float, float, float], int] = {}

    z_min = float("inf")
    offset = 84
    for _ in range(tri_count):
        rec = struct.unpack_from("<12fH", raw, offset)
        offset += 50
        tri_idx: list[int] = []
        for i in (3, 6, 9):
            v = (float(rec[i]), float(rec[i + 1]), float(rec[i + 2]))
            z_min = min(z_min, v[2])
            idx = vmap.get(v)
            if idx is None:
                idx = len(vertices)
                vertices.append(v)
                vmap[v] = idx
            tri_idx.append(idx)
        triangles.append((tri_idx[0], tri_idx[1], tri_idx[2]))

    if z_min == float("inf"):
        z_min = 0.0

    return MeshData(vertices=vertices, triangles=triangles, z_min=z_min)


def _read_ascii_stl(raw: bytes) -> MeshData:
    text = raw.decode("utf-8", errors="ignore")
    vertices: list[tuple[float, float, float]] = []
    triangles: list[tuple[int, int, int]] = []
    vmap: dict[tuple[float, float, float], int] = {}

    z_min = float("inf")
    tri_buf: list[int] = []

    for line in text.splitlines():
        s = line.strip()
        if not s.startswith("vertex "):
            continue
        parts = s.split()
        if len(parts) != 4:
            continue

        v = (float(parts[1]), float(parts[2]), float(parts[3]))
        z_min = min(z_min, v[2])
        idx = vmap.get(v)
        if idx is None:
            idx = len(vertices)
            vertices.append(v)
            vmap[v] = idx

        tri_buf.append(idx)
        if len(tri_buf) == 3:
            triangles.append((tri_buf[0], tri_buf[1], tri_buf[2]))
            tri_buf.clear()

    if z_min == float("inf"):
        z_min = 0.0

    return MeshData(vertices=vertices, triangles=triangles, z_min=z_min)


def read_stl(path: pathlib.Path) -> MeshData:
    raw = path.read_bytes()
    if _is_binary_stl(raw):
        return _read_binary_stl(raw)
    return _read_ascii_stl(raw)


def fmt_float(v: float) -> str:
    return f"{v:.7f}".rstrip("0").rstrip(".") if abs(v) >= 1e-12 else "0"


def object_model_xml(mesh_object_id: int, mesh: MeshData) -> str:
    lines: list[str] = []
    lines.append('<?xml version="1.0" encoding="UTF-8"?>')
    lines.append(
        '<model unit="millimeter" xml:lang="en-US" '
        'xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02" '
        'xmlns:BambuStudio="http://schemas.bambulab.com/package/2021" '
        'xmlns:p="http://schemas.microsoft.com/3dmanufacturing/production/2015/06" '
        'requiredextensions="p">'
    )
    lines.append(' <metadata name="BambuStudio:3mfVersion">1</metadata>')
    lines.append(" <resources>")
    lines.append(
        f'  <object id="{mesh_object_id}" p:UUID="{uuid.uuid4()}" type="model">'
    )
    lines.append("   <mesh>")
    lines.append("    <vertices>")
    for x, y, z in mesh.vertices:
        lines.append(
            f'     <vertex x="{fmt_float(x)}" y="{fmt_float(y)}" z="{fmt_float(z)}"/>'
        )
    lines.append("    </vertices>")
    lines.append("    <triangles>")
    for v1, v2, v3 in mesh.triangles:
        lines.append(f'     <triangle v1="{v1}" v2="{v2}" v3="{v3}"/>')
    lines.append("    </triangles>")
    lines.append("   </mesh>")
    lines.append("  </object>")
    lines.append(" </resources>")
    lines.append(" <build/>")
    lines.append("</model>")
    return "\n".join(lines) + "\n"


def model_xml(items: list[dict]) -> str:
    today = dt.date.today().isoformat()
    lines: list[str] = []
    lines.append('<?xml version="1.0" encoding="UTF-8"?>')
    lines.append(
        '<model unit="millimeter" xml:lang="en-US" '
        'xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02" '
        'xmlns:BambuStudio="http://schemas.bambulab.com/package/2021" '
        'xmlns:p="http://schemas.microsoft.com/3dmanufacturing/production/2015/06" '
        'requiredextensions="p">'
    )
    lines.append(' <metadata name="Application">BambuStudio-02.06.00.51</metadata>')
    lines.append(' <metadata name="BambuStudio:3mfVersion">1</metadata>')
    lines.append(f' <metadata name="CreationDate">{today}</metadata>')
    lines.append(f' <metadata name="ModificationDate">{today}</metadata>')
    lines.append(' <metadata name="Thumbnail_Middle">/Metadata/plate_1.png</metadata>')
    lines.append(' <metadata name="Thumbnail_Small">/Metadata/plate_1_small.png</metadata>')
    lines.append(" <resources>")

    for item in items:
        lines.append(f'  <object id="{item["main_object_id"]}" p:UUID="{uuid.uuid4()}" type="model">')
        lines.append("   <components>")
        lines.append(
            f'    <component p:path="/3D/Objects/{item["object_file"]}" objectid="{item["mesh_object_id"]}" '
            f'p:UUID="{uuid.uuid4()}" transform="1 0 0 0 1 0 0 0 1 0 0 0"/>'
        )
        lines.append("   </components>")
        lines.append("  </object>")

    lines.append(" </resources>")
    lines.append(f' <build p:UUID="{uuid.uuid4()}">')
    for item in items:
        tx = fmt_float(item["tx"])
        ty = fmt_float(item["ty"])
        tz = fmt_float(item["tz"])
        lines.append(
            f'  <item objectid="{item["main_object_id"]}" p:UUID="{uuid.uuid4()}" '
            f'transform="1 0 0 0 1 0 0 0 1 {tx} {ty} {tz}" printable="1"/>'
        )
    lines.append(" </build>")
    lines.append("</model>")
    return "\n".join(lines) + "\n"


def model_rels_xml(items: list[dict]) -> str:
    lines = ['<?xml version="1.0" encoding="UTF-8"?>']
    lines.append('<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">')
    for i, item in enumerate(items, start=1):
        lines.append(
            f' <Relationship Target="/3D/Objects/{item["object_file"]}" Id="rel-{i}" '
            'Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/>'
        )
    lines.append("</Relationships>")
    return "\n".join(lines) + "\n"


def root_rels_xml() -> str:
    return """<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<Relationships xmlns=\"http://schemas.openxmlformats.org/package/2006/relationships\">
 <Relationship Target=\"/3D/3dmodel.model\" Id=\"rel-1\" Type=\"http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel\"/>
 <Relationship Target=\"/Metadata/plate_1.png\" Id=\"rel-2\" Type=\"http://schemas.openxmlformats.org/package/2006/relationships/metadata/thumbnail\"/>
 <Relationship Target=\"/Metadata/plate_1.png\" Id=\"rel-4\" Type=\"http://schemas.bambulab.com/package/2021/cover-thumbnail-middle\"/>
 <Relationship Target=\"/Metadata/plate_1_small.png\" Id=\"rel-5\" Type=\"http://schemas.bambulab.com/package/2021/cover-thumbnail-small\"/>
</Relationships>
"""


def content_types_xml() -> str:
    return """<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<Types xmlns=\"http://schemas.openxmlformats.org/package/2006/content-types\">
 <Default Extension=\"rels\" ContentType=\"application/vnd.openxmlformats-package.relationships+xml\"/>
 <Default Extension=\"model\" ContentType=\"application/vnd.ms-package.3dmanufacturing-3dmodel+xml\"/>
 <Default Extension=\"config\" ContentType=\"text/xml\"/>
 <Default Extension=\"png\" ContentType=\"image/png\"/>
 <Default Extension=\"json\" ContentType=\"application/json\"/>
</Types>
"""


def model_settings_xml(items: list[dict]) -> str:
    lines: list[str] = []
    lines.append('<?xml version="1.0" encoding="UTF-8"?>')
    lines.append("<config>")

    for item in items:
        name = escape(item["name"])
        source = escape(item["source_file"])
        face_count = item["face_count"]
        main_id = item["main_object_id"]
        part_id = item["mesh_object_id"]
        lines.append(f'  <object id="{main_id}">')
        lines.append(f'    <metadata key="name" value="{name}"/>')
        lines.append('    <metadata key="extruder" value="1"/>')
        lines.append(f'    <metadata face_count="{face_count}"/>')
        lines.append(f'    <part id="{part_id}" subtype="normal_part">')
        lines.append(f'      <metadata key="name" value="{name}"/>')
        lines.append('      <metadata key="matrix" value="1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1"/>')
        lines.append(f'      <metadata key="source_file" value="{source}"/>')
        lines.append('      <metadata key="source_object_id" value="0"/>')
        lines.append('      <metadata key="source_volume_id" value="0"/>')
        lines.append('      <metadata key="source_offset_x" value="0"/>')
        lines.append('      <metadata key="source_offset_y" value="0"/>')
        lines.append(f'      <metadata key="source_offset_z" value="{fmt_float(item["tz"])}"/>')
        lines.append(
            f'      <mesh_stat face_count="{face_count}" edges_fixed="0" degenerate_facets="0" '
            'facets_removed="0" facets_reversed="0" backwards_edges="0"/>'
        )
        lines.append("    </part>")
        lines.append("  </object>")

    for i, item in enumerate(items, start=1):
        name = escape(pathlib.Path(item["name"]).stem)
        lines.append("  <plate>")
        lines.append(f'    <metadata key="plater_id" value="{i}"/>')
        lines.append(f'    <metadata key="plater_name" value="{name}"/>')
        lines.append('    <metadata key="locked" value="false"/>')
        lines.append('    <metadata key="filament_map_mode" value="Auto For Flush"/>')
        lines.append('    <metadata key="thumbnail_file" value="Metadata/plate_1.png"/>')
        lines.append('    <metadata key="thumbnail_no_light_file" value="Metadata/plate_no_light_1.png"/>')
        lines.append('    <metadata key="top_file" value="Metadata/top_1.png"/>')
        lines.append('    <metadata key="pick_file" value="Metadata/pick_1.png"/>')
        lines.append("    <model_instance>")
        lines.append(f'      <metadata key="object_id" value="{item["main_object_id"]}"/>')
        lines.append('      <metadata key="instance_id" value="0"/>')
        lines.append(f'      <metadata key="identify_id" value="{1000 + i}"/>')
        lines.append("    </model_instance>")
        lines.append("  </plate>")

    lines.append("  <assemble>")
    for item in items:
        tx = fmt_float(item["tx"])
        ty = fmt_float(item["ty"])
        tz = fmt_float(item["tz"])
        lines.append(
            f'   <assemble_item object_id="{item["main_object_id"]}" instance_id="0" '
            f'transform="1 0 0 0 1 0 0 0 1 {tx} {ty} {tz}" offset="0 0 0" />'
        )
    lines.append("  </assemble>")

    lines.append("</config>")
    return "\n".join(lines) + "\n"


def _load_template_project_settings() -> str:
    if not H2C_PROJECT_TEMPLATE.is_file():
        raise RuntimeError(
            "Required H2C project template is missing: "
            f"{H2C_PROJECT_TEMPLATE}"
        )

    try:
        with zipfile.ZipFile(H2C_PROJECT_TEMPLATE, "r") as zf:
            content = zf.read("Metadata/project_settings.config").decode("utf-8")
    except (OSError, KeyError, UnicodeDecodeError, zipfile.BadZipFile) as exc:
        raise RuntimeError(
            f"Invalid H2C project template: {H2C_PROJECT_TEMPLATE}"
        ) from exc

    try:
        settings = json.loads(content)
    except json.JSONDecodeError as exc:
        raise RuntimeError("H2C project settings are not valid JSON") from exc

    expected_area = ["0x0", "330x0", "330x320", "0x320"]
    if (
        settings.get("printer_model") != "Bambu Lab H2C"
        or settings.get("printable_area") != expected_area
    ):
        raise RuntimeError(
            "Project template must target Bambu Lab H2C with a 330 x 320 mm plate"
        )

    return content


def project_settings_xml() -> str:
    return _load_template_project_settings()


def slice_info_config() -> str:
    return """<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<config>
  <header>
    <header_item key=\"X-BBL-Client-Type\" value=\"slicer\"/>
    <header_item key=\"X-BBL-Client-Version\" value=\"02.06.00.51\"/>
  </header>
</config>
"""


def filament_sequence_json(count: int) -> str:
    parts = []
    for i in range(1, count + 1):
        parts.append(f'"plate_{i}":{{"nozzle_sequence":[],"optimal_assignment":[],"sequence":[]}}')
    return "{" + ",".join(parts) + "}\n"


def cut_information_xml(count: int) -> str:
    lines = ['<?xml version="1.0" encoding="utf-8"?>', '<objects>']
    for i in range(1, count + 1):
        lines.append(f' <object id="{i}">')
        lines.append('  <cut_id id="0" check_sum="1" connectors_cnt="0"/>')
        lines.append(' </object>')
    lines.append('</objects>')
    return "\n".join(lines) + "\n"


def iter_stls(stl_dir: pathlib.Path) -> Iterable[pathlib.Path]:
    return sorted(p for p in stl_dir.glob("*.stl") if p.is_file())


def _sanitize_name(name: str) -> str:
    safe = re.sub(r"[^A-Za-z0-9_-]+", "_", name).strip("_")
    return safe or "group"


def _group_key(stl: pathlib.Path, mode: str) -> str:
    if mode == "none":
        return "all"

    stem = stl.stem
    m = re.match(r"^(Design_[A-Za-z0-9]+)(?:_|$)", stem)
    if m:
        return m.group(1)

    if "_" in stem:
        return stem.split("_", 1)[0]
    return "misc"


def _size_sort_key(stl: pathlib.Path) -> tuple[int, int, str]:
    stem = stl.stem
    m = re.search(r"_(\d+)mm$", stem)
    if m:
        return (0, int(m.group(1)), stem)
    return (1, 0, stem)


def _chunked(seq: Sequence[pathlib.Path], chunk_size: int) -> Iterable[list[pathlib.Path]]:
    for i in range(0, len(seq), chunk_size):
        yield list(seq[i:i + chunk_size])


def compute_colum_count(count: int) -> int:
    value = count ** 0.5
    round_value = round(value)
    if value > round_value:
        return round_value + 1
    return round_value


def _build_single_3mf_from_stls(stls: list[pathlib.Path], out_3mf: pathlib.Path) -> None:
    if not stls:
        raise RuntimeError("No STL files provided")

    items: list[dict] = []
    cols = compute_colum_count(len(stls))
    # Bambu Studio lays out logical plates with a 20% gap. These values must
    # stay aligned with the bundled H2C project's 330 x 320 mm printable area.
    plate_origin_x = H2C_PLATE_WIDTH / 2
    plate_origin_y = H2C_PLATE_DEPTH / 2
    plate_step_x = H2C_PLATE_WIDTH * (1 + LOGICAL_PLATE_GAP)
    plate_step_y = H2C_PLATE_DEPTH * (1 + LOGICAL_PLATE_GAP)

    object_models: list[tuple[str, str]] = []

    for i, stl in enumerate(stls, start=1):
        mesh = read_stl(stl)
        main_object_id = i * 2
        mesh_object_id = main_object_id - 1
        object_file = f"object_{100 + i}.model"

        col = (i - 1) % cols
        row = (i - 1) // cols
        tx = plate_origin_x + col * plate_step_x
        ty = plate_origin_y - row * plate_step_y
        tz = max(0.0, -mesh.z_min)

        items.append(
            {
                "name": stl.name,
                "source_file": stl.name,
                "main_object_id": main_object_id,
                "mesh_object_id": mesh_object_id,
                "object_file": object_file,
                "face_count": len(mesh.triangles),
                "tx": tx,
                "ty": ty,
                "tz": tz,
            }
        )

        object_models.append((f"3D/Objects/{object_file}", object_model_xml(mesh_object_id, mesh)))

    out_3mf.parent.mkdir(parents=True, exist_ok=True)
    if out_3mf.exists():
        out_3mf.unlink()

    with zipfile.ZipFile(out_3mf, "w", compression=zipfile.ZIP_DEFLATED) as zf:
        zf.writestr("[Content_Types].xml", content_types_xml())
        zf.writestr("_rels/.rels", root_rels_xml())
        zf.writestr("3D/3dmodel.model", model_xml(items))
        zf.writestr("3D/_rels/3dmodel.model.rels", model_rels_xml(items))
        zf.writestr("Metadata/model_settings.config", model_settings_xml(items))
        zf.writestr("Metadata/project_settings.config", project_settings_xml())
        zf.writestr("Metadata/slice_info.config", slice_info_config())
        zf.writestr("Metadata/filament_sequence.json", filament_sequence_json(len(items)))
        zf.writestr("Metadata/cut_information.xml", cut_information_xml(len(items)))
        zf.writestr("Metadata/plate_1.png", PNG_1X1)
        zf.writestr("Metadata/plate_1_small.png", PNG_1X1)
        zf.writestr("Metadata/plate_no_light_1.png", PNG_1X1)
        zf.writestr("Metadata/top_1.png", PNG_1X1)
        zf.writestr("Metadata/pick_1.png", PNG_1X1)

        for path_in_zip, xml in object_models:
            zf.writestr(path_in_zip, xml)


def build_split_3mf(
    stl_dir: pathlib.Path,
    out_prefix: pathlib.Path,
    max_plates: int,
    group_mode: str,
) -> list[pathlib.Path]:
    stls = list(iter_stls(stl_dir))
    if not stls:
        raise RuntimeError(f"No STL files found in {stl_dir}")

    if max_plates < 1:
        raise ValueError("max_plates must be >= 1")

    grouped: dict[str, list[pathlib.Path]] = {}
    for stl in stls:
        key = _group_key(stl, group_mode)
        grouped.setdefault(key, []).append(stl)

    for key in grouped:
        grouped[key] = sorted(grouped[key], key=_size_sort_key)

    out_dir = out_prefix.parent
    out_stem = out_prefix.name
    if str(out_dir) == "":
        out_dir = pathlib.Path(".")

    created: list[pathlib.Path] = []

    for group in sorted(grouped.keys()):
        chunk_list = list(_chunked(grouped[group], max_plates))
        group_safe = _sanitize_name(group)

        for chunk_idx, chunk in enumerate(chunk_list, start=1):
            if group_mode == "none":
                file_name = f"{out_stem}_part{chunk_idx:02d}.3mf"
            else:
                file_name = f"{out_stem}_{group_safe}_part{chunk_idx:02d}.3mf"

            out_file = out_dir / file_name
            _build_single_3mf_from_stls(chunk, out_file)
            created.append(out_file)

    return created


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Build Bambu-compatible split 3MF files from STL files."
    )
    parser.add_argument(
        "--model-name",
        default="parametric_heart",
        help="Model name used for default input and output paths (default: parametric_heart)",
    )
    parser.add_argument(
        "--stl-dir",
        type=pathlib.Path,
        default=None,
        help="Directory containing STL files (default: output/stl/<model-name>)",
    )
    parser.add_argument(
        "--out-prefix",
        type=pathlib.Path,
        default=None,
        help="Output filename prefix (default: output/3mf/<model-name>/<model-name>-bambu)",
    )
    parser.add_argument(
        "--max-plates",
        type=int,
        default=9999,
        help="Maximum plates (models) per 3MF file (default: 9999)",
    )
    parser.add_argument(
        "--group-mode",
        choices=("prefix", "none"),
        default="none",
        help="Grouping method for split files: prefix or none (default: none)",
    )
    parser.add_argument(
        "--out",
        type=pathlib.Path,
        default=None,
        help="Deprecated alias for --out-prefix. If .3mf is given, extension is removed.",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()

    if not re.fullmatch(r"[A-Za-z0-9_-]+", args.model_name):
        raise ValueError(
            "model-name may contain only letters, numbers, underscores, and hyphens"
        )

    stl_dir = args.stl_dir or OUTPUT_ROOT / "stl" / args.model_name
    artifact_name = args.model_name.replace("_", "-")
    out_prefix = args.out_prefix or (
        OUTPUT_ROOT / "3mf" / args.model_name / f"{artifact_name}-bambu"
    )
    if args.out is not None:
        out_prefix = args.out
        if out_prefix.suffix.lower() == ".3mf":
            out_prefix = out_prefix.with_suffix("")

    created = build_split_3mf(
        stl_dir=stl_dir,
        out_prefix=out_prefix,
        max_plates=args.max_plates,
        group_mode=args.group_mode,
    )

    print("Created files:")
    for path in created:
        print(f"- {path}")


if __name__ == "__main__":
    main()
