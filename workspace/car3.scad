/*
 * A small soap box car
 * 
 * lets replace the wheels by spheres 
 * and make it parametric 
 */

// set the model resolution
// $fa minimum angle for a fragment
// circles have 360 / $fa fragments
// minimal value = 0.01
$fa = 1;

// $fs minimum size of a fragment
$fs = 0.4;

$fn = 72;

axle_radius = 0.5;
axle_length = 43;

body_height = 8;
body_width = 20;
body_length = 50;

top_height = 7;
top_width = 18;
top_length = 30;

wheel_radius = 8;
wheel_width = 4;
wheel_gap = 5;
wheel_distance = (body_width / 2 + wheel_width / 2 + wheel_gap);

track = 15;

difference () {
// body
scale([1.1,1.2,1]) {
scale([body_length / 2,body_width/ 2,body_height])
	sphere(r = 1);
	//cube([body_length,body_width,body_height], center=true);

// roof
// translate (X, Y,Z)
color("green")
translate([0,0,(body_height)/ 2 - 0.001])
	scale([top_length / 2,top_width/ 2,top_height])
	sphere(r = 1);
	//cube([top_length,top_width,top_height],center=true);
}

}

// the car is is on the right (bigger X)
 
// back right wheel
// rotation around X, Y and Z axis
translate([-20,-wheel_distance,0])
	rotate([90,0,0])
	scale([1.0, 1.0, 0.4])
    sphere(r =wheel_radius);
    //cylinder(h=wheel_width,r=wheel_radius);

// right front wheel
translate([20,-wheel_distance,0])
	rotate([90,0,track])
	scale([1.0, 1.0, 0.4])
	sphere(r =wheel_radius);
  //  cylinder(h=wheel_width,r=wheel_radius);

// back left wheel
translate([-20,wheel_distance ,0])
	rotate([90,0,0])
		scale([1.0, 1.0, 0.4])
		sphere(r =wheel_radius);
		// cylinder(h=wheel_width,r=wheel_radius);

// left front wheel
translate([20,wheel_distance,0])
	rotate([90,0,track])
		scale([1.0, 1.0, 0.4])
		sphere(r =wheel_radius);
    	// cylinder(h=wheel_width,r=wheel_radius);

// axles
// right one
translate([20,axle_length / 2,0])
	rotate([90,0,0])
    cylinder(h=axle_length,r=axle_radius);

// left one
translate([-20,axle_length / 2,0])
	rotate([90,0,0])
    cylinder(h=axle_length,r=axle_radius);