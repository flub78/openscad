/**
 * Funciones para convertir números en arrays.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/Array/toArray.scad
 * @license CC-BY-NC-4.0
 */
//---------------------------------------------------------------
use <./fill.scad>
//---------------------------------------------------------------
/**
 * Verifica si un valor es un array y en caso de no serlo devuelve
 * un array con `n` elementos donde cada valor es `1/n`, es decir,
 * la sumatoria del array generado siempre es 1.
 *
 * Ejemplo:
 *
 * echo(toArray(5)); // [ 0.2, 0.2, 0.2, 0.2, 0.2 ]
 *
 * @param {Array|Number} value Si no es un array es el valor a usar para inicializar los elementos del array.
 *
 * @return {Number[]}
 */
function toArray(value) = value[0] == undef
    ? value == 0
        ? []
        : arrayFill(value, 1 / value)
    : value;
/**
 * Verifica si un valor es un array y en caso de no serlo devuelve
 * un array con `n - 1` elementos donde cada valor es la sumatoria
 * de su valor más el valor acumulado.
 *
 * Ejemplo:
 *
 * echo(toArray(5)); // [ 0.2, 0.4, 0.6, 0.8 ]
 *
 * @param {Array|Number} value Si no es un array es el valor a usar para inicializar los elementos del array.
 *
 * @return {Number[]}
 */
function toArrayAcc(value, current = 0, output = []) = let(_v = value == 0 ? current : current + 1 / value)
    value[0] == undef
        ? value == 0
            ? output
            : _v < 1
                ? toArrayAcc(value, _v, concat(output, _v))
                : output
        : value;
