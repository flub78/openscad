/**
 * Módulo para dibujar bandejas apilables.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Storage/StackableBoxSystem.scad
 * @license CC-BY-NC-4.0
 * @see     http://www.thingiverse.com/thing:2177853
 */
//-----------------------------------------------------------------------------
sizes = [
 //ancho  largo   alto  radio  dz
 [  58.0,  40.0,  25.0,   6.5, [ 0.6, 0.4 ] ], // Tupper blanco
 [ 109.0,  59.1,  34.0,   1.8               ], // Gavetero plástico
 [  35.0,  16.5,  67.7,   3.5               ], // SMINT
 [  68.0,  53.0, 102.0,   0.6               ]
];
// Índice de las medidas a usar del array `sizes`.
selected = 1;
// Grosor de las paredes.
thickness = 0.9;
// Tolerancia a usar para que el pin entre en las ranuras.
tolerance = 1.2;
// Configuración de las celdas de cada caja.
// Cada celda tiene 2 índices:
// 0: Divisiones en el eje X.
// 1: Divisiones en el eje Y.
cells = [
    [ 3, 2 ],
    [ 2, 2 ]
];
// Índice del elemento que se quiere mostrar o -1 para mostrar todos.
// Es útil para cuando se quiere imprimir solamente una parte.
only = -1;
//-----------------------------------------------------------------------------
use <../Functions/is.scad>
use <../Functions/Array/fill.scad>
use <../Modules/Box/rounded.scad>
use <../Modules/Box/storage.scad>
//-----------------------------------------------------------------------------
// Valores calculados
//-----------------------------------------------------------------------------
config = sizes[selected];
// Cantidad de cajas
count = len(cells);
// Ancho del contenedor de las cajas (eje X).
width = config[0];
// Largo del contenedor de las cajas (eje Y).
length = config[1];
// Alto del contenedor de las cajas (eje Z).
height = config[2];
// Radio de los bordes. Posibles valores:
// - Cero     : No se redondea ningún borde, ni externo ni interno.
// - Negativo : Todos los bordes se redondean con el radio especificado.
// - Positivo : Solamente se redondean los bordes externos y los 4 internos.
radius = config[3];
// Tamaño de cada caja.
// Puede ser un array o un entero.
heights = config[4] == undef
    ? arrayFill(count, 1 / count)
    : config[4];
// Ancho del pin a usar para poder levantar todas las cajas.
pinSize = width / 6;
// Permite mostrar una rebanada para verificar si el bandeja encaja
// en el contenedor.
// <0: Dibuja una rebanada empezando desde la base.
// =0: No dibuja ninguna rebanada.
// >0: Dibuja una rebanada empezando desde arriba.
slice = 0;
//-----------------------------------------------------------------------------
/**
 * Devuelve la posición de la bandeja actual.
 *
 * @param count Total de bandejas.
 * @param index Índice de la bandeja actual.
 */
function getPosition(count, index) = count <= 1
    ? "none"
    : index == 0
        ? "bottom" 
        : index == count - 1
            ? "top2" // o "top1"
            : "middle";
//-----------------------------------------------------------------------------
/**
 * Define un tipo de pin rectangular que evita la rotación de las bandejas.
 *
 * @param width     Ancho del pin (eje X).
 * @param length    Largo del pin (eje Y).
 * @param height    Alto del pin (eje Z).
 * @param count     Cantidad de bandejas que se dibujarán.
 * @param index     Índice de la bandeja actual.
 * @param tolerance Tolerancia entre el pin y el agujero.
 * @param angle     Ángulo a rotar el pin.
 */
module pinType1(width, length, height, count, index, tolerance = 0.3, angle = 0)
{
    _position = getPosition(count, index);
    rotate([ 0, 0, angle ])
    {
        difference()
        {
            union()
            {
                rotate([ 0, 0, -angle ])
                {
                    children();
                }
                if (_position != "none")
                {
                    boxRounded(width, length, height, 1);
                    if (_position == "bottom")
                    {
                        translate([
                            0,
                            0,
                            (height * (count - 1)) / 2
                        ])
                        {
                            rotate([ 90, 0, 0 ])
                            {
                                difference()
                                {
                                    boxRounded(
                                        width - 2 * thickness - tolerance,
                                        height * count,
                                        length - 2 * thickness - tolerance,
                                        2
                                    );
                                }
                            }
                        }
                    }
                }
            }
            if (_position == "middle" || _position[0] == "t"/*top1 || top2*/)
            {
                cube(
                    [
                        width  - 2 * thickness,
                        length - 2 * thickness,
                        height * 2
                    ],
                    center = true
                );
                if (_position == "top1")
                {
                    rotate([ 90, 0, 0 ])
                    {
                        translate([ 0, height * 0.5, 0 ])
                        {
                            cylinder(
                                d = width * 0.75,
                                h = length * 3,
                                center = true,
                                $fn = 4
                            );
                        }
                    }
                }
                else if (_position == "top2")
                {
                    translate([ 0, 0, height * 0.5 ])
                    {
                        cube(
                            [
                                width + 0.001,
                                length + 0.001,
                                height * 0.8
                            ],
                            center = true
                        );
                    }
                }
            }
        }
    }
}
/**
 * Define un tipo de pin cilíndrico.
 *
 * @param radius    Radio del pin (ejes X e Y).
 * @param height    Largo del pin (eje Z).
 * @param count     Cantidad de bandejas que se dibujarán.
 * @param index     Índice de la bandeja actual.
 * @param tolerance Tolerancia entre el pin y el agujero.
 */
module pinType2(radius, length, height, count, index, tolerance = 0.3)
{
    _position = getPosition(count, index);
    difference()
    {
        union()
        {
            children();
            if (_position != "none")
            {
                cylinder(
                    r      = radius + thickness + tolerance,
                    h      = height,
                    center = true);
                if (_position == "bottom")
                {
                    translate([ 0, 0, (height * (count - 1)) / 2 ])
                    {
                        cylinder(
                            r      = radius,
                            h      = height * count,
                            center = true);
                    }
                }
            }
        }
        if (_position == "middle" || _position == "top")
        {
            cylinder(
                r      = radius + tolerance,
                h      = height + 0.001,
                center = true);
            if (_position == "top")
            {
                translate([ 0, 0, height * 0.5 ])
                {
                    cylinder(
                        r      = radius + thickness + tolerance + 0.001,
                        h      = height,
                        center = true);
                }
            }
        }
    }
}
/**
 * Módulo que permite dibujar la base para medir si el tamaño
 * encaja correctamente en el contenedor.
 */
module drawTestBox(height)
{
    difference()
    {
        _testHeight = height + thickness;
        boxStorage(width, length, _testHeight, radius, thickness, 4, 8);
        translate([ 0, 0, - _testHeight + thickness + 0.0001 ])
        {
            cube([ width * 2, length * 2, _testHeight ], center = true);
        }
    }
}
//-----------------------------------------------------------------------------
colors   = [
    [ 0.3, 0.6, 0.9 ],
    [ 0.9, 0.3, 0.6 ],
    [ 0.6, 0.9, 0.3 ],
    [ 0.9, 0.6, 0.3 ],
    [ 0.3, 0.9, 0.6 ],
    [ 0.6, 0.3, 0.9 ],
    [ 0.5, 0.0, 0.0 ],
    [ 0.0, 0.5, 0.0 ],
    [ 0.0, 0.0, 0.5 ],
];
difference()
{
    pinHeight = thickness * 3 + 2 * tolerance;
    vertical  = 0; // Vertical solamente funciona para cajas de la misma altura.
    $fa       = 0.01;
    $fs       = 0.01;
    for (z = [ 0 : count - 1 ])
    {
        dz = heights[z] * height;
        if (only < 0 || only == z)
        {
            translate([
                0,
                (vertical ? 0   : 1) * z * (length + 2),
                (vertical ? 1.0 : 0) * z * dz + dz / 2
            ])
            {
                color(concat(colors[z] == undef ? [ 0.5, 0.5, 0.5 ] : colors[z], [ 0.5 ]))
                {
//                    pinType2(pinSize, pinHeight, dz, count, z, tolerance)
                    pinType1(pinSize, pinHeight, dz, count, z, tolerance, 0)
                    {
                        boxStorage(
                            width,
                            length,
                            dz,
                            radius,
                            thickness,
                            cells[z][0],
                            cells[z][1]
                        );
                    }
                }
            }
        }
    }
    if (slice)
    {
        translate([ - width / 2, - length / 2, - slice ])
        {
            cube([ width, length, height ]);
        }
    }
}
