/**
 * Dibuja un hueco en una caja con las dimensiones especificadas.
 * Si las dimensiones necesitadas son las externas, se debe restar el borde.
 *
 * @param {Number} width     Ancho del hueco (eje X).
 * @param {Number} length    Largo del hueco (eje Y).
 * @param {Number} height    Alto del hueco (eje Z).
 * @param {Number} thickness Grosor del borde.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Box/hollow.scad
 * @license CC-BY-NC-4.0
 */
module boxHollow(width, length, height, thickness = 1)
{
    if (thickness > 0)
    {
        _b = 2 * thickness;
        difference()
        {
            cube([ width  + _b, length + _b, height + thickness ]);
            translate([ thickness, thickness, thickness ])
            {
                cube([ width, length, height ]);
            }
        }
    }
}
