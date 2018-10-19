/**
 * Diversas funciones para detectar el tipo de datos de un valor.
 *
 * @author  Joaquín Fernández
 * @license CC-BY-NC-4.0
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/is.scad
 */

 /**
 * Verifica si el valor es un array
 *
 * @param value Valor a verificar.
 *
 * @return `true` si el valor es un array.
 */
function isArray(x) = len(x) != undef && !isString(x);

/**
 * Verifica si el valor es un booleano
 *
 * @param value Valor a verificar.
 *
 * @return `true` si el valor es un booleano.
 */
function isBool(x) = !isString(x) && (str(x) == "true" || str(x) == "false");

/**
 * Verifica si el valor es un texto
 *
 * @param value Valor a verificar.
 *
 * @return `true` si el valor es un texto.
 */
function isString(x) = x != undef && len(x) != undef && len(str(x,x)) == len(x) * 2;
