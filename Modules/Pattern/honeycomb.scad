/**
 * Módulo que permite trabajar con patrones hexagonales tipo panal.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Pattern/honeycomb.scad
 * @license CC-BY-NC-4.0
 * @see     http://www.thingiverse.com/thing:2124344
 */
/**
 * Dibuja un panal de miel completo.
 *
 * @param {Integer} columns   Número de columnas (eje X).
 * @param {Integer} rows      Número de filas (eje Y).
 * @param {Float}   height    Altura del cubo (eje Z).
 * @param {Float}   size      Tamaño del hexágono.
 * @param {Float}   thickness Grosor de las paredes del panal.
 * @param {Boolean} odd       Si es true las filas impares tienen una columna menos.
 */
module honeycomb(columns, rows, height, size, thickness, odd = false)
{
    _halfSize = size / 2;
    _last     = [
        columns - 1,
        odd
            ? columns - 2
            : columns - 1
    ];
    for (_row = [ 0 : rows - 1 ])
    {
        translate([ (_row % 2) * _halfSize, _row * _halfSize * sqrt(3), 0 ])
        {
            for (_column = [ 0 : _last[_row % 2] ])
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
 * Dibuja un panal con el diámetro especificadoque luego puede ser aplicado sobre
 * otra superficie mediante intersección.
 *
 * @param {Float} diameter  Diámetro del cilindro (plano XY).
 * @param {Float} length    Altura del cilindro (eje Z).
 * @param {Float} size      Tamaño del hexágono.
 * @param {Float} thickness Grosor de las paredes del panal.
 */
module honeycombCylinder(diameter, length, size, thickness)
{
    honeycombIntersection(diameter, diameter, length, size, thickness)
    {
        cylinder(d = diameter, h = length, center = true);
    }
}
/**
 * Dibuja un panal del ancho y alto indicado que luego puede ser aplicado sobre
 * otra superficie mediante intersección.
 *
 * @param {Float} width     Anchura del cubo (eje X).
 * @param {Float} height    Altura del cubo (eje Y).
 * @param {Float} length    Longitud del cubo (eje Z).
 * @param {Float} size      Tamaño del hexágono.
 * @param {Float} thickness Grosor de las paredes del panal.
 */
module honeycombCube(width, height, length, size, thickness)
{
    honeycombIntersection(width, height, length, size, thickness)
    {
        cube([ width, height, length ], center = true);
    }
}
/**
 * Dibuja un panal acotado por un cubo hueco dadas las columnas y filas requeridas.
 *
 * @param {Integer} columns   Número de columnas (eje X).
 * @param {Integer} rows      Número de filas (eje Y).
 * @param {Float}   height    Altura del cubo (eje Z).
 * @param {Float}   size      Tamaño del hexágono.
 * @param {Float}   thickness Grosor de las paredes del panal.
 */
module honeycombCubeByColsAndRows(columns, rows, height, size, thickness)
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
/**
 * Realiza la intersección del panal con los hijos del módulo.
 *
 * @param {Float} width     Anchura del panal a dibujar (eje X).
 * @param {Float} height    Altura del panal a dibujar (eje Y).
 * @param {Float} length    Longitud del panal a dibujar (eje Z).
 * @param {Float} size      Tamaño del hexágono.
 * @param {Float} thickness Grosor de las paredes del panal.
 */
module honeycombIntersection(width, height, length, size, thickness)
{
    _cols   = floor(width / size) + 3;
    _rows   = floor(2 * height / (size * sqrt(3))) + 3;
    _width  = _cols * size;
    _height = (_rows - 1) * size * sqrt(3) / 2;
    intersection()
    {
        children();
        translate([ - _width / 2, - _height / 2 - (size - thickness) / sqrt(3), - length / 2 ])
        {
            honeycomb(_cols, _rows, length, size, thickness);
        }
    }
}
