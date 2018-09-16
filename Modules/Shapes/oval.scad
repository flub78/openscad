/**
 * Genera un óvalo.
 *
 * @param radius Radio de los círculos de los extremos del óvalo (Eje Y).
 * @param width  Ancho del óvalo (Eje X).
 * @param length Altura del óvalo (Eje Z).
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Shapes/oval.scad
 * @license CC-BY-NC-4.0
 */
module oval(radius, width, length)
{
    translate([ -width / 2, 0, 0])
    {
        hull()
        {
            translate([ radius, 0, 0 ])
            {
                cylinder(r = radius, h = length);
            }
            translate([ width - radius, 0, 0 ])
            {
                cylinder(r = radius, h = length);
            }
        }
    }
}
