#!/usr/bin/env python3
from __future__ import annotations

import json
import pathlib
from collections import OrderedDict
from decimal import Decimal

PROJECT_ROOT = pathlib.Path(__file__).resolve().parent
OUTPUT_PATH = PROJECT_ROOT / "presets" / "parametric_star.json"

# Match the established heart size series and Design_A body heights.
SIZES_AND_BODY_HEIGHTS = [
    ("3", "0.36"),
    ("4", "0.48"),
    ("5", "0.6"),
    ("6", "0.72"),
    ("7", "0.84"),
    ("8", "0.96"),
    ("9", "1.08"),
    ("10", "1.2"),
    ("11", "1.31"),
    ("12", "1.44"),
    ("14", "1.68"),
    ("16", "1.92"),
    ("18", "2.16"),
    ("20", "2.4"),
    ("24", "2.88"),
    ("28", "3.36"),
    ("32", "3.84"),
    ("38", "4.55"),
    ("46", "5.52"),
    ("60", "7.19"),
    ("80", "9.6"),
    ("100", "12"),
    ("150", "18"),
    ("200", "24"),
]


def percent_of(size: str, percent: str) -> str:
    value = Decimal(size) * Decimal(percent) / Decimal("100")
    return format(value.normalize(), "f")


def preset(
    *,
    size: str,
    body_height: str,
    top_style: str,
    apex_height: str,
    edge_fillet_radius: str,
    corner_rounding_percent: str,
    inner_radius_percent: str = "45",
) -> OrderedDict[str, str]:
    return OrderedDict(
        [
            ("star_size", size),
            ("inner_radius_percent", inner_radius_percent),
            ("top_surface_style", top_style),
            ("apex_height", apex_height),
            ("top_edge_fillet_radius", edge_fillet_radius),
            ("corner_rounding_percent", corner_rounding_percent),
            ("wall_thickness", body_height),
        ]
    )


def build_presets() -> OrderedDict[str, OrderedDict[str, str]]:
    presets: OrderedDict[str, OrderedDict[str, str]] = OrderedDict()
    presets["Demo_Faceted_Apex_50mm"] = preset(
        size="50",
        body_height="5",
        top_style="1",
        apex_height="6",
        edge_fillet_radius="0",
        corner_rounding_percent="0",
    )
    presets["Demo_Top_Edge_Fillet_50mm"] = preset(
        size="50",
        body_height="5",
        top_style="2",
        apex_height="0",
        edge_fillet_radius="2",
        corner_rounding_percent="0",
    )

    for design in ("A", "B", "C", "D"):
        for size, body_height in SIZES_AND_BODY_HEIGHTS:
            name = f"Design_{design}_{size}mm"
            if design == "A":
                presets[name] = preset(
                    size=size,
                    body_height=body_height,
                    top_style="1",
                    apex_height="0",
                    edge_fillet_radius="0",
                    corner_rounding_percent="0",
                )
            elif design == "B":
                presets[name] = preset(
                    size=size,
                    body_height=body_height,
                    top_style="1",
                    apex_height="0",
                    edge_fillet_radius="0",
                    corner_rounding_percent="4",
                )
            elif design == "C":
                presets[name] = preset(
                    size=size,
                    body_height="0.2",
                    top_style="1",
                    apex_height=body_height,
                    edge_fillet_radius="0",
                    corner_rounding_percent="0",
                )
            else:
                presets[name] = preset(
                    size=size,
                    body_height=body_height,
                    top_style="2",
                    apex_height="0",
                    edge_fillet_radius=percent_of(size, "8"),
                    corner_rounding_percent="8",
                    inner_radius_percent="50",
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
