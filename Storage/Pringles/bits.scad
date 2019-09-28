/**
 * Genera un contenedor para almacenar puntas de taladro.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Storage/Pringles/bits.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3612377
 */
//---------------------------------------------------------------
use <./container.scad>
//---------------------------------------------------------------
/**
 * Dibuja el contenedor para puntas de taladro.
 *
 * @param {Float}  length    Longitud de la punta en pulgadas (eje Z).
 * @param {Float}  diameter  Diámetro en pulgadas de la punta.
 * @param {String} type      Tipo de módulo a usar como soporte ('conc' o 'rect').
 * @param {Float}  plength   Longitud del patrón (eje Z).
 * @param {Float}  tolerance Tolerancia a usar para dejar holgura según la impresora.
 * @param {Float}  thickness Grosor de las paredes del patrón.
 */
module bits(diameter = 1/4, length = 1, type = "rect", plength = 0, tolerance = 0, thickness = 0.6)
{
    _mm = 25.4;
    _d  = _mm * diameter;
    _l  = _mm * length;
    _h  = tolerance + _d;
    _w  = tolerance + _d / cos(30);
    _pl = plength ? plength : _l / 4;
    if (type == "conc")
    {
        conc(_l + 1, _pl, _w, _h, thickness, 0)
        {
            circle(d = max(_w, _h), $fn = 6);
        }
    }
    else if (type == "rect")
    {
        rect(_l + 1, _pl, _w, _h, thickness);
    }
}

//-----------------------------------------------------------------------------
// Soporte para puntas de destornillador
//bits(); // 1/4" x 1"
bits(5/32, 1 + 1/8, plength = 12, tolerance = 0.3, type="conc"); // 5/32" x 1 1/8"
