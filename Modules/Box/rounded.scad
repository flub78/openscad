/**
 * Módulos para dibujar cajas con bordes redondeados.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Box/rounded.scad
 * @license CC-BY-NC-4.0
 */
 //----------------------------------------------------------
 use <../../Functions/is.scad>
 //----------------------------------------------------------
/**
 * Genera las coordenadas para dibujar un rectángulo con las esquinas redondeadas.
 * Cada esquina puede tener un radio diferente.
 *
 * @param {Float}   width  Ancho del rectángulo.
 * @param {Float}   height Alto del rectángulo.
 * @param {Float[]} radius Radios a usar para redondear cada esquina.
 */
function boxRoundedRect(width, height, radius = [ 1, 1, 1, 1 ]) = let(
        _r = radius[0] == undef
            ? [ radius, radius, radius, radius ]
            : radius
    )
    [
        [
            [             0, height - _r[0] ],
            [         _r[0], height - _r[0] ],
            [         _r[0], height         ],
            [ width - _r[1], height         ],
            [ width - _r[1], height - _r[1] ],
            [ width        , height - _r[1] ],
            [ width        ,          _r[2] ],
            [ width - _r[2],          _r[2] ],
            [ width - _r[2],              0 ],
            [         _r[3],              0 ],
            [         _r[3],          _r[3] ],
            [             0,          _r[3] ]
        ],
        [
            [         _r[0], height - _r[0] ],
            [ width - _r[1], height - _r[1] ],
            [ width - _r[2],          _r[2] ],
            [         _r[3],          _r[3] ]
        ]
    ];
//----------------------------------------------------------
/**
 * Dibuja un bloque con los bordes XY redondeados.
 *
 * @param {Float}         width  Ancho del bloque (eje X).
 * @param {Float}         height Largo del bloque (eje Y).
 * @param {Float}         length Alto del bloque (eje Z).
 * @param {Float|Float[]} radius Radios del borde de cada esquina.
 */
module boxRounded(width, height, length, radius = [ 1, 1, 1, 1 ])
{
    if (radius)
    {
        translate([ - width / 2, - height / 2, - length / 2 ])
        {
            linear_extrude(length)
            {
                boxRounded2d(width, height, radius);
            }
        }
    }
    else
    {
        cube([ width, height, length ], center = true);
    }
}
//----------------------------------------------------------
/**
 * Dibuja un bloque con los bordes XY redondeados.
 *
 * @param {Float}         width  Ancho del bloque (eje X).
 * @param {Float}         height Largo del bloque (eje Y).
 * @param {Float|Float[]} radius Radios del borde de cada esquina.
 */
module boxRounded2d(width, height, radius = [ 1, 1, 1, 1 ])
{
    // Si se pasa un número, lo convertimos a un array.
    _radius = isArray(radius)
        ? radius
        : [ radius, radius, radius, radius ];
    _data = boxRoundedRect(width, height, _radius);
    polygon(points = _data[0]);
    for (_index = [ 0 : 3 ])
    {
        if (_radius[_index] > 0)
        {
            translate(_data[1][_index])
            {
                circle(r = _radius[_index]);
            }
        }
    }
}
//----------------------------------------------------------
/**
 * Dibuja un bloque con todos los bordes redondeados.
 *
 * @param width  Ancho del bloque (eje X).
 * @param height Largo del bloque (eje Y).
 * @param length Alto del bloque (eje Z).
 * @param radius Radio del borde.
 */
module boxRounded3d(width, height, length, radius = 1)
{
    if (radius > 0)
    {
        hull()
        {
            for (z = [ -1, 1 ])
            {
                for (y = [ -1, 1 ])
                {
                    for (x = [ -1, 1 ])
                    {
                        translate([
                            x * (width  / 2 - radius),
                            y * (height / 2 - radius),
                            z * (length / 2 - radius)
                        ])
                        {
                            sphere(r = radius, center = true);
                        }
                    }
                }
            }
        }
    }
    else
    {
        cube([ width, height, length ], center = true);
    }
}
