// Hello world for Openscad

$fn = 180;
n = 12;

for (i = [0 : n]) {
	color("black")
	translate([i * 10, 5, 0])
	text(str(i), size = 3, halign = "center");
	
}

for (i = [0 : n * 10]) {
	len = ((i % 10) == 0 ) ? 4 : ((i % 5 == 0) ? 3: 2) ;
	
	color("black")
	translate([i, 0, 0])
	square(size=[0.1, len]);

}