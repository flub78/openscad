/**
 * Dibuja las palas de una hélice recta.
 *
 * @param diameter  Diámetro de la hélice.
 * @param height    Altura de la hélice.
 * @param thickness Grosor de las paredes de las palas.
 * @param angles    Ángulos de las palas.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Shapes/propeller.scad
 * @license CC-BY-NC-4.0
 */
module propeller(diameter, height, thickness = 1.2, angles = [ 0, 90 ])
{
    for (angle = angles)
    {
        rotate([0, 0, angle])
        {
            translate([ - thickness / 2, - diameter / 2, 0 ])
            {
                cube([ thickness, diameter, height ]);
            }
        }
    }
}
