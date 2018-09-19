/**
 * Genera un volumen a partir de una gráfica del seno de un ángulo.
 *
 * @param width     Anchura del seno (Eje X).
 * @param height    Altura del seno (Eje Y).
 * @param length    Longitud del seno (Eje Z).
 * @param count     Cantidad de veces a repetir la gráfica (Eje X).
 * @param increment Incremento a usar para iterar sobre los valores.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Shapes/sinusoid.scad
 * @license CC-BY-NC-4.0
 */
module sinusoid(width, height, length, count = 1, increment = 0.25)
{
    scale([ width / count, height / 2, 1 ])
    {
        linear_extrude(height = length, center = true)
        {
            translate([ - 0.25 - 0.5 * (count - 1), 0, 0 ])
            {
                polygon(
                    [
                        for (_n =  [-90 : increment : 270 + 360 * (count - 1) ]) [ 
                            _n / 360, 
                            sin(_n) 
                        ]
                    ]
                );
            }
        }
    }
}
