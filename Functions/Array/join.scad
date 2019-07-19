/**
 * Concatena un array usando el texto especificado.
 *
 * Ejemplo:
 *
 * echo(arrayJoin([ 5, 1 ], "-")); // 5-1
 *
 * @param {Array}   array Array con los valores a concatenar.
 * @param {String}  glue  Texto usado para unir los valores.
 * @param {Integer} last  Índice del último elemento a concatenar.
 * @param {String}  value Valor al que se le concatenarán los valores del array.
 *
 * @author  Joaquín Fernández
 * @license CC-BY-NC-4.0
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/Array/join.scad
 */

function arrayJoin(array, glue = ",", last = undef, value = "") = let (_i = last == undef ? len(array) - 1 : last)
    _i < 0
        ? value
        : arrayJoin(array, glue, _i - 1, value ? str(array[_i], glue, value) : str(array[_i]));
