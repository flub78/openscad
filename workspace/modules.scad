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

module wheel() {
wheel_radius=10; 
side_spheres_radius=50; 
hub_thickness=4; 
cylinder_radius=2; 
cylinder_height=2*wheel_radius; 
difference() {
    // Wheel sphere
    sphere(r=wheel_radius);
    // Side sphere 1
    translate([0,side_spheres_radius + hub_thickness/2,0])
        sphere(r=side_spheres_radius);
    // Side sphere 2
    translate([0,- (side_spheres_radius + hub_thickness/2),0])
        sphere(r=side_spheres_radius);
    // Cylinder 1
    translate([wheel_radius/2,0,0])
        rotate([90,0,0])
        cylinder(h=cylinder_height,r=cylinder_radius,center=true);
    // Cylinder 2
    translate([0,0,wheel_radius/2])
        rotate([90,0,0])
        cylinder(h=cylinder_height,r=cylinder_radius,center=true);
    // Cylinder 3
    translate([-wheel_radius/2,0,0])
        rotate([90,0,0])
        cylinder(h=cylinder_height,r=cylinder_radius,center=true);
    // Cylinder 4
    translate([0,0,-wheel_radius/2])
        rotate([90,0,0])
        cylinder(h=cylinder_height,r=cylinder_radius,center=true); 
}
}

wheel();