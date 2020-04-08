// A battery storage

$fn = 72;

wall = 1;
height = 20;
lines = 4;
cols = 6;
dia = 10;

// AAA
dia = 10.8;

//  AA
// dia = 14.5; 

difference () {

	cube ([cols * (dia + wall) + wall, lines * (dia + wall) + wall, height]);
	
	translate([dia/2 + wall, dia/2 + wall, 0])
	for (l = [0 : lines - 1 ]) {
		echo (l);
		for (c = [0 : cols - 1]) {
			translate([c * ( dia + wall), l * (dia + wall), wall])
			cylinder(h = height, d = dia);
		}
	}
}