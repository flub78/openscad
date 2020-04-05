/* Project enclosure
 *
 * Small parametric box with a cover
 */

length = 30;	
width = 20;		
total_height = 15;
cover_height = 2;
rounding = 2;
wall = 2;
slack = 0.25;
screw_dia = 1;
screw_len = 5;

$fn = 60;


/*
 * A rounded cube
 */
module rounded_cube(size = [1, 1, 1], center=true, rounding = 1) {
	minkowski() {
		cube (size, center=center);
		sphere(r=rounding);
	}
}

module screw_cylinder(height, dia, screw_dia, screw_len) {
	difference () {
		cylinder( h = height, r = dia, center = true);
		translate([0, 0, height - screw_len])
		#cylinder( h = height, r = screw_dia, center = true);
	}
}

/*
 * The module to generate bottom or cover
 *
 * $param boolean cover when true generate the cover, when false generate the bottom
 */
module box (cover=false, screws = false) {

	difference () {
		difference () {
			rounded_cube([length, width , total_height], center=true, rounding = rounding);
	
			// cut the separation for bottom or cover
			cut_place = (cover) ? - cover_height : total_height - cover_height;
				translate ([0,0, cut_place])
					cube([2 * length, 2 * width, total_height], center=true);
		}

		// dig the interior
		rounded_cube ([length - rounding - wall, width -rounding - wall, total_height - rounding - wall], center=true, rounding = rounding);
		
		// dig the lid
		translate ([0, 0, total_height  / 2 - cover_height])
			linear_extrude(height = wall, center = true)
			minkowski() {
				square([length , width ],center=true);
				circle(rounding / 2);
			}
		
		
	}
	
	if (screws) {
		
		cyl_height = (cover) ?  cover_height + rounding  + 1: total_height - cover_height;
		cyl_z = (cover) ? total_height / 2 - wall / 2 + 0.5: - wall;
		sc_len = (cover) ? cyl_height : screw_len;
		
		translate ([length / 2 - wall, width / 2 - wall, cyl_z])
			screw_cylinder(cyl_height, rounding, screw_dia, sc_len);

		translate ([length / 2 - wall, -(width / 2 - wall), - wall])
			screw_cylinder(cyl_height, rounding, screw_dia, sc_len);

		translate ([-(length / 2 - wall), width / 2 - wall, - wall])
			screw_cylinder(cyl_height, rounding, screw_dia, sc_len);

		translate ([-(length / 2 - wall), -(width / 2 - wall), - wall])
			screw_cylinder(cyl_height, rounding, screw_dia, sc_len);
			
	}
	
	if (cover) {
		// generate the lid
		difference () {
			translate ([0, 0, total_height  / 2 - cover_height])
				linear_extrude(height = wall, center = true)
				minkowski() {
					square([length - slack, width - slack],center=true);
					circle(rounding / 2);
				}
			
			// dig the interior
			rounded_cube ([length - rounding - wall, width -rounding - wall, total_height - rounding - wall], 
				center=true, rounding=rounding);
		}
	}
}

/*
// A small scale
translate([length / 2 + 1, width/2 + 1, 0])
color("red")
cube ([1, 1, total_height + 0.1] ,center=true);
*/

translate ([0, 0, 15]) box(cover=true, screws=true);
box(cover=false, screws=true);