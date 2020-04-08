use <MCAD/boxes.scad>
$fa=1;
$fs=0.4;
roundedBox(size=[10,20,30],radius=3,sidesonly=false);

#translate([30, 0, 0])
roundedBox(size=[10,20,30],radius=3,sidesonly=true);