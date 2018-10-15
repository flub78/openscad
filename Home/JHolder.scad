/**
 * Genera un gancho en forma de J.
 * Pensado principalmente para colgar los rollos de filamento.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Home/JHolder.scad
 * @license CC-BY-NC-4.0
 * @see     http://www.thingiverse.com/thing:3157046
 */
//-----------------------------------------------------------------------
use <../Modules/Shapes/hook.scad>
use <../Modules/Shapes/oval.scad>
//-----------------------------------------------------------------------
// Valores personalizables
//-----------------------------------------------------------------------
base        = 40;        // Ancho de la base - Eje X.
side        = 10;        // Tamaño de los lados del gancho.
height      = side * 2;  // Ancho del gancho - Eje Z.
length      = 120;       // Altura total del gancho - Eje Y.
pinDiameter = 2;         // Diámetro del pin.
pinPos      = 0.5;       // Proporción del valor de height donde se colocará el pin.
screw       = 5;         // Diámetro del tornillo que sujeta la base.
//-----------------------------------------------------------------------
// NO TOCAR! DO NOT TOUCH!
// Los cambios en estos valores no están contemplados todavía y pueden
// hacer que se rompa el resultado.
//-----------------------------------------------------------------------
angle  = 20;
hook   = 40;
rod    = 8.6;

/**
 * Dibuja la base del gancho.
 */
module base(width = 40, height = 10, length = 10, diameter = 6)
{
    difference()
    {
        oval(height / 2, width, length);
        _d = min(height - 4, diameter);
        _x = (width + length) / 4;
        translate([ _x, 0, 0 ])
        {
            cylinder(d = _d, h = length);
        }
        translate([ - _x, 0, 0 ])
        {
            cylinder(d = _d, h = length);
        }
    }
}

$fn = $preview
    ? 30
    : 360;

union()
{
    rotate([ -90, 0, 0 ])
    {
        base(base, height, side, screw);
    }
    translate([ 0, 0, - height / 2 ])
    {
        translate([ - side / 2, 0, 0 ])
        {
            cube([ side, length - hook, height ]);
        }
        translate([ (1 - sin(angle)) * (side / 2) - 1.09, length - hook / 2 + 0.27, 0 ])
        {
            rotate([ 0, 0, -90 + angle ])
            {
                hook(
                    hook,
                    side * 2 + rod,
                    height,
                    rod,
                    pinPos,
                    pinDiameter
                );
            }
        }
    }
}
