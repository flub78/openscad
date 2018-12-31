/**
 * Genera una pieza para unir dos baldas.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Home/ShelfJoint.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3320585
 */
//---------------------------------------------------------------
// Variables personalizables
//---------------------------------------------------------------
height     = 16;        // Altura de la madera (eje Z).
joint      = 8;         // Grosor de la unión.
side       = 15;        // Ancho de cada lado de la unión (eje Y).
width      = 245;       // Ancho de la madera (eje X).
thickness  = 1.5;       // Grosor de las paredes.
xHoles     = [ 1, 4 ];  // Cantidad de agujeros sobre el eje X y su diámetro.
yHoles     = [ 4, 8 ];  // Cantidad de agujeros sobre el eje Y y su diámetro.
zHoles     = [ 2, 4 ];  // Cantidad de agujeros sobre el eje Z y su diámetro.
half       = false;     // Indica si solamente dibujar la mitad de la pieza
                        // para imprimirla en impresoras pequeñas
//---------------------------------------------------------------
/**
 * Dibuja los agujeros sobre un eje.
 */
module drawHoles(width, count, diameter, height = thickness)
{
    _dx = width / (count + 1);
    translate([ - width / 2, 0, 0 ])
    {
        for (_n = [ 1 : count ])
        {
            translate([ _dx * _n, 0, 0 ])
            {
                cylinder(d = diameter, h = height, center = true);
            }
        }
    }
}
/**
 * Dibuja una de las cajas.
 * Cada pieza está formada por dos cajas en contraposición.
 */
module box()
{
    difference()
    {
        cube([ width + t, side, height + t ], center = true);
        translate([ 0, thickness, 0 ])
        {
            cube([ width, side, height ], center = true);
        }
        if (xHoles)
        {
            rotate([ 0, 90, 0 ])
            {
                drawHoles(side, xHoles[0], xHoles[1], width + 2 * t);
            }
        }
        if (zHoles)
        {
            drawHoles(width, zHoles[0], xHoles[1], height + 2 * t);
        }
    }
}
//---------------------------------------------------------------
// Inicio del dibujo
//---------------------------------------------------------------
$fn = $preview ? 30 : 180;
t   = 2 * thickness;
j   = max(0, joint - t);
difference()
{
    union()
    {
        for (y = [ -1, 1 ])
        {
            translate([ 0, y * (side + j) / 2, 0 ])
            {
                rotate([ y == -1 ? 180 : 0, 0, 0 ])
                {
                    box();
                }
            }
        }
        cube([ width + t, j, height + t ], center = true);
    }
    rotate([ 90, 0, 0 ])
    {
        drawHoles(width, yHoles[0], yHoles[1], joint + t);
    }
    if (half)
    {
        l = max(width, side, height) + 2 * t;
        translate([  0, - l / 2, - l / 2 ])
        {
            cube([l, l, l ]);
        }
    }
}