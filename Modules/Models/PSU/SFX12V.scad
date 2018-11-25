 /**
 * Módulo para generar los espacios para colocar fuentes SFX12V en los diseños.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Models/PSU/SFX12V.scad
 * @license CC-BY-NC-4.0
 */
//----------------------------------------------------------
use <./model.scad>
//----------------------------------------------------------
function sfx12v(tolerance = 0) = [
    125.0 + tolerance, // Ancho (eje X)
     63.5 + tolerance, // Alto (eje Y),
    100.0 + tolerance, // Largo (eje Z)
    [
        [ -113.0 / 2, -51.5 / 2 ],
        [ -113.0 / 2,  51.5 / 2 ],
        [  113.0 / 2, -51.5 / 2 ],
        [  113.0 / 2,  51.5 / 2 ],
    ],
    [
        [ -31.2, 0.0, 48.0, 48.0 ]
    ],
    [
        // TooQ TQEP-500S-SFX
        [
            [  15.2, -11.7, 31.0, 24.0 ],
            [  -2.5, -10.3, 15.0, 21.0 ],
        ]
    ]
];

/**
 * Genera un modelo que puede ser usado como negativo para marcar los tornillos y
 * rectángulos de la fuente.
 *
 * @param {Float}   thickness Grosor de las paredes donde se imprimirá el modelo.
 * @param {Integer} modelo    Modelo de fuente SFX.
 * @param {Float}   tolerance Tolerancia a usar en las medidas.
 */
module sfx12vModel(thickness = 5, model = 0, tolerance = 0.9)
{
    psuModel(sfx12v(tolerance), thickness, model);
}
