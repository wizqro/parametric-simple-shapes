#!/usr/bin/env python3
from __future__ import annotations

import json
import pathlib
from collections import OrderedDict
from decimal import Decimal

PROJECT_ROOT = pathlib.Path(__file__).resolve().parent
OUTPUT_PATH = PROJECT_ROOT / "presets" / "parametric_cylinder.json"

# Keep the same 24 outside diameters as the heart and star collections.
SIZES = (
    "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "14", "16",
    "18", "20", "24", "28", "32", "38", "46", "60", "80", "100", "150", "200",
)


def decimal_text(value: Decimal) -> str:
    return format(value.quantize(Decimal("0.01")).normalize(), "f")


def percent_of(size: str, percent: str, minimum: str = "0") -> str:
    value = Decimal(size) * Decimal(percent) / Decimal("100")
    return decimal_text(max(value, Decimal(minimum)))


def preset(
    *,
    diameter: str,
    height: str,
    hollow: str,
    wall: str = "3",
    top_style: str = "2",
    dome_height: str = "0",
    top_radius: str = "0",
    bottom_radius: str = "0",
) -> OrderedDict[str, str]:
    return OrderedDict(
        [
            ("outer_diameter", diameter),
            ("model_height", height),
            ("hollow", hollow),
            ("wall_thickness", wall),
            ("top_surface_style", top_style),
            ("dome_height", dome_height),
            ("top_edge_radius", top_radius),
            ("bottom_edge_radius", bottom_radius),
        ]
    )


def build_presets() -> OrderedDict[str, OrderedDict[str, str]]:
    presets: OrderedDict[str, OrderedDict[str, str]] = OrderedDict()
    presets["Demo_Solid_Flat_50mm"] = preset(
        diameter="50", height="20", hollow="false"
    )
    presets["Demo_Solid_Rounded_50mm"] = preset(
        diameter="50", height="20", hollow="false", top_radius="8", bottom_radius="8"
    )
    presets["Demo_Solid_Domed_50mm"] = preset(
        diameter="50", height="20", hollow="false", top_style="1", dome_height="12"
    )
    presets["Demo_Hollow_Flat_50mm"] = preset(
        diameter="50", height="20", hollow="true", wall="3"
    )
    presets["Demo_Hollow_Rounded_50mm"] = preset(
        diameter="50", height="20", hollow="true", wall="7",
        top_radius="3.4", bottom_radius="3.4",
    )

    for design in ("A", "B", "C", "D", "E"):
        for size in SIZES:
            name = f"Design_{design}_{size}mm"
            if design == "A":
                # Basic solid cylinder, flat top.
                presets[name] = preset(
                    diameter=size,
                    height=percent_of(size, "12", "0.2"),
                    hollow="false",
                )
            elif design == "B":
                # Solid cylinder with clearly rounded top/bottom edges.
                presets[name] = preset(
                    diameter=size,
                    height=percent_of(size, "12", "0.2"),
                    hollow="false",
                    top_radius=percent_of(size, "10"),
                    bottom_radius=percent_of(size, "10"),
                )
            elif design == "C":
                # Flat hollow cylinder (ring).
                presets[name] = preset(
                    diameter=size,
                    height=percent_of(size, "50", "0.4"),
                    hollow="true",
                    wall=percent_of(size, "10", "0.4"),
                )
            elif design == "D":
                # Hollow cylinder with clearly rounded top/bottom edges. The
                # wall is thickened versus Design C so the larger fillet has
                # room to show without collapsing the hole.
                wall = percent_of(size, "16", "0.4")
                presets[name] = preset(
                    diameter=size,
                    height=percent_of(size, "50", "0.4"),
                    hollow="true",
                    wall=wall,
                    top_radius=decimal_text(Decimal(wall) * Decimal("0.48")),
                    bottom_radius=decimal_text(Decimal(wall) * Decimal("0.48")),
                )
            else:
                # Solid cylinder with a domed cap, like a capsule top. Not
                # offered for hollow bodies: the dome would bridge solid
                # material over the open cavity with no way to remove the
                # support that bridge would need once printed.
                presets[name] = preset(
                    diameter=size,
                    height=percent_of(size, "20", "0.2"),
                    hollow="false",
                    top_style="1",
                    dome_height=percent_of(size, "30", "0.2"),
                )

    return presets


def main() -> None:
    document = OrderedDict(
        [
            ("fileFormatVersion", "1"),
            ("parameterSets", build_presets()),
        ]
    )
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PATH.write_text(
        json.dumps(document, indent=4, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    print(f"Created {OUTPUT_PATH} with {len(document['parameterSets'])} presets")


if __name__ == "__main__":
    main()
