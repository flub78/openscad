 /**
 * Dibuja un tubo cuadrado con 2 líneas en X y un eje que lo atraviesa.
 *
 * @param {Float} side      Tamaño de cada lado del tubo.
 * @param {Float} length    Longitud del tubo.
 * @param {Float} diameter  Diámetro del eje que lo atraviesa.
 * @param {Float} thickness Grosor de las paredes del tubo.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Box/x.scad
 * @license CC-BY-NC-4.0
 */
module boxX(side, length, diameter, thickness)
{
    _angle = 45;
    // Valor inútil pero permite que OpenSCAD renderice los trazos en modo preview.
    _epsilon = $preview ? 0.001 : 0; 
    _side  = side - thickness * 2;
    difference()
    {
        union()
        {
            difference()
            {
                cube([  side,  side, length ], center = true);
                cube([ _side, _side, length + _epsilon ], center = true);
            }
            for(_n = [ -1, 1 ])
            {
                rotate(_n * _angle)
                {
                    cube([ norm([ _side, _side ]), thickness, length ], center = true);
                }
            }
            cylinder(d = diameter + thickness * 2, h = length, center = true);
        }
        cylinder(d = diameter, h = length + _epsilon, center = true);
    }
}
