/**
 * Módulos para trabajar con arcos.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Cylinder/arc.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3353054
 */
//-----------------------------------------------------------------------------
/**
 * Dibuja un arco entre dos ángulos.
 *
 * @param {Float} from      Ángulo inicial.
 * @param {Float} to        Ángulo final.
 * @param {Float} radius    Radio del arco.
 * @param {Float} thickness Grosor del arco.
 */
module arc(from = 0, to = 360, radius = 1, thickness = 0.1) {
    _outer = radius + thickness / 2;
    _inner = radius - thickness / 2;
    _from  = min(from, to);
    _to    = max(from, to);
    _step  = (_to - _from) / ($fn ? $fn : 10);
    polygon(
        points = [
            for(_angle = [ _from :  _step : _to   ])
                [ cos(_angle), sin(_angle) ] * _outer,
            for(_angle = [ _to   : -_step : _from ])
                [ cos(_angle), sin(_angle) ] * _inner
        ]
    );
}
/**
 * Dibuja un conjunto de arcos concéntricos entre dos radios.
 *
 * @param {Float}   from      Radio inicial.
 * @param {Float}   to        Radio final.
 * @param {Float}   thickness Grosor de cada arco.
 * @param {Float[]} angles    Valor de los ángulos inicial y final de cada arco.
 * @param {Float}   delta     Valor para el incremento del radio.
 *                          Si no se especifica se usa el mismo valor que el radio inicial.
 */
module arcs(from, to, thickness, angles = [ 0, 360 ], delta = 0)
{
    if (from > 0)
    {
        for (_radius = [ from : delta ? delta : from : to ])
        {
            arc(angles[0], angles[1], _radius, thickness);
        }
    }
}
