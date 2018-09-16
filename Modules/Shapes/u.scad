/**
 * Genera un perfil en forma de U.
 *
 * @param width     Anchura del perfil (Eje X).
 * @param length    Longitud del gancho (Eje Y).
 * @param height    Altura del óvalo (Eje Z).
 * @param thickness Grosor de las paredes.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Shapes/u.scad
 * @license CC-BY-NC-4.0
 */
module u(width, height, length, thickness = 10)
{
    difference()
    {
        cube(
            [
                width,
                height,
                length
            ],
            center = true
        );
        translate([ 0, 0, thickness / 2 ])
        {
            cube(
                [
                    width - 2 * thickness,
                    height,
                    length - thickness
                ],
                center = true
            );
        }
    }
}
