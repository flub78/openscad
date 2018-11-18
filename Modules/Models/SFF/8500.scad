/**
 * Modelos y variables según la especificación SFF-8500.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Models/SFF/8500.scad
 * @license CC-BY-NC-4.0
 *
 * @see     SFF-8500 5.25" Form Factor Drives
 */
//----------------------------------------------------------
use <../../Box/tray.scad>
use <../box.scad>
//----------------------------------------------------------
/**
 * Devuelve las especificaciones de las medidas según SFF-8500.
 *
 * @param {Float} tolerance Tolerancia a usar para ajustar las medidas.
 *
 * @return {Float[]}
 */
function sff8500(tolerance = 0) = [
      3.00, // Diámetro del tornillo
     41.53 + tolerance,
     42.30 + tolerance,
    148.00 + tolerance,
    202.80 + tolerance,
    146.05 + tolerance,
    139.70 + tolerance,
      3.18 + tolerance / 2,
     79.25,
     47.40,
     47.40,
     79.25,
     undef,
     10.00 + tolerance / 2,
     21.84 + tolerance / 2,
     undef,
      6.50 + tolerance,
      5.00 + tolerance
];
//----------------------------------------------------------
/**
 * Dibuja un modelo de una unidad de CD/DVD/BR según la especificación SFF-8500.
 *
 * Este modelo permite extraer el volumen posteriormente para crear una ranura
 * como las usadas en las cajas de PCs.
 *
 * @param {Float}   length    Longitud de la unidad a generar.
 * @param {Float}   thickness Grosor del bloque donde se insertará el modelo.
 * @param {Float}   screw     Diámetro del tornillo a usar.
 * @param {Float}   slot      Longitud de la ranura donde se insertarán los tornillos.
 * @param {Float}   tolerance Valor a usar para ajustar las medidas estándar.
 * @param {Boolean} addStop   Indica si se agrega la pieza que evita que se introduzca por completo la unidad en la ranura.
 */
module sff8500Model(length = 0, thickness = 5, screw = 0, slot = 15, tolerance = 0.3, addStop = false)
{
    _A = sff8500(tolerance);
    modelBox(
        _A[5],
        _A[1],
        length ? length : _A[4],
        thickness,
        screw ? screw : _A[0],
        slot,
        [
            [ _A[13], _A[10]          ],
            [ _A[13], _A[10] + _A[11] ],
            [ _A[14], _A[10]          ],
            [ _A[14], _A[10] + _A[11] ],
        ],
        [
            [ _A[7],         _A[9]         ],
            [ _A[7],         _A[8] + _A[9] ],
            [ _A[5] - _A[7], _A[9]         ],
            [ _A[5] - _A[7], _A[8] + _A[9] ]
        ]
    );
    if (addStop)
    {
        translate([ - (_A[3] - _A[5]) / 2 , - (_A[2] - _A[1]) / 2 , -_A[17] ])
        {
            cube([ _A[3], _A[2], _A[17] ]);
        }
    }
}
//----------------------------------------------------------
/**
 * Dibuja una bandeja que puede insertarse en una ranura donde va una unidad de CD/DVD/BR.
 *
 * @param {Float}   length    Longitud de la unidad a generar.
 * @param {Float}   thickness Grosor del bloque donde se insertará el modelo.
 * @param {Float}   screw     Diámetro del tornillo a usar.
 * @param {Float}   slot      Longitud de la ranura donde se insertarán los tornillos.
 * @param {Float}   tolerance Valor a usar para ajustar las medidas estándar.
 * @param {Boolean} sides     Lados a eliminar de la bandeja.
 */
module sff8500Tray(length = 0, thickness = 5, screw = 0, slot = 15, tolerance = 0.3, sides = [ "a", "t" ])
{
    _A = sff8500(tolerance);
    boxTray(_A[5], _A[1], length ? length : _A[4], thickness, sides)
    {
        sff8500Model(length, thickness, screw  ? screw : _A[0], slot, tolerance);
    }
}
