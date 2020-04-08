use <MCAD/layouts.scad>


translate([0,0, 50])
#list(15)
{
	square([25,10]);
	square([25,10]);
    square([25,10]);
	square([25,10]);
    square([25,10]);
}

grid(30,15,false,2)
{
	square([25,10]);
	square([25,10]);
    square([25,10]);
	square([20,10]);
    #square([25,12]);
	square([25,10]);
    square([25,10]);
	square([25,10]);
    square([25,10]);
}