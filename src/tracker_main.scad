// tracker/main.scad
//
// This is the main file for the Daggerheart Tracker OpenSCAD model.
// It includes configuration and calculation files, then renders the 3D object.

include <BOSL2/std.scad>
use <BOSL2/strings.scad>



// Include calculated dimensions and positions
include <calculations.scad>


// --- Module Definitions ---

// Module to create a single hole
module create_hole(x, y) {
    translate([x, y, box_height - hole_depth]) {
        cylinder(h = hole_depth + 0.01, d = hole_diameter, $fn = 50);
    }
}

// Module to create a single text label
module create_text_label(text_content, y_pos) {
    translate([text_area_center_x, y_pos, box_height - text_depth]) {
        linear_extrude(height = text_depth + 0.01) {
            text(text_content, size = text_size, font = font_with_style, halign = "center", valign = "center");
        }
    }
}

// Module to create a single number inside a hole
module create_number_in_hole(number_content, x, y) {
    translate([x, y, box_height - hole_depth - number_depth]) {
        linear_extrude(height = number_depth + 0.02) {
            text(str(number_content), size = number_size, font = font_with_style, halign = "center", valign = "center");
        }
    }
}


// --- Main Body ---

difference() {
    // The main box with filleted edges
    translate([box_width/2, box_depth/2, box_height/2]) {
        minkowski() {
            cube([box_width - 2 * fillet_radius, box_depth - 2 * fillet_radius, box_height - 2 * fillet_radius], center=true);
            sphere(r = fillet_radius, $fn=50);
        }
    }

    // Create the holes and text
    union() {
        // Create the grid of holes based on row_hole_counts
        for (row = [0 : num_rows - 1]) {
            num_holes_in_row = hole_counts[row];
            pattern_width_row = num_holes_in_row * hole_diameter + (num_holes_in_row - 1) * spacing_x;
            // Center each row in the area to the right of the text
            row_start_x = hole_area_start_x + ((box_width - hole_area_start_x) - pattern_width_row) / 2;
            y = y_positions[row];
            
            for (col = [0 : num_holes_in_row - 1]) {
                x = row_start_x + hole_diameter / 2 + col * (hole_diameter + spacing_x);
                create_hole(x, y);
            }
        }

        // Recessed text, aligned with hole rows
        for (i = [0 : len(texts) - 1]) {
            if (i < len(y_positions)) {
                create_text_label(texts[i], y_positions[i]);
            }
        }

        // Numbers for the grid
        if (show_numbers) {
            for (row = [0 : num_rows - 1]) {
                num_holes_in_row = hole_counts[row];
                pattern_width_row = num_holes_in_row * hole_diameter + (num_holes_in_row - 1) * spacing_x;
                row_start_x = hole_area_start_x + ((box_width - hole_area_start_x) - pattern_width_row) / 2;
                y = y_positions[row];

                for (col = [0 : num_holes_in_row - 1]) {
                    x = row_start_x + hole_diameter / 2 + col * (hole_diameter + spacing_x);
                    create_number_in_hole(col + 1, x, y);
                }
            }
        }
    }
}
