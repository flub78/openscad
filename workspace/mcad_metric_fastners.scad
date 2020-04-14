use <MCAD/metric_fastners.scad>

$fn = 180; 

union()
{
csk_bolt(3,14);
translate([20,0,0]) washer(3);
translate([40,0,0]) flat_nut(3);
translate([60,0,0]) bolt(4,14);
translate([80,0,0]) cylinder_chamfer(8,1);
translate([100,0,0]) chamfer(10,2);
}
