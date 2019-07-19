/**
 * Extrae de un array de arrays el valor que corresponde con el índice especificado.
 *
 * Ejemplo:
 *
 * ```
 * in = [ [ 1, 2 ], [ 3, 4 ] ];
 * echo(arrayPluck(in, 0, 0)); // [ 1 ]
 * echo(arrayPluck(in, 0, 1)); // [ 1, 3 ]
 * echo(arrayPluck(in, 0, 2)); // [ 1, 3, undef ]
 * echo(arrayPluck(in, 1, 0)); // [ 2 ]
 * echo(arrayPluck(in, 1, 1)); // [ 2, 4 ]
 * echo(arrayPluck(in, 1, 2)); // [ 2, 4, undef ]
 * echo(arrayPluck(in, 2, 0)); // [ undef ]
 * echo(arrayPluck(in, 2, 1)); // [ undef, undef ]
 * echo(arrayPluck(in, 2, 2)); // [ undef, undef, undef ]
 * ```
 *
 * @param {Array}   array   Array multidimensional a usar para obtener los valores.
 * @param {Integer} index   Índice del valor del array.
 * @param {Integer} to      Índice hasta el cual extraer los valores.
 * @param {Array}   values  Valores a los que se le concatenarán los valores extraídos.
 *
 * @author  Joaquín Fernández
 * @license CC-BY-NC-4.0
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/Array/pluck.scad
 */
function arrayPluck(array, index = 0, to = undef, values = []) = [
    for (_i = [ 0 : to == undef ? len(array) - 1 : to ]) array[_i][index]
];
