/**
 * Genera una pieza para unir dos baldas.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Storage/ShelfJoint.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3320585
 */
//---------------------------------------------------------------
// Variables personalizables
//---------------------------------------------------------------
height     = 30;        // Altura de la madera (eje Z).
joint      = 5;         // Grosor de la unión.
side       = 25;       // Ancho de cada lado de la unión (eje Y).
width      = 150;       // Ancho de la madera (eje X).
thickness  = 1.2;       // Grosor de las paredes.
xHoles     = [ 1, 4 ];  // Cantidad de agujeros sobre el eje X y su diámetro.
yHoles     = false;     // Cantidad de agujeros sobre el eje Y y su diámetro.
zHoles     = [ [ 0.05, 0.95 ], 4 ];  // Cantidad de agujeros sobre el eje Z y su diámetro.
half       = false;     // Indica si solamente dibujar la mitad de la pieza
                        // para imprimirla en impresoras pequeñas
//---------------------------------------------------------------
use <../Functions/Array/toArray.scad>
//---------------------------------------------------------------
/**
 * Dibuja los agujeros sobre un eje.
 */
module drawHoles(width, holes, diameter, height = thickness)
{
    _holes = holes[0] == undef
        ? toArrayAcc(holes + 1)
        : holes;
    for (_hole = _holes)
    {
        translate([ - width / 2 + _hole * width, 0, 0 ])
        {
            cylinder(d = diameter, h = height, center = true);
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
            rotate([ 90, 0, 90 ])
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
module support(width, length, height, layerHeight, dz = 10)
{
    if (layerHeight && dz)
    {
        _n  = floor(height / dz) + 1;
        _z0 = (height - (_n * dz)) / 2;
        for (_z =  [ 1 : _n - 1 ])
        {
            translate([ - width / 2, layerHeight, _z0 + _z * dz ])
            {
                cube([ width, length - layerHeight, layerHeight + 0.1 ]);
            }
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
    if (yHoles)
    {
        rotate([ 90, 0, 0 ])
        {
            drawHoles(width, yHoles[0], yHoles[1], joint + t);
        }
    }
    if (half)
    {
        l = max(width, side, height) + 2 * t;
        translate([  0, - l / 2, - l / 2 ])
        {
            cube([ l, l, l ]);
        }
    }
}
