// fruit juice bottle cap

use <../Modules/threads.scad>

ext_dia = 41;
intern_dia = 40;
height = 10;
$fn = 180;

difference () {
	cylinder(h = height, d = ext_dia);
	
	/*
	translate([0, 0, -5])
	cylinder(h = height, d = intern_dia);
	*/
	
	translate([0, 0, -5 ])
	#metric_thread (diameter=intern_dia, pitch=4, length=20);
}
