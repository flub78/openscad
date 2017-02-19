/**
 * Genera las piezas del tangram.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Games/Tangram.scad
 * @license CC-BY-NC-4.0
 * @see http://www.thingiverse.com/thing:2122508
 */
//---------------------------------------------------------
// Valores personalizables / Customizable values.
//---------------------------------------------------------
// Tamaño de cada lado.
side = 100;
// Separación entre piezas.
// Se recomienda usar un múltiplo del lineWidth a usar.
sep = 0.6;
// Grosor de las piezas.
thickness = 3;
// Indica si se dibuja la caja o las piezas.
drawBox = 0;
//---------------------------------------------------------
// Ruta de las piezas geométricas.
paths = [
    [
        // Triángulo Inf
        [ 0.00, 0.00 ],
        [ 0.50, 0.50 ],
        [ 1.00, 0.00 ]
    ],
    [
        // Triángulo Der
        [ 0.50, 0.50 ],
        [ 1.00, 1.00 ],
        [ 1.00, 0.00 ]
    ],
    [
        // Triángulo Sup Izq
        [ 0.00, 1.00 ],
        [ 0.50, 1.00 ],
        [ 0.00, 0.50 ]
    ],
    [
        // Triángulo Sup Der
        [ 0.50, 1.00 ],
        [ 1.00, 1.00 ],
        [ 0.75, 0.75 ]
    ],
    [
        // Triángulo Med Izq
        [ 0.25, 0.75 ],
        [ 0.50, 0.50 ],
        [ 0.25, 0.25 ]
    ],
    [
        // Cuadrado
        [ 0.25, 0.75 ],
        [ 0.50, 1.00 ],
        [ 0.75, 0.75 ],
        [ 0.50, 0.50 ]
    ],
    [
        // Paralelogramo
        [ 0.00, 0.00 ],
        [ 0.25, 0.25 ],
        [ 0.25, 0.75 ],
        [ 0.00, 0.50 ]
    ]
];
if (drawBox)
{
    color([ 0.9, 0.9, 0.9 ])
    translate([ -thickness, -thickness, -thickness - 2 ])
    {
        difference()
        {
            cube([ side + 2 * thickness, side + 2 * thickness, 2 * thickness ]);
            translate([ thickness, thickness, thickness ])
            {
                cube([ side, side, 2 * thickness ]);
            }
        }
    }    
}
else
{
    translate([ -sep, -sep ])
    {
        for (i = [ 0 : len(paths) - 1 ])
        {
            color([ (i % 3) * 0.33,  (i % 4) * 0.25,  (i % 5) * 0.2 ])
            {
                linear_extrude(thickness)
                {
                    offset(delta = -sep)
                    {
                        polygon(paths[i] * (side + 2 * sep));
                    }
                }
            }
        }
    }
}
