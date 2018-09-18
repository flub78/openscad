/**
 * Aproxima el valor especificado al múltiplo superior
 * más cercano del valor de referencia.
 * Su principal uso es aproximar por exceso un valor a
 * un `layerHeight` superior para dejar margen.
 *
 * @param value Valor a aproximar.
 * @param ref   Valor a usar como referencia.
 *
 * @author  Joaquín Fernández
 * @license CC-BY-NC-4.0
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/ceilMultiple.scad
 */
function ceilMultiple(value, ref) = ceil(value / ref) * ref;
