/**
 * Diversas utilidades para trabajar con array de arrays.
 *
 * @author  Joaquín Fernández
 * @license CC-BY-NC-4.0
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/Array/arrays.scad
 */
//-----------------------------------------------------------------------------
use <./sum.scad>
//-----------------------------------------------------------------------------
 /**
 * Devuelve un array con la longitud de cada subarray.
 *
 * Ejemplo:
 *
 * ```
 * echo(arraysLen([ [ 1, 2 ], [ 3] , [ 4, 5, 6 ] ])); //  [ 2, 1, 3 ]
 * ```
 *
 * Si se quisiera obtener la cantidad total los elementos en todos los arrays
 * se puede usar la función `arraySum`:
 *
 * ```
 * echo(arraySum(arraysLen([ [ 1, 2 ], [ 3 ] , [ 4, 5, 6 ] ]))); //  6
 * ```
 *
 * @param {Array} array Array multidimensional a usar para obtener los valores.
 *
 * @return {Integer[]}
 */
function arraysLen(array) = [ for (_a = array) len(_a) ];

/**
 * Devuelve un array con el mayor valor de cada subarray.
 *
 * Ejemplo:
 *
 * ```
 * echo(arraysMax([ [ 1, 2 ], [ 3 ] , [ 4, 5, 6 ] ])); //  [ 2, 3, 6 ]
 * ```
 *
 * @param {Array} array Array multidimensional a usar para obtener los valores.
 *
 * @return {Float[]}
 */
function arraysMax(array) = [ for (_a = array) max(_a) ];

/**
 * Devuelve un array con el menor valor de cada subarray.
 *
 * Ejemplo:
 *
 * ```
 * echo(arraysMin([ [ 1, 2 ], [ 3 ] , [ 4, 5, 6 ] ])); //  [ 1, 3, 4 ]
 * ```
 *
 * @param {Array} array Array multidimensional a usar para obtener los valores.
 *
 * @return {Float[]}
 */
function arraysMin(array) = [ for (_a = array) min(_a) ];

/**
 * Devuelve un array con la suma de cada subarray.
 *
 * Ejemplo:
 *
 * ```
 * echo(arraysSum([ [ 1, 2 ], [ 3 ] , [ 4, 5, 6 ] ])); //  [ 3, 3, 15 ]
 * ```
 *
 * Si se quisiera obtener la suma total de los elementos de todos los arrays
 * se puede usar la función `arraySum`:
 *
 * ```
 * echo(arraySum(arraysSum([ [ 1, 2 ], [ 3 ] , [ 4, 5, 6 ] ]))); //  21
 * ```
 *
 * @param {Array} array Array multidimensional a usar para obtener los valores.
 *
 * @return {Float[]}
 */
function arraysSum(array) = [ for (_a = array) arraySum(_a, len(_a) - 1) ];
