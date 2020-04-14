use <MCAD/2DShapes.scad>
use <MCAD/3d_triangle.scad>
$fa=1;
$fs=0.4;

translate([50, 0, 0])
color("lightBlue")
3dtri_draw ( Acord = [0, 0, 0], Bcord = [0, 10, 0], Ccord = [20, 20, 0], h =15) ;

// buggy
3dtri_rnd_draw (Acord = [-10, -10, 0], Bcord = [0, 10, 0], Ccord = [20, 0, 0], h =20,  r = 1);