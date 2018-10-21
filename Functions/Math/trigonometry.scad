/**
 * Diversas funciones trigonométricas.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/Math/trigonometry.scad
 * @license CC-BY-NC-4.0
 */

/**
 * Devuelve el valor del lado de un triángulo aplicando la ley de los cosenos.
 *
 * @param {Float} sideA Lado A del triángulo.
 * @param {Float} sideB Lado B del triángulo.
 * @param {Float} angle Ángulo que forman el lado A y el lado B.
 *
 * @return {Float}
 */
function lawOfCosines(sideA, sideB, angle) = sqrt(
    pow(sideA, 2) + pow(sideB, 2) - 2 * sideA * sideB * cos(angle)
);

/**
 * Calcula el valor del lado de un triángulo a partir de 2 ángulos y
 * 1 lado usando la ley de los senos:
 *
 *   sideA    sideB
 *   -----  = -----
 *   angleA   angleB
 *
 * @param {Float} sideA  Lado A del triángulo.
 * @param {Float} angleA Ángulo opuesto al lado A.
 * @param {Float} angleB Ángulo opuesto al lado B que se quiere calcular.
 *
 * @return {Float}
 */
function saa(sideA, angleA, angleB) = sideA * sin(angleB) / sin(angleA);

/**
 * Calcula el valor del lado de un triángulo a partir de 1 ángulo y
 * 2 lados usando la ley de los senos:
 *
 *   sideA    sideB
 *   -----  = -----
 *   angleA   angleB
 *
 * @param {Float} sideA  Lado A del triángulo.
 * @param {Float} sideB  Lado B del triángulo.
 * @param {Float} angleA Ángulo opuesto al lado A.
 *
 * @return {Float}
 */
function ssa(sideA, sideB, angleA) = asin(sideB * sin(angleA) / sideA);

/**
 * Calcula el valor de un cateto a partir de la hipotenusa y el otro cateto
 * usando el teormea de Pitágoras.
 *
 * @param {Float} hyp  Valor de la hipotenusa.
 * @param {Float} side Lado del triángulo.
 *
 * @return {Float}
 */
function pythagoras(hyp, side) = sqrt(pow(hyp, 2) - pow(side, 2));
