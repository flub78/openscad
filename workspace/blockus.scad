// Blockus game

unit = 15;			// size of a square

n = 14;				// number of raw and col on the board

gap = 4;			// distance between two square plot
box_height = 20;
wall = 2;			// for the box
thickness = 3;		// of the plate, the plots, ...

rounding = 2;		// for the pieces
slack = 1;

// ######################################################################"

color("white")
board();
// color("yellow") box();

color("blue")
translate([0,0, 20])
piece_set ();

// ######################################################################"

/*
 *	The plate for the game board
 */
module plate() {
	cube (size = [unit * n, unit * n, thickness]);
}

/*
 * The base and the plots
 */
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

/*
 * The game board
 */
module board () {
	difference () {
		base();
		
		translate([unit / 2 + 4 * unit, unit / 2 + 4 * unit, thickness + 0.1]) 
		cylinder(r=2, h = thickness, $fn = 36); 

		translate([unit / 2 + (n - 5) * unit, unit / 2 + (n - 5) * unit, thickness + 0.1]) 
		cylinder(r=2, h = thickness, $fn = 36); 
	}
}

/*
 * One unit for the piece
 */
module piece () {
	
	// a piece = unit x unit x (thickness + rounding)
	
	difference() {
	
		translate([rounding, rounding, 0])
		minkowski() {
			cube(size = [unit - rounding * 2, unit - rounding * 2, thickness]);
			sphere(r= rounding, $fn=36);
		}
		
		// cut the base
		translate([- rounding, -rounding, -thickness])
		cube(size = [unit * 2  , unit * 2, thickness]);
		
		// cut the interior
		translate([(gap - slack) / 2, (gap - slack) / 2, -0.1])
		cube(size = [unit - gap + slack , unit - gap + slack, thickness]);
	}
}

module I_2() {
	piece();
	translate ([unit, 0, 0]) piece();
}

// ------------------------------------------------
module I_3() {
	piece();
	translate ([unit, 0, 0]) piece();
	translate ([unit * 2, 0, 0]) piece();
}

module L_3() {
	piece();
	translate ([unit, 0, 0]) piece();
	translate ([unit, unit, 0]) piece();
}

// ------------------------------------------------
module I_4() {
	piece();
	translate ([unit, 0, 0]) piece();
	translate ([unit * 2, 0, 0]) piece();
	translate ([unit * 3, 0, 0]) piece();
}

module T_4() {
	piece();
	translate ([unit, 0, 0]) piece();
	translate ([unit * 2, 0, 0]) piece();
	translate ([unit , unit, 0]) piece();
}

module L_4() {
	piece();
	translate ([unit, 0, 0]) piece();
	translate ([unit * 2, 0, 0]) piece();
	translate ([unit * 2, unit, 0]) piece();
}

module S_4() {
	piece();
	translate ([unit, 0, 0]) piece();
	translate ([unit , unit, 0]) piece();
	translate ([unit * 2, unit, 0]) piece();
}

module square_4() {
	piece();
	translate ([unit, 0, 0]) piece();
	translate ([0, unit, 0]) piece();
	translate ([unit, unit, 0]) piece();
}

// ------------------------------------------------
module I_5() {
	piece();
	translate ([unit, 0, 0]) piece();
	translate ([unit * 2, 0, 0]) piece();
	translate ([unit * 3, 0, 0]) piece();
	translate ([unit * 4, 0, 0]) piece();
}

module L_5() {
	piece();
	translate ([unit, 0, 0]) piece();
	translate ([unit * 2, 0, 0]) piece();
	translate ([unit * 3, 0, 0]) piece();
	translate ([unit * 3, unit, 0]) piece();
}

module T_5() {
	piece();
	translate ([unit, 0, 0]) piece();
	translate ([unit * 2, 0, 0]) piece();
	translate ([unit , unit, 0]) piece();
	translate ([unit , unit * 2, 0]) piece();
}

module LL_5() {
	piece();
	translate ([unit, 0, 0]) piece();
	translate ([unit * 2, 0, 0]) piece();
	translate ([unit * 2, unit, 0]) piece();
	translate ([unit * 2, unit *2, 0]) piece();
}

module L_5() {
	piece();
	translate ([unit, 0, 0]) piece();
	translate ([unit * 2, 0, 0]) piece();
	translate ([unit * 3, 0, 0]) piece();
	translate ([unit * 0, unit * 1, 0]) piece();
}


module S_5() {
	piece();
	translate ([unit, 0, 0]) piece();
	translate ([unit , unit, 0]) piece();
	translate ([unit * 2, unit, 0]) piece();
	translate ([unit * 3, unit, 0]) piece();
}

module Z_5() {
	piece();
	translate ([unit * 0, unit, 0]) piece();
	translate ([unit * 1, unit, 1]) piece();
	translate ([unit * 2, unit, 0]) piece();
	translate ([unit * 2, unit * 2, 0]) piece();
}

module B_5() {
	piece();
	translate ([unit * 1, 0, 0]) piece();
	translate ([unit * 0, unit, 1]) piece();
	translate ([unit * 1, unit, 0]) piece();
	translate ([unit * 0, unit * 2, 0]) piece();
}

module P_5() {
	piece();
	translate ([unit * 0, unit, 0]) piece();
	translate ([unit * 1, unit, 1]) piece();
	translate ([unit * 1, unit * 2, 0]) piece();
	translate ([unit * 2, unit * 2, 0]) piece();
}

module C_5() {
	piece();
	translate ([unit * 1, 0, 0]) piece();
	translate ([unit * 0, unit, 1]) piece();
	translate ([unit * 0, unit * 2, 0]) piece();
	translate ([unit * 1, unit * 2, 0]) piece();
}

module F_5() {
	piece();
	translate ([unit * 0, unit, 0]) piece();
	translate ([- unit, unit, 1]) piece();
	translate ([unit * 0, unit * 2, 0]) piece();
	translate ([unit * 1, unit * 2, 0]) piece();
}

module Croix_5() {
	piece();
	translate ([unit * 0, unit, 0]) piece();
	translate ([- unit, unit, 1]) piece();
	translate ([unit * 0, unit * 2, 0]) piece();
	translate ([unit * 1, unit * 1, 0]) piece();
}

module M_5() {
	piece();
	translate ([unit * 1, 0, 0]) piece();
	translate ([unit * 2, 0, 1]) piece();
	translate ([unit * 3, unit * 0, 0]) piece();
	translate ([unit * 1, unit * 1, 0]) piece();
}


// ------------------------------------------------

module piece_set() {
	piece();
	
	translate ([unit * 1.5, 0, 0]) I_2();
	
	translate ([unit * 4, 0, 0]) I_3();
	
	translate ([unit * 7.5, 0, 0]) L_3();
	
	// ---------------------
	translate ([unit * 10, 0, 0]) square_4();
	
	translate ([0, unit * 1.5, 0]) I_4();
	
	translate ([unit * 4.5, unit * 1.5, 0]) T_4();

	translate ([unit * 9, unit * 2.5, 0]) L_4();
	
	translate ([unit * 2, unit * 3, 0]) rotate([0, 0, 90]) S_4();

    // ---------------------
	translate ([unit * 14, unit * 0, 0]) rotate([0, 0, 90]) I_5();
	
	translate ([unit * 14, unit * 11, 0]) rotate([0, 0, 90])  LL_5();
	
	translate ([unit * 9, unit * 14, 0]) rotate([0, 0, 180])  L_5();

	translate ([unit * 2.5, unit * 3.5, 0]) rotate([0, 0, 0]) T_5();

	translate ([unit * 8.5, unit * 4, 0]) S_5();
	
	translate ([unit * 6, unit * 7, 0]) Z_5();

	translate ([unit * 0, unit * 14, 0]) rotate([0, 0, -90]) B_5();
	
	translate ([unit * 3, unit * 9, 0]) P_5();

	translate ([unit * 0, unit * 8, 0]) C_5();

	translate ([unit * 7, unit * 3.5, 0]) F_5();

	translate ([unit * 10, unit * 9.5, 0]) Croix_5();
	
	translate ([unit * 10, unit * 6.5, 0]) M_5();

}

module box () {

difference () {
		translate([-wall, 0, - box_height + 4 - 0.1])
		cube(size = [unit * n + 2 * wall, unit * n + 2 * wall, box_height]);
		
		# union(){
			cube (size = [unit * n, unit * n, 2]);
			
			translate([0, 0, 2])
			cube (size = [unit * n - gap, unit * n - gap, 3]);
		}
	}
}