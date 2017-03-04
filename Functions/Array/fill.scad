/**
 * Crea un array de `n` elementos inicializados con el valor especificado.
 * Si se especifica `values`, se concatenan elementos hasta llegar a los
 * `n` elementos.
 *
 * Ejemplo:
 *
 * echo(arrayFill(5, 1)); // [ 1, 1, 1, 1, 1 ]
 *
 * @param {Number} count  Cantidad de elementos que tendrá el array.
 * @param {Number} value  Valor a inicializar los elementos del array.
 * @param {Array}  values Array con valores previos.
 *
 * @author  Joaquín Fernández
 * @license CC-BY-NC-4.0
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/Array/fill.scad
 */
function arrayFill(count, value, values = []) = len(values) < count
    ? arrayFill(count, value, concat(values, [ value ]))
    : values;
