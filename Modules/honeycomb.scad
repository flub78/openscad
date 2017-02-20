/**
 * Módulo que permite trabajar con patrones hexagonales tipo panal.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/honeycomb.scad
 * @license CC-BY-NC-4.0
 * @see     http://www.thingiverse.com/thing:2124344
 */
/**
 * Dibuja un panal de miel completo.
 *
 * @param {Number} columns   Número de columnas (Eje X).
 * @param {Number} rows      Número de filas (Eje Y).
 * @param {Number} height    Altura del cubo (Eje Z).
 * @param {Number} size      Tamaño del hexágono.
 * @param {Number} thickness Grosor de las paredes del panal.
 */
module honeycomb(columns, rows, height, size, thickness)
{
    _halfSize = size / 2;
    for (_row = [ 0 : rows - 1 ]) 
    {
        translate([ (_row % 2) * _halfSize, _row * _halfSize * sqrt(3), 0 ])
        {
            for (_column = [0 : columns - 1]) 
            {
                translate([ _column * size, 0, 0 ])
                {
                    rotate([0, 0, 30])
                    {
                        cylinder(
                            r   = (size - thickness) / sqrt(3),
                            h   = height,
                            $fn = 6
                        );
                    }
                }
            }
        }
    }
}
/**
 * Dibuja un panal acotado por un cubo hueco.
 *
 * @param {Number} columns   Número de columnas (Eje X).
 * @param {Number} rows      Número de filas (Eje Y).
 * @param {Number} height    Altura del cubo (Eje Z).
 * @param {Number} size      Tamaño del hexágono.
 * @param {Number} thickness Grosor de las paredes del panal.
 */
module honeycombCube(columns, rows, height, size, thickness)
{
    _width  = (columns - 1) * size;
    _length = (rows    - 1) * size * sqrt(3) / 2;
    difference() 
    {
        cube([ _width + thickness, _length + thickness, height ]);
        intersection() 
        {
            translate([ thickness, thickness, 0 ])
            {
                cube([ _width - thickness, _length - thickness, height ]);
            }
            translate([ thickness / 2, thickness / 2, 0 ])
            {
                honeycomb(columns, rows, height, size, thickness);
            }
        }
    }
}
