/*
  Parametric heart model
  Parameters are grouped and described for the MakerWorld Customizer.
*/

/* [Shape and Size] */

// Overall width of the heart (mm).
heart_size = 60; // [3:300]

// Body height (mm). The Domed option adds Dome Height above this value; Top Edge Fillet keeps this as the total height.
wall_thickness = 5; // [0.2:0.2:50]

/* [Top Surface] */

// Top treatment: Domed Surface curves the entire top face; Top Edge Fillet keeps the center flat and rounds only the upper perimeter.
top_surface_style = 1; // [1:Domed Surface, 2:Top Edge Fillet]

// Dome height above the body (mm). Used only when Top Surface Style is Domed.
surface_thickness = 1.5; // [0:0.1:50]

// Radius of the rounded upper perimeter (mm). Used only when Top Surface Style is Top Edge Fillet.
// Oversized values are automatically limited by the body height and heart size.
top_edge_fillet_radius = 3; // [0:0.1:50]

/* [Bottom Tip] */

// Rounding at the pointed end (% of Heart Size). Example: 2.5 means 2.5% of the overall width.
tip_fillet_percent = 2.5; // [0:0.1:20]

/* [Hidden] */

// Keep small models smooth by maintaining minimum curve resolution.
min_tip_fillet_radius = 0;
min_tip_fillet_fn = 48;

point_count = 120;
tip_cut_y = -11.0;
tip_width_scale = 1.0;
fillet_fn = 24;
dome_shrink_exponent = 2; // >1 = shrink accelerates toward the top (exponential-like)
top_edge_fillet_layers = 32;

function heart_x(t) = 16 * pow(sin(t), 3);
function heart_y(t) = 13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t);
function heart_point(t) = [heart_x(t), heart_y(t)];

// Precisely locates where the right-hand curve (t in [90,180]) crosses
// y = target_y, using linear interpolation between two very close samples.
// This lands exactly on the curve, so the straight tip lines join it
// with no kink/seam.
function right_crossing(target_y, steps = 2000) =
    let (
        hits = [
            for (i = [0:steps - 1])
                let (
                    t0 = 90 + i * 90 / steps,
                    t1 = 90 + (i + 1) * 90 / steps,
                    y0 = heart_y(t0),
                    y1 = heart_y(t1)
                )
                if (y0 >= target_y && y1 <= target_y) [t0, t1, y0, y1]
        ],
        h = hits[0],
        frac = (h[2] - target_y) / (h[2] - h[3]),
        x0 = heart_x(h[0]),
        x1 = heart_x(h[1])
    ) x0 + frac * (x1 - x0);

module heart_shape() {
    tip_half_width = right_crossing(tip_cut_y) * tip_width_scale;
    right_anchor = [ tip_half_width, tip_cut_y ];
    left_anchor = [ -tip_half_width, tip_cut_y ];

    // dy == |dx| on both sides guarantees a 90-degree included angle at the tip.
    tip = [0, tip_cut_y - tip_half_width];

    right_side = [
        for (i = [0:point_count])
            let (
                t = i * 180 / point_count,
                p = heart_point(t)
            )
            if (p[1] >= tip_cut_y) p
    ];

    left_side = [
        for (i = [0:point_count])
            let (
                t = 180 + i * 180 / point_count,
                p = heart_point(t)
            )
            if (p[1] >= tip_cut_y) p
    ];

    points = concat(right_side, [right_anchor, tip, left_anchor], left_side);
    polygon(points);
}


// Scale the flat 2D outline to the requested overall size.
module heart_shape_scaled() {
    scale([heart_size / 32, heart_size / 32])
        heart_shape();
}

// Rounds only the sharp 90-degree tip corner in 2D (grow then shrink by the
// same radius), keeping the overall footprint size unchanged.
module heart_outline_rounded() {
    tip_radius = max(heart_size * tip_fillet_percent / 100, min_tip_fillet_radius);
    tip_fn = max(min_tip_fillet_fn, round(heart_size * 0.8));

    offset(r = tip_radius, $fn = tip_fn)
        offset(r = -tip_radius, $fn = tip_fn)
            heart_shape_scaled();
}

// Builds the domed top as a stack of thin, directly-stacked layers whose
// outline keeps shrinking inward as height increases (no hull() between
// layers - hull() always produces a CONVEX envelope, which would silently
// erase the heart's top notch no matter how small the shrink amount is).
// Direct stacking keeps each layer's own outline - including the notch -
// intact, so the WHOLE face curves while the notch stays visible.
// Vertical resolution of the domed surface. Higher values reduce visible
// stepping while preserving the heart notch at every layer.
dome_layers = 64;

module heart_dome() {
    dome_reach = heart_size * 0.20;
    rz = max(surface_thickness, 0.01);

    for (i = [0 : dome_layers - 1]) {
        frac0 = i / dome_layers;
        frac1 = (i + 1) / dome_layers;
        inset0 = dome_reach * pow(frac0, dome_shrink_exponent);
        z0 = rz * sin(90 * frac0);
        z1 = rz * sin(90 * frac1);
        translate([0, 0, z0])
            linear_extrude(height = (z1 - z0) + 0.01)
                offset(r = -inset0) heart_outline_rounded();
    }
}

// Builds a flat-topped body with a quarter-round fillet along only the upper
// perimeter. Layered inward offsets preserve the concave notch of the heart,
// unlike a convex hull. The fillet is cut into the body, so wall_thickness
// remains the total model height in this mode.
module heart_top_edge_fillet() {
    requested_radius = max(top_edge_fillet_radius, 0);
    max_safe_radius = min(wall_thickness, heart_size * 0.20);
    radius = min(requested_radius, max_safe_radius);

    if (requested_radius > max_safe_radius)
        echo(str(
            "Top Edge Fillet Radius limited from ", requested_radius,
            " mm to ", max_safe_radius, " mm for this model size."
        ));

    if (radius <= 0.001) {
        linear_extrude(height = wall_thickness)
            heart_outline_rounded();
    } else {
        straight_height = wall_thickness - radius;

        if (straight_height > 0)
            linear_extrude(height = straight_height + 0.01)
                heart_outline_rounded();

        for (i = [0 : top_edge_fillet_layers - 1]) {
            frac0 = i / top_edge_fillet_layers;
            frac1 = (i + 1) / top_edge_fillet_layers;
            inset0 = radius * (1 - cos(90 * frac0));
            z0 = straight_height + radius * sin(90 * frac0);
            z1 = straight_height + radius * sin(90 * frac1);

            translate([0, 0, z0])
                linear_extrude(height = (z1 - z0) + 0.01)
                    offset(r = -inset0)
                        heart_outline_rounded();
        }
    }
}

// Builds the selected top treatment. Domed is the legacy behavior and stays
// the default so existing presets and command lines remain compatible.
module heart_model() {
    if (top_surface_style == 2)
        heart_top_edge_fillet();
    else
        union() {
            linear_extrude(height = wall_thickness)
                heart_outline_rounded();

            translate([0, 0, wall_thickness])
                heart_dome();
        }
}

heart_model();
