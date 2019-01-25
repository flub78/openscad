/**
 * Diversas funciones para trabajar con ecuaciones de la recta.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/Math/line.scad
 * @license CC-BY-NC-4.0
 */
//-----------------------------------------------------------------------------
use <./trigonometry.scad>
//-----------------------------------------------------------------------------
infinity = 1e299;
/**
 * Dadas dos líneas que se cortan, devuelve la bisectriz.
 *
 * @param {Float[]} line1 Especificación de la línea 1 (0: Ax, 1: By, 2: C).
 * @param {Float[]} line2 Especificación de la línea 2 (0: Ax, 1: By, 2: C).
 *
 * @return {Float[]|undef}
 */
function bisectrix(line1, line2) = let(r1 = line1 * mod(line2), r2 = line2 * mod(line1)) [ r1 + r2, r1 - r2 ];

/**
 * Devuelve las coordenadas para el punto especificado tomando como referencia el eje X.
 *
 * @param {Float[]} eq    Ecuación en formato [ Ax, By, C ].
 * @param {Float}   value Valor a usar para evaluar la función.
 *
 * @return {Float[]} Coordenada resultado de la evaluación de la función.
 */
function coordX(eq, value) = eq[1] == 0
    ? [ - eq[2] / eq[0], value                             ]
    : [ value          , - (eq[0] * value + eq[2]) / eq[1] ];

/**
 * Devuelve las coordenadas para el punto especificado tomando como referencia el eje Y.
 *
 * @param {Float[]} eq    Ecuación en formato [ Ax, By, C ].
 * @param {Float}   value Valor a usar para evaluar la función.
 *
 * @return {Float[]} Coordenada resultado de la evaluación de la función.
 */
function coordY(eq, value) = eq[0] == 0
    ? [ value                            , - eq[1] / eq[0] ]
    : [ - (eq[1] * value + eq[2]) / eq[0], value           ];

/**
 * Devuelve el vector director de una equación.
 *
 * @param {Float[]} eq Especificación de la ecuación (0: Ax, 1: By, 2: C).
 *
 * @return {Float[]}
 */
function director(eq) = [ - eq[1], eq[0] ];

/**
 * Devuelve el módulo de una ecuación de una recta.
 *
 * @param {Float[]} Equación de entrada.
 *
 * @return {Float} Vector director.
 */
function mod(eq) = eq[0] == undef
    ? eq[1]
    : eq[1] == undef
        ? eq[0]
        : norm([ eq[0], eq[1] ]);

/**
 * Devuelve el ángulo entre las dos rectas especificadas.
 *
 * @param {Float[]} eq1 Ecuación de la recta 1 en formato [ Ax, By, C ].
 * @param {Float[]} eq2 Ecuación de la recta 2 en formato [ Ax, By, C ].
 *
 * @return {Float}
 */
function getAngle(eq1, eq2, common) = acos(director(eq1) * director(eq2) / (mod(eq1) * mod(eq2)));

/**
 * Devuelve el ángulo entre las líneas formadas por los puntos especificados.
 *
 * @param {Float[]} point1 Punto de una recta en formato [ x, y ].
 * @param {Float[]} point2 Punto de la otra recta en formato [ x, y ].
 * @param {Float[]} common Punto común a las 2 rectas en formato [ x, y ].
 *
 * @return {Float}
 */
function getAnglePoints(point1, common, point2) = getAngle(getEq(point1, common), getEq(point2, common));

/**
 * Devuelve la ecuación de la recta que pasa por los puntos especificados.
 *
 * @param {Float[]} point1 Punto 1 de la recta en formato [ x, y ].
 * @param {Float[]} point2 Punto 2 de la recta en formato [ x, y ].
 *
 * @return {Float[]} Ecuación en formato [ Ax, By, C ].
 */
function getEq(point1, point2) = let(m = slope(point1, point2)) m == infinity
    ? [ -1,  0, point1[0]                 ]
    : [ m , -1, point1[1] - m * point1[0] ];

/**
 * Devuelve la pendiente de la recta que pasa por los puntos especificados.
 *
 * @param {Float[]} point1 Punto 1 de la recta en formato [ x, y ].
 * @param {Float[]} point2 Punto 2 de la recta en formato [ x, y ].
 *
 * @return {Float}
 */
function slope(point1, point2) = point1[0] == point2[0]
    ? infinity
    : (point2[1] - point1[1]) / (point2[0] - point1[0]);

/**
 * Dados 3 puntos de 2 rectas secantes, devuelve los puntos necesarios para realizar un empalme
 * así como el ángulo formado por ambas líneas.
 *
 * @param {Float[]} point1    Punto de una recta en formato [ x, y ].
 * @param {Float[]} point2    Punto de la otra recta en formato [ x, y ].
 * @param {Float[]} common    Punto común a las 2 rectas en formato [ x, y ].
 * @param {Float}   radius    Radio del empalme.
 * @param {Float}   tolerance Tolerancia a usar. Permite ajustar la curva según se quiera hacer una resta o una suma.
 *                            Un signo contrario cambia las coordenadas hacia el otro lado de la bisectriz.
 *
 * @return {Float[]}
 */
function splice(point1, point2, common, radius, tolerance = 1) = let(
        eq1   = getEq(point1, common),
        eq2   = getEq(point2, common),
        bis   = bisectrix(eq1, eq2),
        angle = getAngle(eq1, eq2),
        ba0   = getAngle(bis[0], eq1),
        ba1   = getAngle(bis[1], eq1),
        b     = bis[ba0 < ba1 ? 1 : 0],
        a     = getAngle(b, getEq([0, 0], [0, 50 ])),
        cc    = coordX(b, common[0] + tolerance * radius * cos(90 - a))
    ) [ tang(eq1, radius, cc), cc, tang(eq2, radius, cc) ];

/**
 * Devuelve el punto donde la recta y la circunferencia son tangentes.
 *
 * x^2(1 + D'^2) + x(2D'F' - 2a - 2bD') + (F'^2 - 2bF' + C) = 0
 * y^2(1 + E'^2) + y(2E'F' - 2aE' - 2b) + (F'^2 - 2aF' + C) = 0
 *
 */
function tang(line, radius, center) = let(
        y  = line[1] == 0,
        e  = y
            ? - [ line[1], line[2] ] / line[0]
            : - [ line[0], line[2] ] / line[1],
        a  = 1 + e[0] * e[0],
        b  = y
            ? 2 * e[0] * e[1] - 2 * center[0] * e[0] - 2 * center[1]
            : 2 * e[0] * e[1] - 2 * center[0]        - 2 * center[1] * e[0],
        C  = e[1] * e[1] - 2 * center[1] * e[1] + center[0] * center[0] + center[1] * center[1] - radius * radius,
        x  = - b / (2 * a)
    ) y
        ? coordY(line, x)
        : coordX(line, x);

/**
 * Módulo auxiliar para depurar el resultado de las funciones anteriores.
 */
module drawLine(eq, range, radius = 0.1, color = "Red")
{
    for (_value = [ range[0] : radius : range[1] ])
    {
        color(color)
        {
            translate(coordX(eq, _value))
            {
                circle(r = radius);
            }
        }
    }
}
