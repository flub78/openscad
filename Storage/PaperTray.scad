/**
 * Genera un contenedor para hojas de papel.
 *
 * @param {Float}   width     Ancho del contenedor (eje X).
 * @param {Float}   height    Alto del contenedor (eje Y).
 * @param {Float}   length    Longitud del contenedor (eje Z).
 * @param {Float}   thickness Grosor de las paredes del contenedor.
 * @param {Float}   margin    Margen a dejar para aplicar el patrón.
 * @param {Float[]} spaces    Proporción a dejar de espacios en los laterales.
 * @param {String}  pattern   Nombre del patrón a aplicar sobre la base.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Storage/PaperTray.scad
 * @license CC-BY-NC-4.0
 */
//-----------------------------------------------------------------------------
use <../Modules/Box/storage.scad>
use <../Modules/Pattern/apply.scad>
//-----------------------------------------------------------------------------
module sheetsHolder(width, height, length, thickness, margin = 10, spaces = [ 0.5, 0.5 ], pattern = "honeycomb")
{
    _2m = 2 * margin;
    _2t = 2 * thickness;
    _h  = height - _2m - _2t;
    _w  = width  - _2m - _2t;
    difference()
    {
        translate([ 0, 0, - length / 2 + thickness / 2 ])
        {
            patternApply(_w, _h, _2t * 2, _2t, pattern)
            {
                translate([ 0, 0, + length / 2 - thickness / 2 ])
                {
                    boxStorage(width, height, length, 0, thickness, 1, 1);
                }
            }
        }
        if (spaces[0])
        {
            _spaceX = height * spaces[0];
            for (_x = [ -1, 1 ])
            {
                translate([ _x * (width / 2 - thickness / 2), 0, thickness ])
                {
                    cube([ _2t, _spaceX, length ], center = true);
                }
            }
        }
        if (spaces[1])
        {
            _spaceY = width * spaces[1];
            for (_y = [ -1, 1 ])
            {
                translate([ 0, _y * (height / 2 - thickness / 2), thickness ])
                {
                    cube([ _spaceY, _2t, length ], center = true);
                }
            }
        }
    }
}
