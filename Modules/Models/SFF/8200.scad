/**
 * Modelos y variables según la especificación SFF-8200.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Models/SFF/8200.scad
 * @license CC-BY-NC-4.0
 *
 * @see     SFF-8200 2.5" Form Factor Drives
 */
//----------------------------------------------------------
use <../../Box/tray.scad>
use <../box.scad>
//----------------------------------------------------------
/**
 * Devuelve las especificaciones de las medidas según SFF-8200.
 *
 * @param {Float}   tolerance Tolerancia a usar para ajustar las medidas.
 * @param {Integer} type      Tipo de unidad (0: pequeña, 1: mediana, 2: grande).
 *
 * @return {Float[]}
 */
function sff8200(tolerance = 0, type = 0) = [
      3.00, // Diámetro del tornillo
     (
         type == 0 
            ? 19.05 
            : type == 1 
                ? 17.00 
                : type == 2
                    ? 15.00 
                    : type == 3
                        ? 12.70 
                        : type == 4
                            ? 10.50 
                            : type == 5
                                ? 9.50 
                                : type == 6
                                    ? 8.47
                                    : type == 7
                                        ? 7.00
                                        : 5.00
    ) + tolerance,
      0.00,
      0.50,
     69.85 + tolerance,
      0.25,
    100.45 + tolerance,
     undef,
     undef,
     undef,
    100.20 + tolerance,     // #10
    100.50 + tolerance,
    110.20 + tolerance,
     undef,
     undef,
     undef,
     undef,
     undef,
     undef,
     undef,
     undef,                 // #20
     undef,
     undef,
      3.00 + tolerance / 2,
     34.93,
     38.10,
     undef,
      0.50,
      4.07 + tolerance / 2,
     61.72,
     34.93,                 // #30
     38.10,
     undef,
      0.50,
     undef,
     undef,
     undef,
      8.00,
      3.00,
     undef,
     undef,                 // #40
      2.50,
     undef,
     undef,
     undef,
     undef,
     undef,
     undef,
     undef,
     undef,
     14.00 + tolerance / 2, // #50
     90.60 + tolerance / 2,
     14.00 + tolerance / 2,
     90.60 + tolerance / 2
];
//----------------------------------------------------------
/**
 * Dibuja un modelo de una unidad de 3.5" según la especificación SFF-8200.
 *
 * Este modelo permite extraer el volumen posteriormente para crear una ranura
 * como las usadas en las cajas de PCs.
 *
 * @param {Float}   length    Longitud de la unidad a generar.
 * @param {Float}   thickness Grosor del bloque donde se insertará el modelo.
 * @param {Float}   screw     Diámetro del tornillo a usar.
 * @param {Float}   slot      Longitud de la ranura donde se insertarán los tornillos.
 * @param {Float}   tolerance Valor a usar para ajustar las medidas estándar.
 * @param {Integer} type      Tipo de unidad (0: pequeña, 1: mediana, 2: grande).
 */
module sff8200Model(length = 0, thickness = 5, screw = 0, slot = 15, tolerance = 0.3, type = 0)
{
    _A = sff8200(tolerance, type);
    modelBox(
        _A[4],
        _A[1],
        length ? length : _A[6],
        thickness,
        screw ? screw : _A[0],
        slot,
        [
            [ _A[23], _A[6] - _A[52] ],
            [ _A[23], _A[6] - _A[53] ]
        ],
        [
            [ _A[28],         _A[6] - _A[50] ],
            [ _A[28],         _A[6] - _A[51] ],
            [ _A[4] - _A[28], _A[6] - _A[50] ],
            [ _A[4] - _A[28], _A[6] - _A[51] ]
        ]
    );
}
//----------------------------------------------------------
/**
 * Dibuja una bandeja que puede insertarse en una ranura donde va una unidad de 3.5".
 *
 * @param {Float}   length    Longitud de la unidad a generar.
 * @param {Float}   thickness Grosor del bloque donde se insertará el modelo.
 * @param {Float}   screw     Diámetro del tornillo a usar.
 * @param {Float}   slot      Longitud de la ranura donde se insertarán los tornillos.
 * @param {Float}   tolerance Valor a usar para ajustar las medidas estándar.
 * @param {Boolean} sides     Lados a eliminar de la bandeja.
 * @param {Integer} type      Define la altura según el tipo de unidad (0: más grande, 8: más pequeña).
 */
module sff8200Tray(length = 0, thickness = 5, screw = 0, slot = 15, tolerance = 0.3, sides = [ "a", "t" ], type = 0)
{
    _A = sff8200(tolerance, type);
    boxTray(_A[4], _A[1], length ? length : _A[6], thickness, sides)
    {
        sff8200Model(length, thickness, screw  ? screw : _A[0], slot, tolerance, type);
    }
}
