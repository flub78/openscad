// Hello world for Openscad

use <../Modules/threads.scad>

translate([0, 0, -10]) 
metric_thread (diameter=8, pitch=1, length=20);
 
translate([50, 0, 0]) 
difference() {
	cube([15, 15, 20], center = true);

	# metric_thread (diameter=8, pitch=1, length=20, internal=true);

}