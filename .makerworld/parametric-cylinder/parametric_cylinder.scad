/*
  Parametric solid cylinder for MakerWorld Customizer

  The default is a solid cylinder. An optional centered through-hole turns it
  into a hollow cylinder. Rounded edges are formed in the radial cross-section,
  so the bottom always remains on Z=0 and the model is ready to print.
*/

/* [Overall Size] */

// Outside diameter (mm).
outer_diameter = 60; // [3:300]

// Total height (mm).
model_height = 24; // [0.2:0.2:300]

/* [Optional Hollow Center] */

// Enable a centered hole through the full height. Disabled by default for a solid cylinder.
hollow = false; // [false, true]

// Radial wall thickness when Hollow is enabled (mm). Oversized values are automatically limited.
wall_thickness = 3; // [0.2:0.1:100]

/* [Outer Edge Rounding] */

// Radius of the rounded outside top edge (mm). With Hollow enabled, it is limited to preserve the wall.
top_edge_radius = 0; // [0:0.1:100]

// Radius of the rounded outside bottom edge (mm). With Hollow enabled, it is limited to preserve the wall.
bottom_edge_radius = 0; // [0:0.1:100]

/* [Hidden] */

curve_fn = 128;
edge_segments = 16;
epsilon = 0.02;

function arc_points(cx, cz, radius, start_angle, end_angle, segments) =
    radius <= 0.001
        ? []
        : [
            for (i = [0 : segments])
                let(angle = start_angle + (end_angle - start_angle) * i / segments)
                [cx + radius * cos(angle), cz + radius * sin(angle)]
        ];

module rounded_outer_body(radius, height, top_radius, bottom_radius) {
    bottom_arc = arc_points(
        radius - bottom_radius,
        bottom_radius,
        bottom_radius,
        270,
        360,
        edge_segments
    );
    top_arc = arc_points(
        radius - top_radius,
        height - top_radius,
        top_radius,
        0,
        90,
        edge_segments
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

module cylinder_family() {
    diameter = max(outer_diameter, 0.2);
    height = max(model_height, 0.2);
    radius = diameter / 2;
    // Leave a small positive inner radius even when a wall request is too large.
    safe_wall = min(max(wall_thickness, 0.2), max(radius - 0.01, 0.01));
    inner_radius = max(radius - safe_wall, 0.01);

    top_limit = hollow ? min(radius, safe_wall * 0.49) : radius;
    bottom_limit = hollow ? min(radius, safe_wall * 0.49) : radius;
    top_initial = min(max(top_edge_radius, 0), top_limit);
    bottom_initial = min(max(bottom_edge_radius, 0), bottom_limit);
    radius_sum = top_initial + bottom_initial;
    // Preserve a tiny straight section if both fillets would otherwise meet
    // at a duplicate profile point.
    height_scale = radius_sum > 0
        ? min(1, max(height - 0.01, 0.001) / radius_sum)
        : 1;
    safe_top_radius = top_initial * height_scale;
    safe_bottom_radius = bottom_initial * height_scale;

    if (wall_thickness > safe_wall && hollow)
        echo(str("Wall Thickness limited from ", wall_thickness, " mm to ", safe_wall, " mm."));
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
}

// Force the same welded CGAL mesh path for both solid and hollow variants.
render(convexity = 10)
    cylinder_family();
