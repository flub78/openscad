/**
 * Genera un contenedor dividido en segmentos radiales.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Storage/Pringles/segments.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3612377
 */
//---------------------------------------------------------------
use <../../Modules/Shapes/propeller.scad>
use <./constants.scad>
use <./container.scad>
//---------------------------------------------------------------
constants  = getConstants();
INNER      = constants[0];
LENGTH     = constants[2];
THICKNESS  = constants[3];

/**
 * Divide el contenedor en segmentos radiales.
 *
 * @param {Float} count     Cantidad de segmentos.
 * @param {Float} length    Longitud del contenedor (eje Z).
 * @param {Float} plength   Longitud del patrón (eje Z).
 * @param {Float} thickness Grosor de las paredes del segmento.
 */
module segments(count = 4, length = LENGTH, plength = LENGTH -  3 * THICKNESS, thickness = THICKNESS)
{
    _text = str(length, "-", plength, "x", count, ".stl");
    container(length)
    {
        if ($children)
        {
            echo(str("Pringle-segments-custom-", _text));
            difference()
            {
                children();
                propeller(INNER + 0.1, plength, thickness, [ 0 : 360 / count : 359 ]);
            }
        }
        else
        {
            echo(str("Pringle-segments-", _text));
            propeller(INNER + 0.1, plength, thickness, [ 0 : 360 / count : 359 ]);
        }
    }
}

//-----------------------------------------------------------------------------
segments(6);
