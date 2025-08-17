// pawn/profile_functions.scad
//
// This file contains functions for generating Bezier curves and the 2D profile of the pawn.

// Bezier curve functions
function bezier_cubic(p0, p1, p2, p3, t) = 
    pow(1-t, 3) * p0 + 
    3 * pow(1-t, 2) * t * p1 + 
    3 * (1-t) * pow(t, 2) * p2 + 
    pow(t, 3) * p3;

function bezier_points(p0, p1, p2, p3, steps=20) = 
    [for (i = [0:steps]) bezier_cubic(p0, p1, p2, p3, i/steps)];

module pawn_profile() {
    head_height = head_diameter / 2;
    pawn_height = base_height + stem_height + head_height;

    // Points for the base curve
    p0_base = [base_diameter / 2, 0];
    p1_base = [base_diameter / 2, base_height * 0.5]; // Control point 1
    p2_base = [stem_diameter / 2 + 2, base_height * 0.8]; // Control point 2
    p3_base = [stem_diameter / 2, base_height];

    // Points for the stem (straight line)
    p0_stem = p3_base;
    p1_stem = [stem_diameter / 2, base_height + stem_height];

    // Points for the head/neck curve
    p0_head = p1_stem;
    p1_head = [stem_diameter / 2, base_height + stem_height + head_height * 0.2]; // Control point 1
    p2_head = [head_diameter / 2, base_height + stem_height + head_height * 0.5]; // Control point 2
    p3_head = [0, pawn_height];

    // Generate points for the profile
    profile_points = concat(
        [[0, 0]], // Start at origin
        bezier_points(p0_base, p1_base, p2_base, p3_base, steps=20),
        // Add points for the stem (straight line)
        [p1_stem], // End of stem
        bezier_points(p0_head, p1_head, p2_head, p3_head, steps=20)
    );
    
    polygon(profile_points);
}
