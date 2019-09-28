/**
 * Genera una bandeja para insertar un modelo.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Box/tray.scad
 * @license CC-BY-NC-4.0
 */
//----------------------------------------------------------
/**
 * Permite dibujar una bandeja y decidir cuáles caras eliminar.
 *
 * Los lados de la bandeja se enumeran de la siguiente manera (con respecto al plano XZ):
 *
 * - a : Parte trasera.
 * - b : Parte inferior.
 * - l : Parte izquierda.
 * - r : Parte derecha.
 * - t : Parte superior.
 *
 * @param {Float}   width     Anchura de la bandeja a generar (eje X).
 * @param {Float}   height    Altura de la bandeja a generar (eje Y).
 * @param {Float}   length    Longitud de la bandeja a generar (eje Z).
 * @param {Float}   thickness Grosor de las paredes de la bandeja.
 * @param {Boolean} sides     Lados de la bandeja a omitir.
 */
module boxTray(width, height, length, thickness = 5, sides = [])
{
    _e = $preview ? 0.01 : 0;
    _t = 2 * thickness;
    _h = height + _t;
    _l = length + thickness;
    _w = width  + _t;
    difference()
    {
        cube([ _w, _h, _l ], center = true);
        translate([ thickness, thickness, thickness / 2 - _e ])
        {
            if ($children)
            {
                children();
            }
            else
            {
                cube([ width, height, length ], center = true);
            }
        }
        for (_s = sides)
        {
            if (_s == "a")
            {
                // Tapa trasera
                translate([ 0, 0, _l / 2 - _e ])
                {
                    cube([ _w + _e, _h + _e, _t + _e ], center = true);
                }
            }
            else if (_s == "l" || _s == "r")
            {
                translate([ (_s == "l" ? 1 : -1) * (width + thickness) / 2, 0, 0 ])
                {
                    cube([ thickness + _e, height + 2 * _t, length + 2 * _t ], center = true);
                }
            }
            else if (_s == "b" || _s == "t")
            {
                translate([ 0, (_s == "b" ? -1 : 1) * (height / 2 + thickness - _e), 0 ])
                {
                    cube([ width + 2 * _t, _t, length + 2 * _t ], center = true);
                }
            }
        }
    }
}
