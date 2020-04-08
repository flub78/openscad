use <MCAD/gears.scad>
$fa=1;
$fs=0.4;


test_involute_curve();
test_gears();

demo_3d_gears();

translate([0, 0, 50])
color("orange")
gear(number_of_teeth= 30, circular_pitch=50, diametral_pitch=60,
		pressure_angle=1, clearance = 0.02);