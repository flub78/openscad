/**
 * Genera un contenedor para puntas de impresión.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Storage/Pringles/nozzles.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3615660
 */
//---------------------------------------------------------------
use <./container.scad>
use <./constants.scad>
//---------------------------------------------------------------
constants  = getConstants();
INNER      = constants[0];
THICKNESS  = constants[3];
//---------------------------------------------------------------
/**
 * Obtiene el valor máximo en Y a partir de X.
 *
 * @param {Float} x Valor de la coordenada X.
 *
 * @return {Float} Valor máximo de Y.
 */
function calc(x) = sqrt(pow(INNER / 2, 2) - pow(x, 2)) * 2 - THICKNESS;

/**
 * Dibuja la llave allen para dejar el espacio mediante diferencia.
 *
 * @param {Float} width    Ancho de la llave (eje X).
 * @param {Float} height   Alto de la llave (eje Y).
 * @param {Float} diameter Diámetro de la llave.
 */
module allen(width = 20, height = 50, diameter = 2)
{
    _delta = diameter * 3;
    difference()
    {
        union()
        {
            translate([ width / 2, 0 ])
            {
                rotate([ 90, 0, 0 ])
                {
                    cylinder(d = diameter, h = height, center = true);
                }
            }
            translate([ 0, height / 2 ])
            {
                rotate([ 0, 90, 0 ])
                {
                    cylinder(d = diameter, h = width, center = true);
                }
            }
        }
        translate([ width / 2, height / 2 ])
        {
            cube(_delta, center = true);
        }
    }
    translate([ width / 2 - _delta / 2, height / 2 - _delta / 2 ])
    {
        rotate_extrude(angle = 90)
        {
            translate([ _delta / 2, 0 ])
            {
                circle(d = diameter);
            }
        }
    }
}

/**
 * Repite la figura 2D y genera el patrón a extruir.
 *
 * @param {Float} length    Longitud del segmento (eje Y).
 * @param {Float} width     Ancho que ocupa de la figura 2D.
 * @param {Float} height    Alto que ocupa de la figura 2D.
 * @param {Float} thickness Grosor de las paredes a dejar entre las figuras.
 */
module drawShape(length, width, height, thickness)
{
    _count = floor((length + thickness) / (height + thickness));
    _total = _count * (height + thickness) - thickness;
    for (_n = [ 0 : _count - 1 ])
    {
        translate([ 0, _n * (height + thickness) - (_total - height) / 2 ])
        {
            children();
        }
    }
}

/**
 * Dibuja el contenedor para almacenar solamente puntas de impresión.
 *
 * @param {Float}  length   Altura total de la punta (eje Z).
 * @param {Float}  plength  Altura de la rosca de la punta (eje Z).
 * @param {Float}  diameter Diámetro de la punta.
 * @param {String} type     Tipo de patrón a usar ("conc" o "rect").
 */
module nozzles(length = 14, plength = 6, diameter = 6, type = "conc")
{
    if (type == "conc")
    {
        conc(length, plength, 6, 6, 1.5)
        {
            circle(d = diameter);
        }
    }
    else if (type == "rect")
    {
        rect(length, plength, 6, 6, 1.5)
        {
            circle(d = diameter);
        }
    }
}

/**
 * Dibuja el contenedor para puntas de impresión, bloque del extrusor y llaves allen.
 *
 * @param {Float} length   Longitud del contenedor (eje Z).
 * @param {Float} plength  Longitud del patrón (eje Z).
 * @param {Float} diameter Diámetro de la punta.
 */
module nozzlesAll(length = 31, plength = 12, diameter = 6)
{
    _allen = 2.5;
    _block = [ 20.6, 10.6 ];
    difference()
    {
        from2dChildren(31, plength, str("nozzles-", length, "x", plength))
        {
            drawShape(calc(_block[0] / 2) - 2 * _allen, _block[0], _block[1], 1.5)
            {
                square(_block, center = true);
            }
            // Puntas estrechas
            for (_x = [ -16.7, - 23.7, -30.7 ])
            {
                translate([ _x, 0 ])
                {
                    drawShape(calc(_x), 7.5, 7.5, 0.3)
                    {
                        circle(d = diameter);
                    }
                }
            }
            // Puntas anchas
            for (_x = [ 18, 27.5 ])
            {
                translate([ _x, 0 ])
                {
                    drawShape(calc(_x), 10, 10, 0)
                    {
                        circle(d = diameter);
                    }
                }
            }
        }
        for (_s = [ -1, 1 ])
        {
            translate([ _s * 2, _s * 8, plength + 2 * THICKNESS ])
            {
                rotate([ 0, 0, 90 - _s * 90 ])
                {
                    allen(diameter = _allen);
                }
            }
        }
    }
}
//-----------------------------------------------------------------------------
$fn = $preview ? 30 : 180;
difference()
{
    nozzlesAll();
    title("NOZZLES", size = 6);
}
