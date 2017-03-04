/**
 * Devuelve la suma de un array hasta el índice especificado:
 *
 * Ejemplo:
 *
 * in = [ 1, 2, 3, 4 ];
 * echo(arraySum(in, 0)); // 1
 * echo(arraySum(in, 1)); // 3
 * echo(arraySum(in, 2)); // 6
 * echo(arraySum(in, 3)); // 10
 *
 * @param {Array}  array   Array multidimensional a usar para obtener los valores.
 * @param {Number} index   Índice del array a partir del cual empezar a sumar.
 * @param {Number} initial Valor inicial al que se le sumará el resultado.
 *
 * @author  Joaquín Fernández
 * @license CC-BY-NC-4.0
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/Array/sum.scad
 */
function arraySum(array, index, total = 0) = index > 0
    ? arraySum(array, index - 1, total + array[index])
    : total + (array[index] == undef ? 0 : array[index]);
