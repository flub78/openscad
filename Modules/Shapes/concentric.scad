/**
 * Repite una forma 2D generando un patrón concéntrico centrado.
 *
 * @param {Float} diameter  Diámetro del patrón a generar (eje radial).
 * @param {Float} width     Ancho de cada elemento (eje circular).
 * @param {Float} height    Altura de cada elemento (eje radial).
 * @param {Float} thickness Grosor de las paredes del patrón.
 * @param {Float} from      Valor inicial del radio donde se va a empezar (eje radial).
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Shapes/concentric.scad
 * @license CC-BY-NC-4.0
 */
module concentric(diameter, width, height, thickness, from = 0)
{
    _dc = width  + thickness;
    _dr = height + thickness;
    for (_x = [ from : _dr : (diameter - _dr) / 2 ])
    {
        _l = 2 * PI * _x;
        _a = 360 / floor(_l / _dc);
        for (_b = [ 0 : _a : 360 ])
        {
            rotate(_b)
            {
                translate([ _x, 0 ])
                {
                    rotate(-_b)
                    {
                        children();
                    }
                }
            }
        }
    }
}
