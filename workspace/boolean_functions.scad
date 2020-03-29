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
cylinder(h=wheel_width,r=wheel_radius);

translate([0,0, -0.001])
cylinder(h=wheel_width+ 1,r=wheel_radius / 2);

}

