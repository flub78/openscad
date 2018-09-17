use <../Shapes/propeller.scad>
/**
 * Dibuja un clindro con un agujero concéntrico como en una tubería
 * teniendo la posibilidad de realizar muescas en las paredes.
 *
 * @param {Number}   diameter  Diámetro del cilindro.
 * @param {Number}   height    Altura del cilindro.
 * @param {Number}   thickness Grosor de las paredes del cilindro.
 * @param {Number[]} angles    Ángulos de las muescas o un array
 *                             vacío para hacer las paredes sólidas.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Cylinder/hollow.scad
 * @license CC-BY-NC-4.0
 */
module cylinderHollow(diameter, height, thickness = 1, angles = [])
{
    if (diameter && height && thickness)
    {
        difference()
        {
            cylinder(d = diameter, h = height);
            cylinder(d = diameter - thickness * 2, h = height);
            if (angles)
            {
                propeller(diameter, height, thickness, angles);
            }
        }
    }
}