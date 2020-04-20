// Support mini PC pour fixation dans simulateur

use <MCAD/boxes.scad>

depth = 136;
width = 160;
height = 31;
rounding = 7;

wall = 3;

module pc () {
	roundedBox(size=[width, depth, height], radius=rounding, sidesonly=true);
	
	x = width / 2 - 15;
	y = depth / 2 - 15;
	
	translate([x, y, -3])
	sphere(r= height/2 - 1, $fn=180);

	translate([x, -y, -3])
	sphere(r= height/2 - 1, $fn=180);

	translate([-x, y, -3])
	sphere(r= height/2 - 1, $fn=180);

	translate([-x, -y, -3])
	sphere(r= height/2 - 1, $fn=180);
}


module support() {

	difference () {
	color([0, 1, 0, 0.1])
	translate ([0, -(width/2 -17), 0])
	cube(size=[width + 2 * wall, 20 + wall, height + 2 * wall], center=true);

		pc();
	}
}

# support();