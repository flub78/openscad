/**
 * Genera un gancho en forma de J.
 * El gancho permite insertarle un pin a modo de tope.
 *
 * @param width       Longitud del gancho (Eje X).
 * @param height      Anchura del gancho (Eje Y).
 * @param length      Altura del óvalo (Eje Z).
 * @param diameter    Diámetro interno de la J.
 * @param pinPosition Porcentaje de la altura donde se colocará el pin (0.0 <= x <= 1.0).
 * @param pinDiameter Diámetro del pin
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Shapes/hook.scad
 * @license CC-BY-NC-4.0
 */
module hook(width = 20, height = 10, length = 10, diameter = 8, pinPosition = 0.0, pinDiameter = 2)
{
    _border = (height - diameter) / 2;
    translate([ height / 2 - width / 2, 0, 0 ])
    {
        difference()
        {
            union()
            {
                difference()
                {
                    cylinder(d = height, h = length);
                    cylinder(d = diameter, h = length);
                    translate([ 0, - height / 2, 0 ])
                    {
                        cube([ height, height, length ]);
                    }
                }
                translate([ 0, (_border + diameter) / 2, 0 ])
                {
                    cylinder(d = _border, h = length);
                }
                translate([ 0, - height / 2, 0 ])
                {
                    cube([ width - height / 2, _border, length ]);
                }
            }
            if (pinDiameter && pinPosition)
            {
                translate([ 0, height / 2, length * pinPosition ])
                {
                    rotate([ 90, 0, 0 ])
                    {
                        cylinder(d = pinDiameter, h = height);
                    }
                }
            }
        }
    }
}
