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
    _t = 2 * thickness;
    difference()
    {
        cube([ width  + _t, height + _t, length + thickness ]);
        translate([ thickness, thickness, 0 ])
        {
            if ($children)
            {
                children();
            }
            else
            {
                cube([ width, height, length ]);
            }
        }
        for (_s = sides)
        {
            if (_s == "a")
            {
                translate([ 0, 0, length ])
                {
                    cube([ width  + _t, height + _t, _t ]);
                }
            }
            else if (_s == "b")
            {
                cube([ width  + _t, thickness, length + _t ]);
            }
            else if (_s == "l")
            {
                translate([ width + thickness, 0, 0 ])
                {
                    cube([ thickness, height + _t, length + _t ]);
                }
            }
            else if (_s == "r")
            {
                cube([ thickness, height + _t, length + _t ]);
            }
            else if (_s == "t")
            {
                translate([ 0, height + thickness, 0 ])
                {
                    cube([ width  + _t, thickness, length + _t ]);
                }
            }
        }
    }
}
