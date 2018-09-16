/**
 * Dibuja un prisma.
 *
 * @param width  Ancho de la base del prisma (eje X).
 * @param length Longitud del prisma (eje Y).
 * @param height Altura del prisma (eje Z).
 * @param angle  Si no se define `height` es el ángulo de la tercera cara
 *               del prisma y que permite calcular la altura (eje Z).
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Shapes/prism.scad
 * @license CC-BY-NC-4.0
 */
module prism(width, length, height = 0, angle = 45)
{
    _h = height ? height : width * tan(angle);
    translate([ - width / 2, length / 2, 0 ])
    {
        rotate([ 90, 0, 0 ])
        {
            linear_extrude(length)
            {
                polygon(
                    [
                        [ 0,     0  ],
                        [ 0,     _h ],
                        [ width, 0  ]
                    ]
                );
            }
        }
    }
}
