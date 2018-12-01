/**
 * Almacenamiento para las etiquetas de Essenzia: http://www.essenzia.es
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Storage/EssenziaLabelsBox.scad
 * @license CC-BY-NC-4.0
 */
//--------------------------------------------------------------------------
use <../Modules/Box/storage.scad>
//--------------------------------------------------------------------------
// Tamaño de la etiqueta: 28mm x 47mm
width     = 28.5; // Ancho de cada cuadro.
height    =  4;   // Alto de cada cuadro.
cols      =  6;
rows      = 20;
length    = 30;
radius    = 0.9;
thickness = 0.9;

$fn = $preview ? 30 : 120;
difference()
{
    boxStorage(
        cols * (width  + thickness) + thickness,
        rows * (height + thickness) + thickness,
        length,
        radius,
        thickness,
        cols,
        rows
    );
    translate([ - (cols - 2) * (width + thickness) / 2, - (rows - 1) * (height + thickness) / 2, thickness ])
    {
        for (x = [ 0, 2, 4 ])
        {
            translate([ x * (width + thickness), 0, 0 ])
            {
                cube([ thickness + 0.1, height, length ], center = true);
            }
        }
    }
}
