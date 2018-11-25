 /**
 * Módulo para generar los espacios para colocar fuentes ATX12V en los diseños.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Models/PSU/ATX12V.scad
 * @license CC-BY-NC-4.0
 */
//----------------------------------------------------------
use <./model.scad>
//----------------------------------------------------------
function atx12v(tolerance = 0) = [
    150.0 + tolerance, // Ancho (eje X)
     86.0 + tolerance, // Alto (eje Y),
    140.0 + tolerance, // Largo (eje Z)
    // Tornillos
    [ 
        [ -69.0,  27.0 ],
        [ -69.0, -37.0 ],
        [  45.0,  37.0 ],
        [  69.0, -37.0 ]
    ],
    // Panales
    [ 
        [ -28.0, 0.0, 75.0, 65.0 ]
    ],
    [
        // Tacens Anima APII 500
        [
//            [ 20.2, -10.0, 50.0, 24.0 ],
//            [ 34.2,  14.6, 21.0, 14.5 ],
            [ 19.8,  -9.5, 51.8, 23.5 ],
            [ 34.5,  14.0, 22.0, 15.1 ],
        ]
    ]
];

/**
 * Genera un modelo que puede ser usado como negativo para marcar los tornillos y
 * rectángulos de la fuente.
 *
 * @param {Float}   thickness Grosor de las paredes donde se imprimirá el modelo.
 * @param {Integer} modelo    Identificador del modelo de fuente a usar.
 * @param {Float}   tolerance Tolerancia a usar en las medidas.
 */
module atx12vModel(thickness = 5, model = 0, tolerance = 0.9)
{
    psuModel(atx12v(tolerance), thickness, model);
}
