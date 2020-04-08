use <MCAD/2DShapes.scad>
$fa=1;
$fs=0.4;

linear_extrude (10) {
for (i = [0:9] ) {
	color(c =[0.5 + 1 / 20 *i , 0, 0 ])
	translate([50 * i, 0, 0]) 
	ngon (3 + i, 10, center = true);
}

color ("blue") {
	translate([0, 50, 0]) complexRoundSquare ([10, 20]); 

	translate([50, 50, 0]) complexRoundSquare ([10, 20], rads1 = [2, 2]); 

	translate([100, 50, 0]) complexRoundSquare ([10, 20], rads2 = [4, 2]); 

	translate([150, 50, 0]) complexRoundSquare ([10, 20], rads3 = [5, 5]); 

}

color ("green") {

	translate([0, 100, 0]) roundedSquare(pos=[10,10],r=2);
	
	translate([50, 100, 0]) roundedSquare(pos=[20,30],r=5);
}

color ("yellow") {

	translate([0, 150, 0]) ellipsePart(width = 40,height = 20,numQuarters = 1);
	
	translate([50, 150, 0]) ellipsePart(width = 40,height = 20,numQuarters = 2);

	translate([100, 150, 0]) ellipsePart(width = 40,height = 20,numQuarters = 3);

	translate([150, 150, 0]) ellipsePart(width = 40,height = 20,numQuarters = 4);
}

color ("orange") {

	translate([0, 200, 0]) donutSlice(innerSize = 10 ,outerSize = 20 , start_angle = 0, end_angle = 90); 
	
	translate([50, 200, 0]) donutSlice(innerSize = 10 ,outerSize = 20 , start_angle = 45, end_angle = 135); 

	translate([100, 200, 0]) donutSlice(innerSize = 10 ,outerSize = 20 , start_angle = 180, end_angle = 270); 

	translate([150, 200, 0]) donutSlice(innerSize = 10 ,outerSize = 20 , start_angle = 0, end_angle = 300); 
}

color ("purple") {

	translate([0, 250, 0]) pieSlice(size = 30, start_angle = 45, end_angle = 90);
	
	translate([50, 250, 0]) pieSlice(size = 30, start_angle = 45, end_angle = 180);

	translate([100, 250, 0]) pieSlice(size = 20, start_angle = 45, end_angle = 50);

	translate([150, 250, 0]) pieSlice(size = 20, start_angle = 270, end_angle = 3000);
	
}

}