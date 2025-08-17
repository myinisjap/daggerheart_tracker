// pawn.scad
//
// This is the main entry point for the Pawn OpenSCAD model.
// It includes user-configurable parameters and the core logic from pawn/main.scad.

/* [Pawn Dimensions] */
base_diameter = 11.9; // Diameter of the pawn's base
base_height = 8; // Height of the pawn's base
stem_diameter = 4; // Diameter of the pawn's stem
stem_height = 5; // Height of the pawn's stem
head_diameter = 8; // Diameter of the pawn's head
peg_height = 3; // Height of the peg extending from the base

include <src/piece_main.scad>