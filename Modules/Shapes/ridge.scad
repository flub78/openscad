/**
 * Dibuja una cresta.
 *
 * @param width  Anchura de la cresta (Eje X).
 * @param height Altura de la cresta (Eje Y).
 * @param length Longitud de la cresta (Eje Z).
 * @param count  Cantidad de veces a repetir la gráfica (Eje X).
 * @param ratio  Relación de la cresta con respecto a la base.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Shapes/ridge.scad
 * @license CC-BY-NC-4.0
 */
module ridge(width, height, length, count = 1, ratio = 0.75)
{
    scale([ width / count, height / 2, 1 ])
    {
        translate([ - 0.5 * count, - 0.5, 0 ])
        {
            linear_extrude(height = length, center = true)
            {
                _points = [
                    for (_x = [ 0 : count - 1 ]) [ 
                        [ _x        , 0 ],
                        [ _x + ratio, 1 ], 
                        [ _x + 1    , 1 ], 
                        [ _x + 1    , 0 ]
                    ]
                ];
                polygon(
                    points = [
                        for (_point = _points) for (_p = _point) _p
                    ]
                );
            }
        }
    }
}
