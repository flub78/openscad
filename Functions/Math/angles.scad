/**
 * Convierte el número de líneas que quieren dibujarse en una circunferencia
 * a un array con los ángulos que deben rotarse dichas líneas.
 *
 * @param end  Ángulo final
 * @param inc  Incremento para ir desde 0 hasta el ángulo final.
 * @param init Listado de ángulos iniciales.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/Math/angles.scad
 * @license CC-BY-NC-4.0
 */
function angles(end = 360, inc = 45, init = []) = end > 0
    ? angles(end - inc, inc, concat(init, [ end - inc ]))
    : init;