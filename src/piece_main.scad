// pawn/main.scad
//
// This is the main logic file for the Pawn model.
// It includes configuration and profile functions, then renders the 3D object.


include <profile_functions.scad>

union() {
    // The new peg cylinder
    cylinder(h = peg_height, d = base_diameter, $fn=50);

    // The existing pawn shape, translated upwards
    translate([0, 0, peg_height]) {
        rotate_extrude(convexity = 10, $fn = 100) {
            pawn_profile();
        }
    }
}
