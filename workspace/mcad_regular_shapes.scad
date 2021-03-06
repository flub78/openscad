use <MCAD/regular_shapes.scad>

triangle(20);

translate([50, 0, 0]) pentagon(20);

translate([100, 0, 0]) hexagon(20);

translate([150, 0, 0]) heptagon(20);

translate([200, 0, 0]) ring(20, 10);

translate([250, 0, 0]) ellipse(20, 30);

translate([300, 0, 0]) egg_outline(20, 20 * 1.39);


translate([0,50, 0]) cone(height = 30, radius = 10, center = true)

translate([50,50, 0]) oval_prism(height = 40, rx = 15, ry = 10, center = false);

translate([100,50, 0]) oval_tube(height = 40, rx = 15, ry = 10, wall = 2, center = false);

translate([150,50, 0]) heptagon(20);

translate([200,50, 0]) ring(20, 10);

translate([250,50, 0]) ellipse(20, 30);

translate([300,50, 0]) egg_outline(20, 20 * 1.39);