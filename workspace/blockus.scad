// Hello world for Openscad

unit = 15;

n = 14;
gap = 3.3;
height = 20;
wall = 2;
thickness = 3;


board();
// color("yellow") box();

translate([0,0, 20])
piece();

// ######################################################################"

module plate() {
	cube (size = [unit * n, unit * n, thickness]);
}

module base () {

	translate([0, 0, thickness]) 
	linear_extrude(thickness)
	for (i = [0: n - 1]) {
		for (j = [0: n - 1]) {
		
			translate([i * unit + gap/ 2, j * unit + gap / 2, 0]) 
			square(size = [unit - gap, unit - gap]);
		}
	}

	plate();
}

module board () {
	difference () {
		base();
		
		translate([unit / 2 + 4 * unit, unit / 2 + 4 * unit, thickness + 0.1]) 
		cylinder(r=2, h = thickness, $fn = 36); 

		translate([unit / 2 + (n - 5) * unit, unit / 2 + (n - 5) * unit, thickness + 0.1]) 
		cylinder(r=2, h = thickness, $fn = 36); 
	}
}

module piece () {
	difference() {
	
		rounding = 2;
		
		translate([rounding, rounding, 0])
		minkowski() {
			cube(size = [unit - rounding * 2, unit - rounding * 2, 2]);
			sphere(r= rounding, $fn=36);
		}
		translate([- rounding, -rounding, -2])
		cube(size = [unit * 2  , unit * 2, 2]);
		
		translate([1, 1, -0.1])
		cube(size = [unit - 2 , unit - 2, 2]);
	}
}

module box () {

difference () {
		translate([-wall, 0, - height + 4 - 0.1])
		cube(size = [unit * n + 2 * wall, unit * n + 2 * wall, height]);
		
		# union(){
			cube (size = [unit * n, unit * n, 2]);
			
			translate([0, 0, 2])
			cube (size = [unit * n - gap, unit * n - gap, 3]);
		}
	}
}