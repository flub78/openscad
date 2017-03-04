/**
 * Devuelve un array con cada uno de los elementos de
 * un subarray según el índice especificado.
 *
 * Ejemplo:
 *
 * in = [ [ 0, 1 ], [ 2, 3 ] ];
 * echo(arrayFlatten(in, 0)); // [ 0, 2 ]
 * echo(arrayFlatten(in, 1)); // [ 1, 3 ]
 *
 * @param {Array}  array Array multidimensional a usar para obtener los valores.
 * @param {Number} column Columna de los subarray para extraer sus valores.
 * @param {Number} row    Fila del array siendo procesada.
 * @param {Array}  output Acumulador donde se van metiendo los valores.
 *                        Si se pasa algún valor, se concatenan al resultado.
 *
 * @author  Joaquín Fernández
 * @license CC-BY-NC-4.0
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/Array/flatten.scad
 */
function arrayFlatten(array, column = 0, row = 0, output = []) = row > 0
    ? arrayFlatten(array, column, row - 1, concat(output, [ array[row][column] ]))
    : concat(output, [ array[row][column] ]);
