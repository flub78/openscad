/*
   w1
 ------
|      |
|      | length 
|      |          w2
       ----------------------
*/

diam      = 19.5;
thickness = 9;
length    = 20;
w1        = 16;
w2        = 107;
pin       = 4;
$fn       = 250;

module bagHolder()
{
    cube([ pin, thickness, thickness * 2 ]);
    translate([ -thickness, 0, 0 ])
    {
        cube([ thickness, thickness, pin ]);
        cube([ pin, thickness, thickness / 2 + pin / 2 ]);
    }
}
module pin(length)
{
    difference()
    {
        cylinder(d = diam, h = length, center = true);
        for (y = [ -1, 1 ])
        {
            translate([ 0, y * (diam + thickness) / 2, 0])
            {
                cube([diam, diam, length + 0.1], center = true);
            }
        }
    }
}

difference()
{
    union()
    {
        translate([ 0, 0, thickness - (length + thickness) / 2 ])
        {
            pin(length + thickness);
        }
        translate([ 0, - thickness / 2, 0 ])
        {
            cube([ w1 + diam / 2, thickness, thickness ]);
            translate([ w1 + diam / 2, 0, - length ])
            {
                cube([ thickness, thickness, length + thickness ]);
                cube([ w2 + thickness, thickness, thickness ]);
                // Pin superior interior
                translate([ w2 - 79.5, 0, thickness ])
                {
                    cube([ pin, thickness, thickness * 1.25 ]);
                }
                // Pin superior exterior
                translate([ w2 + pin + 1, 0, thickness ])
                {
                    cube([ pin, thickness, thickness * 1.25 ]);
                }
                // Pin inferior 1
                translate([ w2 * 0.5, 0, - thickness ])
                {
                    bagHolder();
                }
                // Pin inferior 1
                translate([ w2, 0, - thickness ])
                {
                    mirror([ 1, 0, 0 ])
                    {
                        bagHolder();
                    }
                }
            }
        }
    }
//    dw = 0.6;
//    for (y = [ dw / 2, -(thickness + dw / 2) ])
//    {
//        translate([ - diam, y, - length * 2 ])
//        {
//            cube([ w2 * 2, thickness, length * 4] );
//        }
//    }
}
