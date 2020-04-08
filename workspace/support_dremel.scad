/*
 * Support Dremel
 */
 
$fn = 36;
entraxe_bottom = 20;
entraxe_top = 45.5;

entraxe_vertical = 74.5;
slack = 0.5;
height = 26;
hole_dia = 3;
thickness = 3;
width_top = entraxe_top + 20;
width_bottom = entraxe_bottom + 20;
round = 4;

/**
 * A plate potentially with rounded corners
 */
module plate (size = [1, 2, 3], rounding = 1, center = false) {
	
	translation = (center) ? 0 : rounding;
	
	translate([translation, translation, 0])
	linear_extrude(size[2])
	offset(r = rounding)
	square (size = [size[0] - rounding *2, size[1] - rounding * 2], center = center);
}

/**
 * A plate potentially with rounded corners
 * and two holes
 */
module two_holes_plate (size = [1, 2, 3], rounding = 1, center = false, distance = 10, hole_dia = 5) {

	difference () {
		plate(size = size, rounding = rounding, center = center);
		
		x_trans = (center) ? 0 : size[0]; 
		y_translation = (center) ? 0 : size[1] / 2;
		z_translation = (center) ? size[2] / 2  : - thickness / 2;
		
		translate([(x_trans - distance) / 2, y_translation, z_translation])
		cylinder(h = thickness * 2, d = hole_dia, center = center);

		translate([(x_trans + distance) / 2, y_translation, z_translation])
		cylinder(h = thickness * 2, d = hole_dia, center = center);
	}
}

/*
 * generate the base shape of a H letter
 */
module hache () {
	translate([0, entraxe_vertical, 0])
	two_holes_plate([width_top, height, thickness], rounding = round, center = true, distance = entraxe_top / 2, hole_dia=3 + slack);
	two_holes_plate([width_bottom, height, thickness], rounding = round, center = true, distance = entraxe_bottom / 2, hole_dia=3 + slack);
	
	len = entraxe_vertical - height + 0.2;
	translate([0, (len + height) / 2  - 0.1, 0])
	linear_extrude(thickness)
	square(size = [height, len], center = true);
}

hache();
