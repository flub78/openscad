 /**
 * Genera el patrón especificado para ser aplicado sobre una superficie.
 *
 * @param {Float} width     Ancho del área a aplicar el patrón (eje X).
 * @param {Float} height    Alto del área a aplicar el patrón (eje Y).
 * @param {Float} length    Longitud del patrón a dibujar (eje Z).
 * @param {Float} thickness Grosor del patrón.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Pattern/apply.scad
 * @license CC-BY-NC-4.0
 */
//-----------------------------------------------------------------------------
use <./bars.scad>
use <./honeycomb.scad>
//-----------------------------------------------------------------------------
module patternApply(width, height, length, thickness = 0, pattern = "rect")
{
    difference()
    {
        children();
        if (pattern == "bars")
        {
            translate([ 0, - height / 2, 0 ])
            {
                bars(height, width, length, thickness, 2 * thickness);
            }
        }
        else if (pattern == "honeycomb")
        {
            honeycombCube(width, height, thickness, max(width, height) / 6, thickness);
        }
        else if (pattern == "rect")
        {
            cube([ width, height, length ], center = true);
        }
    }
}
