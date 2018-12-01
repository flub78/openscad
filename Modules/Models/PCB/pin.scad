/**
 * Módulo que genera un pin de un conector.
 *
 * @param {Float} length Longitud del pin (eje Z).
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Models/PCB/pin.scad
 * @license CC-BY-NC-4.0
 */
module pcbPin(length = 0)
{
    _l = length
        ? length
        : 6.75 + 2.50 + 2.90;
    intersection()
    {
        cylinder(d = 2.54, h = 2.29, center = true, $fn = 4);
        rotate([ 0, 0, 45 ])
        {
            cylinder(d = 3.0, h = 2.29, center = true, $fn = 4);
        }
    }
    translate([ 0, 0, _l / 2 - 2.50 / 2 - 2.90 ])
    {
        cylinder(d = 0.66, h = _l, center = true, $fn = 4);
        for (z = [ -1, 1 ])
        {
            translate([ 0, 0, z * (_l / 2 + 0.38) ])
            {
                rotate([ 90 * (z - 1), 0, 0 ])
                {
                    cylinder(d1 = 0.66, d2 = 0.28, h = 0.76, center = true, $fn = 4);
                }
            }
        }
    }
}
pcbPin();