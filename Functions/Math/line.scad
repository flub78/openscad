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
/**
 * Dadas dos líneas que se cortan, devuelve la bisectriz.
 *
 * @param {Float[]} line1 Especificación de la línea 1 (0: pendiente, 1: coeficiente b).
 * @param {Float[]} line2 Especificación de la línea 2 (0: pendiente, 1: coeficiente b).
 *
 * @return {Float[]|undef}
 */
function bisectrix(line1, line2) = let(
        r1 = [ line1[0], line1[1], 1 ] * norm([ line2[0], 1 ]),
        r2 = [ line2[0], line2[1], 1 ] * norm([ line1[0], 1 ])
    ) r1[2] == r2[2]
        ? undef
        : [ r1[0] - r2[0], r1[1] - r2[1] ] / (r1[2] - r2[2]);

/**
 * Devuelve el ángulo entre las líneas formadas por los puntos especificados.
 *
 * @param {Float[]} point1 Punto de una recta en formato [ x, y ].
 * @param {Float[]} point2 Punto de la otra recta en formato [ x, y ].
 * @param {Float[]} common Punto común a las 2 rectas en formato [ x, y ].
 *
 * @return {Float}
 */
function getAngle(point1, point2, common) = let(
        eq1 = getEq(point1, common),
        eq2 = getEq(point2, common)
    )
    // atan((eq2[0] - eq1[0]) / (1 + eq2[0] * eq1[0]))
    acos((eq1[0] * eq2[0] + 1) / (norm([ eq1[0], 1 ]) * norm([ eq2[0], 1 ])));

/**
 * Devuelve la ecuación de la recta que pasa por los puntos especificados.
 *
 * @param {Float[]} point1 Punto 1 de la recta en formato [ x, y ].
 * @param {Float[]} point2 Punto 2 de la recta en formato [ x, y ].
 *
 * @return {Float[]} Ecuación en formato [ m, b ].
 */
function getEq(point1, point2) = let(m = slope(point1, point2)) [ m, point1[1] - m * point1[0] ];

/**
 * Devuelve la pendiente de la recta que pasa por los puntos especificados.
 *
 * @param {Float[]} point1 Punto 1 de la recta en formato [ x, y ].
 * @param {Float[]} point2 Punto 2 de la recta en formato [ x, y ].
 *
 * @return {Float}
 */
function slope(point1, point2) = (point2[1] - point1[1]) / (point2[0] - point1[0]);

/**
 * Dados 3 puntos de 2 rectas secantes, devuelve los puntos necesarios para realizar un empalme
 * así como el ángulo formado por ambas líneas.
 *
 * @param {Float[]} point1 Punto de una recta en formato [ x, y ].
 * @param {Float[]} point2 Punto de la otra recta en formato [ x, y ].
 * @param {Float[]} common Punto común a las 2 rectas en formato [ x, y ].
 * @param {Float}   radius Radio del empalme.
 *
 * @return {Float[]}
 */
function splice(point1, point2, common, radius) = let(
    x      = common[0],
    y      = common[1],
    eq1    = getEq(point1, common),
    eq2    = getEq(point2, common),
    angle  = getAngle(point1, point2, common),
    bis    = bisectrix(eq1, eq2),
    center = [ ((y - radius) - bis[1]) / bis[0], y - radius ],
    side   = pythagoras(norm([ x - center[0], y - center[1] ]), radius),
    x1     = x - side * cos(angle)
) [
    angle,
    [ x1, eq1[0] * x1 + eq1[1] ],
    center,
    [ x + side, y ]
];
