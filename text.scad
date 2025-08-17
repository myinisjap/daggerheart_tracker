// text.scad
//
// This is the main entry point for the Text OpenSCAD model.
// It includes user-configurable parameters and the core logic from text/main.scad.

/* [General] */
// Which text to generate?
text_to_generate = "HP"; // ["HP", "Hope", "Armor", "Stress", "All"]

/* [Text Properties] */
text_depth = 3.5; // Depth of the extruded text
text_size = 8; // Font size of the text

/* [Font] */
// Which font to use?
text_font = "Times New Roman"; // ["Liberation Sans", "Arial", "Helvetica", "Times New Roman", "Courier New", "Verdana"] Font family for the text
use_bold = false; // [boolean] Whether to use bold style for text
use_italic = false; // [boolean] Whether to use italic style for text

include <src/text_main.scad>