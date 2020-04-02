// small pen basket
$fn = 72;

dia = 100;
top_dia = 4;
height = 100;
dia_side = 2;

// top
translate([0,0,height])
rotate_extrude(convexity = 10)
translate([dia/2, 0, 0])
circle(r = top_dia/2);


// bottom
linear_extrude(1.5)
circle(d=dia);

// middle
for (a =[0:5:360]) {
    rotate([0,0, 10*a])
    linear_extrude(height, twist=360)
    translate([(dia -dia_side)/2,0,0])
    #circle(d=dia_side);
}