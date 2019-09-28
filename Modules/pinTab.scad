/**
 * Módulo que permite dibujar un pin con una pestaña en un extremo.
 *
 * Esta pestaña puede ser asimétrica como las usadas en una 
 * ingletadora o en una mesa de trabajo.
 *
 * En el otro extremo se puede escoger entre un cilindro sólido o hueco en 
 * función del parámetro `thickness`.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/pinTab.scad
 * @license CC-BY-NC-4.0
 */
use <./Cylinder/hollow.scad>
/**
 * Dibuja un pin con una pestaña redondeada.
 *
 * @param {Number} diameter  Diámetro del pin.
 * @param {Number} tabLength Altura de la pestaña.
 * @param {Number} pinLength Altura del pin. Si no se especifica se usa `tabLength`
 * @param {Number} thickness Grosor de las paredes del pin (0 para que sea sólido).
 */
module pinTab(diameter, tabLength, pinLength = 0, thickness = 0, angles = [])
{
    if (diameter)
    {
        union()
        {
            hull()
            {
                cylinder(d = diameter * 1.25, h = tabLength);
                translate([ diameter, 0, 0 ])
                {
                    cylinder(d = diameter * 0.5, h = tabLength);
                }
            }
            translate([ 0, 0, tabLength ])
            {
                _h = pinLength ? pinLength : tabLength;
                if (thickness)
                {
                    cylinderHollow(diameter, _h, thickness, angles);
                }
                else
                {
                    cylinder(d = diameter, h = _h);
                }
            }
        }
    }
}