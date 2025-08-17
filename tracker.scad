// tracker.scad
//
// This is the main entry point for the Daggerheart Tracker OpenSCAD model.
// It includes user-configurable parameters and the core logic from tracker/main.scad.

include <src/BOSL2/std.scad>
use <src/BOSL2/strings.scad>

/* [Box] */
box_height = 6; // Height of the main box
fillet_radius = 1; // Radius for the filleted edges of the box
outer_border = 5; // Space around the entire content (holes + labels)
label_to_hole_spacing = 5; // Space between the longest label and the closest hole

/* [Grid of Holes] */
hole_diameter = 12; // Diameter of each hole
hole_depth = 3.5; // Depth of each hole
row_hole_counts = "6,12,12,12"; // Comma-separated string of hole counts for each row (e.g., "12,12,12,6")
spacing_x = 1; // Horizontal spacing between holes in a row
spacing_y = 3; // Vertical spacing between rows of holes

/* [Row Labels] */
text_depth = 2.5; // Depth of the engraved text labels
text_size = 8; // Font size for the text labels
text_font = "Times New Roman"; // ["Liberation Sans", "Arial", "Helvetica", "Times New Roman", "Courier New", "Verdana"] Font family for the text labels
text_labels = "Hope,HP,Stress,Armor"; // Comma-separated string of labels for each row
use_bold = true; // [boolean] Whether to use bold style for text
use_italic = false; // [boolean] Whether to use italic style for text

/* [Numbers in Holes] */
show_numbers = true; // [boolean] Whether to engrave numbers inside the holes
number_size = 4; // Font size for the numbers
number_depth = 1.5; // Depth of the engraved numbers

include <src/calculations.scad>
include <src/tracker_main.scad>
