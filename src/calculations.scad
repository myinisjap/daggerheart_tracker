// tracker/calculations.scad
//
// This file contains calculations for dimensions and positions based on user-defined parameters.

// Construct the font string with style for OpenSCAD text function
style_string = use_bold ? (use_italic ? "Bold Italic" : "Bold") : (use_italic ? "Italic" : "");
font_with_style = str(text_font, style_string == "" ? "" : ":style=", style_string);

// Parse row_hole_counts string into an array of integers
hole_counts = [for(s = str_split(row_hole_counts, ",")) parse_int(s)];
num_rows = len(hole_counts);

// Calculate dimensions for the hole pattern
pattern_height = num_rows * hole_diameter + (num_rows - 1) * spacing_y;
max_hole_row_width = max([for (num_holes = hole_counts) num_holes * hole_diameter + (num_holes - 1) * spacing_x]);

// Calculate overall box dimensions
box_depth = pattern_height + 2 * outer_border;

// Calculate dynamic text area width based on longest label
// This calculation attempts to approximate the width needed for the text labels.
calculated_text_area_width = 
    (use_bold == true && use_italic == true) ? max(max([for (t = str_split(text_labels, ",")) len(t)]) * (text_size * 0.80), 20) :
    (use_italic == true) ? max(max([for (t = str_split(text_labels, ",")) len(t)]) * (text_size * 0.75), 20) :
    max(max([for (t = str_split(text_labels, ",")) len(t)]) * (text_size * 0.70), 20);

box_width = calculated_text_area_width + label_to_hole_spacing + max_hole_row_width + (2 * outer_border);

// Margins and starting positions
margin_y_start = outer_border;
text_area_center_x = outer_border + (calculated_text_area_width / 2);
hole_area_start_x = calculated_text_area_width + label_to_hole_spacing;

// Y-positions for text and holes, from top to bottom
row_step_y = hole_diameter + spacing_y;
y_positions = [ for (i=[0:num_rows-1]) margin_y_start + hole_diameter / 2 + (num_rows - 1 - i) * row_step_y ];

// Parse text_labels string into an array of strings
texts = str_split(text_labels, ",");
