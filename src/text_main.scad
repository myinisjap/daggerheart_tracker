// text/main.scad
//
// This is the main logic file for the Text model.
// It includes configuration and then renders the 3D text object.



// --- Helper Modules ---
// Construct the font string with style
style_string = use_bold ? (use_italic ? "Bold Italic" : "Bold") : (use_italic ? "Italic" : "");
font_with_style = str(text_font, style_string == "" ? "" : ":style=", style_string);

module generate_text(text_string) {
    linear_extrude(height = text_depth + 0.01) {
        text(text_string, size = text_size, font = font_with_style, halign = "center", valign = "center");
    }
}

// --- Main ---
if (text_to_generate == "All") {
    // Arrange the text objects in a line
    translate([-60, 0, 0]) generate_text("HP");
    translate([-30, 0, 0]) generate_text("Hope");
    translate([10, 0, 0]) generate_text("Armor");
    translate([50, 0, 0]) generate_text("Stress");
} else {
    generate_text(text_to_generate);
}
