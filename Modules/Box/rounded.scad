/**
 * Dibuja un bloque con los bordes redondeados.
 *
 * @param width  Ancho del bloque (eje X).
 * @param height Largo del bloque (eje Y).
 * @param depth  Alto del bloque (eje Z).
 * @param radius Radio del borde.
 * @param shape  Tipo de figura a usar para redondear los bordes ('cylinder' por defecto.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Box/rounded.scad
 * @license CC-BY-NC-4.0
 */
module boxRounded(width, height, depth, radius = 1, shape = "cylinder")
{
    minkowski()
    {
        cube(
            size = [
                width  - radius * 2,
                height - radius * 2,
                depth  - radius
            ],
            center = true
        );
        if (shape == "cylinder")
        {
            cylinder(r = radius, h = radius, center = true);
        }
        else if (shape == "sphere")
        {
            sphere(r = radius, center = true);
        }
    }    
}
