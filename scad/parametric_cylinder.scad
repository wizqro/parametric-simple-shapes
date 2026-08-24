/*
  Parametric cylinder for MakerWorld Customizer

  The default is a solid cylinder. An optional centered through-hole turns it
  into a hollow cylinder. The top can be a rounded-off flat edge, or (solid
  bodies only) a full domed cap added above the body. The bottom outer edge
  can be rounded independently of the top treatment. The bottom always stays
  on Z=0 and the model is ready to print.

  A domed cap over a Hollow body is not offered: it would bridge solid
  material over the open cavity with nothing underneath to support it, and
  that support could never be removed once printed. Hollow always uses the
  Top Edge Fillet treatment instead.
*/

/* [Overall Size] */

// Outside diameter (mm).
outer_diameter = 60; // [3:300]

// Body height (mm), not counting the dome when Top Surface Style is Domed.
model_height = 24; // [0.2:0.2:300]

/* [Optional Hollow Center] */

// Enable a centered hole through the body. Disabled by default for a solid cylinder. Forces Top Edge Fillet (Domed Surface is not offered for Hollow bodies).
hollow = false; // [false, true]

// Radial wall thickness when Hollow is enabled (mm). Oversized values are automatically limited.
wall_thickness = 3; // [0.2:0.1:100]

/* [Top Surface] */

// Top treatment: Domed Surface adds a rounded cap above the body height (solid bodies only); Top Edge Fillet keeps the top flat and rounds only the upper outside edge.
top_surface_style = 1; // [1:Domed Surface, 2:Top Edge Fillet]

// Height of the domed cap above the body (mm). Used only when Top Surface Style is Domed Surface and Hollow is disabled.
dome_height = 12; // [0:0.1:150]

// Radius of the rounded outside top edge (mm). Used only when Top Surface Style is Top Edge Fillet. With Hollow enabled, it is limited to preserve the wall.
top_edge_radius = 8; // [0:0.1:100]

/* [Bottom Edge] */

// Radius of the rounded outside bottom edge (mm), independent of the top treatment above. With Hollow enabled, it is limited to preserve the wall.
bottom_edge_radius = 8; // [0:0.1:100]

/* [Hidden] */

curve_fn = 128;
edge_segments = 16;
dome_segments = 48;
epsilon = 0.02;

function arc_points(cx, cz, rx, rz, start_angle, end_angle, segments) =
    (rx <= 0.001 || rz <= 0.001)
        ? []
        : [
            for (i = [0 : segments])
                let(angle = start_angle + (end_angle - start_angle) * i / segments)
                [cx + rx * cos(angle), cz + rz * sin(angle)]
        ];

// Flat-topped (or top-edge-filleted) outer revolve profile.
module rounded_outer_body(radius, height, top_radius, bottom_radius) {
    bottom_arc = arc_points(
        radius - bottom_radius, bottom_radius, bottom_radius, bottom_radius,
        270, 360, edge_segments
    );
    top_arc = arc_points(
        radius - top_radius, height - top_radius, top_radius, top_radius,
        0, 90, edge_segments
    );

    profile = concat(
        [[0, 0]],
        bottom_radius <= 0.001 ? [[radius, 0]] : bottom_arc,
        top_radius <= 0.001 ? [[radius, height]] : top_arc,
        [[0, height]]
    );

    rotate_extrude(convexity = 10, $fn = curve_fn)
        polygon(profile);
}

// Outer revolve profile for the domed-top body: a straight-sided cylinder up
// to `height`, capped by a quarter-ellipse dome of height `dome_h` above it,
// with the same optional rounded bottom edge as the flat-topped body.
module domed_outer_body(radius, height, dome_h, bottom_radius) {
    bottom_arc = arc_points(
        radius - bottom_radius, bottom_radius, bottom_radius, bottom_radius,
        270, 360, edge_segments
    );
    dome_arc = arc_points(0, height, radius, dome_h, 0, 90, dome_segments);

    profile = concat(
        [[0, 0]],
        bottom_radius <= 0.001 ? [[radius, 0]] : bottom_arc,
        dome_h <= 0.001 ? [[radius, height], [0, height]] : dome_arc
    );

    rotate_extrude(convexity = 10, $fn = curve_fn)
        polygon(profile);
}

module cylinder_family() {
    diameter = max(outer_diameter, 0.2);
    height = max(model_height, 0.2);
    radius = diameter / 2;
    // Leave a small positive inner radius even when a wall request is too large.
    safe_wall = min(max(wall_thickness, 0.2), max(radius - 0.01, 0.01));
    inner_radius = max(radius - safe_wall, 0.01);

    if (wall_thickness > safe_wall && hollow)
        echo(str("Wall Thickness limited from ", wall_thickness, " mm to ", safe_wall, " mm."));

    bottom_limit = hollow ? min(radius, safe_wall * 0.49) : radius;
    bottom_initial = min(max(bottom_edge_radius, 0), bottom_limit);

    // A domed cap over a Hollow body would need to bridge solid material
    // over the open cavity with no support underneath it, and that support
    // could never be removed once printed. So Hollow always falls back to
    // Top Edge Fillet, regardless of the requested Top Surface Style.
    effective_top_surface_style = hollow ? 2 : top_surface_style;
    if (top_surface_style == 1 && hollow)
        echo("Domed Surface is not available with Hollow (it would trap an unsupported bridge inside a sealed cavity); using Top Edge Fillet instead.");

    if (effective_top_surface_style == 2) {
        // Top Edge Fillet: top and bottom fillets share the body height, so
        // an oversized request from either side is scaled down together.
        top_limit = hollow ? min(radius, safe_wall * 0.49) : radius;
        top_initial = min(max(top_edge_radius, 0), top_limit);
        radius_sum = top_initial + bottom_initial;
        height_scale = radius_sum > 0
            ? min(1, max(height - 0.01, 0.001) / radius_sum)
            : 1;
        safe_top_radius = top_initial * height_scale;
        safe_bottom_radius = bottom_initial * height_scale;

        if (top_edge_radius > safe_top_radius)
            echo(str("Top Edge Radius limited from ", top_edge_radius, " mm to ", safe_top_radius, " mm."));
        if (bottom_edge_radius > safe_bottom_radius)
            echo(str("Bottom Edge Radius limited from ", bottom_edge_radius, " mm to ", safe_bottom_radius, " mm."));

        if (hollow) {
            difference() {
                rounded_outer_body(radius, height, safe_top_radius, safe_bottom_radius);
                translate([0, 0, -epsilon])
                    cylinder(r = inner_radius, h = height + 2 * epsilon, $fn = curve_fn);
            }
        } else {
            // The fully enclosed seed makes OpenSCAD weld the rotate_extrude seam
            // through its boolean mesh path without changing the outside shape.
            union() {
                rounded_outer_body(radius, height, safe_top_radius, safe_bottom_radius);
                translate([0, 0, height / 2])
                    sphere(r = min(radius, height) / 1000, $fn = 8);
            }
        }
    } else {
        // Domed Surface (solid only): only the bottom fillet consumes body
        // height, since the dome adds its own height above the body.
        safe_bottom_radius = min(bottom_initial, max(height - 0.01, 0.001));
        if (bottom_edge_radius > safe_bottom_radius)
            echo(str("Bottom Edge Radius limited from ", bottom_edge_radius, " mm to ", safe_bottom_radius, " mm."));
        dome_h = max(dome_height, 0);

        union() {
            domed_outer_body(radius, height, dome_h, safe_bottom_radius);
            translate([0, 0, height / 2])
                sphere(r = min(radius, height) / 1000, $fn = 8);
        }
    }
}

// Force the same welded CGAL mesh path for both solid and hollow variants.
render(convexity = 10)
    cylinder_family();
