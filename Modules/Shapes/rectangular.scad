/**
 * Repite una forma 2D generando un patrón rectangular centrado.
 *
 * @param {Float} side      Tamaño de cada lado del hijo usado como patrón.
 * @param {Float} width     Ancho de cada elemento (eje circular).
 * @param {Float} height    Altura de cada elemento (eje radial).
 * @param {Float} thickness Grosor de las paredes del patrón.
 * @param {Float} sideY     Permite especificar la otra dimensión cuando el área es rectangular.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Shapes/rectangular.scad
 * @license CC-BY-NC-4.0
 */
module rectangular(side, width, height, thickness, sideY = 0)
{
    _h      = height + thickness;
    _w      = width  + thickness;
    _sx     = side;
    _sy     = sideY ? sideY : side;
    _countX = ceil(_sx / _w);
    _countY = ceil(_sy / _h);
    translate([ - (_countX * _w - _w) / 2, - (_countY * _h - _h) / 2 ])
    {
        for (_x = [ 0 : _w : _sx ])
        {
            for (_y = [ 0 : _h : _sy ])
            {
                translate([ _x, _y ])
                {
                    children();
                }
            }
        }
    }
}
