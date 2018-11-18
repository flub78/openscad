/**
 * Modelos y variables según la especificación SFF-8300.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Models/SFF/8300.scad
 * @license CC-BY-NC-4.0
 *
 * @see     SFF-8300 3.5" Form Factor Drives
 */
//----------------------------------------------------------
use <../../Box/tray.scad>
use <../box.scad>
//----------------------------------------------------------
/**
 * Devuelve las especificaciones de las medidas según SFF-8300.
 *
 * @param {Float}   tolerance Tolerancia a usar para ajustar las medidas.
 * @param {Integer} type      Tipo de unidad (0: pequeña, 1: mediana, 2: grande).
 *
 * @return {Float[]}
 */
function sff8300(tolerance = 0, type = 1) = [
      3.00, // Diámetro del tornillo
     type == 0 ? 42.00 : (type == 1 ? 26.10 : 17.80) + tolerance,
    147.00 + tolerance,
    101.60 + tolerance,
     95.25 + tolerance,
      3.18,
     44.45 + tolerance / 2,
     41.28 + tolerance / 2,
     28.50 + tolerance / 2,
    101.60 + tolerance / 2,
      6.35 + tolerance / 2,
      0.25,
      0.50,
     76.20 + tolerance / 2
];
//----------------------------------------------------------
/**
 * Dibuja un modelo de una unidad de 3.5" según la especificación SFF-8300.
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
module sff8300Model(length = 0, thickness = 5, screw = 0, slot = 15, tolerance = 0.3, type = 0)
{
    _A = sff8300(tolerance, type);
    modelBox(
        _A[3],
        _A[1],
        length ? length : _A[2],
        thickness,
        screw ? screw : _A[0],
        slot,
        [
            [ _A[10], _A[2] - _A[8]         ],
            [ _A[10], _A[2] - _A[8] - _A[9] ]
        ],
        [
            [ _A[5],         _A[2] - _A[7]          ],
            [ _A[5],         _A[2] - _A[7] - _A[6]  ],
            [ _A[5],         _A[2] - _A[7] - _A[13] ],
            [ _A[3] - _A[5], _A[2] - _A[7]          ],
            [ _A[3] - _A[5], _A[2] - _A[7] - _A[6]  ],
            [ _A[3] - _A[5], _A[2] - _A[7] - _A[13] ]
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
 * @param {Integer} type      Define la altura según el tipo de unidad (0: grande, 1: mediana, 2: pequeña).
 */
module sff8300Tray(length = 0, thickness = 5, screw = 0, slot = 15, tolerance = 0.3, sides = [ "a", "t" ], type = 1)
{
    _A = sff8300(tolerance, type);
    boxTray(_A[3], _A[1], length ? length : _A[2], thickness, sides)
    {
        sff8300Model(length, thickness, screw  ? screw : _A[0], slot, tolerance, type);
    }
}
