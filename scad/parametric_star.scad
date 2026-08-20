/*
  Parametric five-point star for MakerWorld Customizer
  Parameters are grouped and described for the MakerWorld Customizer.
*/

/* [Shape and Size] */

// Outer tip-circle diameter of the star (mm).
star_size = 60; // [3:300]

// Inner valley radius as a percentage of the outer tip radius. Lower values make longer, sharper points.
inner_radius_percent = 45; // [20:1:80]

// Body height (mm). Faceted Apex adds Apex Height above this value; Top Edge Fillet keeps this as the total height.
wall_thickness = 5; // [0.2:0.2:50]

/* [Top Surface] */

// Top treatment: Faceted Apex forms flat triangular faces meeting at the center; Top Edge Fillet keeps the center flat.
top_surface_style = 1; // [1:Faceted Apex, 2:Top Edge Fillet]

// Height from the body to the center apex (mm). Set to 0 for a flat top. Used only with Faceted Apex.
apex_height = 7.2; // [0:0.1:50]

// Radius of the rounded upper perimeter (mm). Used only with Top Edge Fillet.
// Oversized values are automatically limited by the body height and star size.
top_edge_fillet_radius = 3; // [0:0.1:50]

/* [Outline] */

// Rounding of the five outer points (% of Star Size). Set to 0 for sharp points.
corner_rounding_percent = 0; // [0:0.1:20]

/* [Hidden] */

star_point_count = 10;
curve_fn = 48;
top_edge_fillet_layers = 32;
apex_scale = 0.001;

function star_radius(index) =
    index % 2 == 0
        ? star_size / 2
        : star_size * inner_radius_percent / 200;

function star_point(index) =
    let (
        angle = 90 + index * 360 / star_point_count,
        radius = star_radius(index)
    ) [radius * cos(angle), radius * sin(angle)];

function star_points() = [for (i = [0 : star_point_count - 1]) star_point(i)];

module star_outline_sharp() {
    polygon(star_points());
}

// Rounds the convex outer points while preserving the five inner valleys.
module star_outline() {
    requested_radius = max(star_size * corner_rounding_percent / 100, 0);
    max_safe_radius = star_size * 0.20;
    radius = min(requested_radius, max_safe_radius);

    if (radius <= 0.001)
        star_outline_sharp();
    else
        offset(r = radius, $fn = curve_fn)
            offset(r = -radius, $fn = curve_fn)
                star_outline_sharp();
}

// Creates planar roof facets by shrinking the complete star outline almost
// to a point in a single extrusion slice. Concave valleys and rounded outline
// segments are preserved instead of being filled by a convex hull.
module star_faceted_apex() {
    if (apex_height <= 0.001)
        linear_extrude(height = wall_thickness)
            star_outline();
    else
        union() {
            linear_extrude(height = wall_thickness + 0.01)
                star_outline();

            translate([0, 0, wall_thickness])
                linear_extrude(
                    height = apex_height,
                    scale = apex_scale,
                    slices = 1,
                    convexity = 10
                )
                    star_outline();
        }
}

// Creates a quarter-round fillet along only the upper perimeter. The center
// remains flat and wall_thickness remains the total model height.
module star_top_edge_fillet() {
    requested_radius = max(top_edge_fillet_radius, 0);
    max_safe_radius = min(wall_thickness, star_size * 0.08);
    radius = min(requested_radius, max_safe_radius);

    if (requested_radius > max_safe_radius)
        echo(str(
            "Top Edge Fillet Radius limited from ", requested_radius,
            " mm to ", max_safe_radius, " mm for this model size."
        ));

    if (radius <= 0.001) {
        linear_extrude(height = wall_thickness)
            star_outline();
    } else {
        straight_height = wall_thickness - radius;

        if (straight_height > 0)
            linear_extrude(height = straight_height + 0.01)
                star_outline();

        for (i = [0 : top_edge_fillet_layers - 1]) {
            frac0 = i / top_edge_fillet_layers;
            frac1 = (i + 1) / top_edge_fillet_layers;
            inset0 = radius * (1 - cos(90 * frac0));
            z0 = straight_height + radius * sin(90 * frac0);
            z1 = straight_height + radius * sin(90 * frac1);

            translate([0, 0, z0])
                linear_extrude(height = (z1 - z0) + 0.01)
                    offset(r = -inset0)
                        star_outline();
        }
    }
}

module star_model() {
    if (top_surface_style == 2)
        star_top_edge_fillet();
    else
        star_faceted_apex();
}

star_model();
