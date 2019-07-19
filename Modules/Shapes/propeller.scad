/**
 * Dibuja las palas de una hélice recta.
 *
 * @param diameter  Diámetro de la hélice.
 * @param height    Altura de las palas.
 * @param thickness Grosor de las paredes de las palas.
 * @param angles    Ángulos de las palas.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Shapes/propeller.scad
 * @license CC-BY-NC-4.0
 */
module propeller(diameter, height, thickness = 1.2, angles = [ 0, 60, 120, 180, 240, 300 ])
{
    linear_extrude(height, convexity = 10)
    {
        // Dibujamos las palas
        for (angle = angles)
        {
            rotate(angle)
            {
                translate([ - thickness / 2, 0 ])
                {
                    square([ thickness, diameter / 2 ]);
                }
            }
        }
        // Redondeado de la unión.
        circle(d = thickness);
    }
}
