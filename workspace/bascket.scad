// small pen basket
// $fn = 72;

dia = 100;
top_dia = 5;
height = 100;
dia_side = 4;

// top
translate([0,0,height])
rotate_extrude(convexity = 10)
translate([(dia -dia_side)/2, 0, 0])
circle(r = (top_dia)/2, $fn = 24);
 

// bottom
cylinder(h=1.5, d=dia, $fn=36);


// middle
n = 20;
diam = (dia - dia_side)/2;
for (a =[0:n:360]) {
    rotate([0,0, a])
    linear_extrude(height, twist=360)
    translate([diam,0,0])
    circle(d=dia_side);
}