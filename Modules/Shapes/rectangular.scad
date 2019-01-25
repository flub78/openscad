/**
 * Repite una forma 2D generando un patrón rectangular centrado.
 *
 * @param {Float} side      Tamaño de cada lado del rectángulo.
 * @param {Float} width     Ancho de cada elemento (eje circular).
 * @param {Float} height    Altura de cada elemento (eje radial).
 * @param {Float} thickness Grosor de las paredes del patrón.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Shapes/rectangular.scad
 * @license CC-BY-NC-4.0
 */
module rectangular(side, width, height, thickness)
{
    _h      = height + thickness;
    _w      = width  + thickness;
    _countX = ceil(side / _w);
    _countY = ceil(side / _h);
    translate([ - (_countX * _w - thickness) / 2, - (_countY * _h - thickness) / 2 ])
    {
        for (_x = [ 0 : _w : side ])
        {
            for (_y = [ 0 : _h : side ])
            {
                translate([ _x, _y ])
                {
                    children();
                }
            }
        }
    }
}
