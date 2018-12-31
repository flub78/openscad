/**
 * Soporte para colgar en la pared una impresora Excelvan HOP E-200.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Home/Excelvan-E200.scad
 * @see     http://www.thingiverse.com/thing:
 * @license CC-BY-NC-4.0
 */
tolerance = 2;               // Tolerancia de las medidas.
width     =  80 + tolerance; // Ancho de la impresora (eje X).
height    =  38 + tolerance; // Alto de la impresora (eje Y).
length    = 114 + tolerance; // Longitud de la impresora (eje Z).
thickness = 0.9;             // Grosor de las paredes.
front     = 50;              // Longitud de la parte frontal (eje Z).
//--------------------------------------------------------------------------
use <../Modules/Box/storage.scad>
//--------------------------------------------------------------------------
$fn = $preview ? 60 : 240;

difference()
{
    boxStorage(width, height, length, 1, thickness, 1, 1);
    translate([ - (width + thickness) / 2, - height * 0.75, - length / 2 + front ])
    {
        cube([ width + thickness, height, length ]);
    }
    // Superior
    translate([ - (width + thickness) / 2, - height * 0.75, - length / 2 + front ])
    {
        cube([ width + thickness, height, length ]);
    }
    // Frontal
    translate([ - width / 2 + 26, - height, - length / 2 + 19 ])
    {
        cube([ 50, height, front ]);
    }
    // Lateral
    translate([ width / 2 - 5, - height / 2 + 10, - length / 2 + 9 ])
    {
        cube([ 10, 10, 25 ]);
    }
    // Agujeros
    for (x = [ -1, 0, 1 ])
    {
        translate([ x * width / 4, height / 2, length / 4 ])
        {
            rotate([ 90, 0, 0 ])
            {
                cylinder(d = 3, h = 4 * thickness, center = true);
            }
        }
    }
}