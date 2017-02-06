/**
 * Aproxima el valor especificado al múltiplo inferior
 * más cercano del valor de referencia.
 * Su principal uso es aproximar por defecto un valor a 
 * un `layerHeight` inferior para dejar margen.
 *
 * @param value Valor a aproximar.
 * @param ref   Valor a usar como referencia.
 */
function floorMultiple(value, ref) = floor(value / ref) * ref;