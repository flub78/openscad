/**
 * Dibuja un carrete genérico con diversos propósitos.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Home/UniversalSpool.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3118330
 */
//---------------------------------------------------------------
// Variables personalizables
//---------------------------------------------------------------
bottom     = 0;   // Diámetro de la base inferior (0 para no dibujarla).
lines      = 3;   // Cantidad de líneas a usar para unir el tornillo con el tubo.
diameter   = 21;  // Diámetro externo del carrete.
height     = 42;  // Altura del tubo (0 para no dibujar el tubo).
notch      = 1.2; // Grosor de la muesca para meter el papel (0 deshabilita la muesca).
rod        = 13;  // Diámetro del tornillo central (0 para eliminarlo).
thickness  = 1.5; // Grosor de las paredes.
top        = 0;   // Diámetro de la base superior (0 para no dibujarla).
//---------------------------------------------------------------
use <../Functions/Math/angles.scad>
use <../Modules/Cylinder/hollow.scad>
use <../Modules/Cylinder/spool.scad>
use <../Modules/Shapes/oval.scad>
//---------------------------------------------------------------
/**
 * Dibuja la base del carrete.
 *
 * @param outer     Diámetro externo de la base.
 * @param inner     Diámetro interno de la base.
 * @param thickness Grosor de la base.
 * @param rod       Diámetro del tornillo central del carrete.
 * @param angles    Ángulos para dibujar las líneas de unión.
 */
module base(outer, inner, thickness, rod, angles)
{
    difference()
    {
        union()
        {
            cylinderHollow(outer, thickness, (outer - inner) / 2);
            spool(inner, thickness, thickness, rod, angles);
        }
        if (angles)
        {
            _l = outer - inner;
            _r = min(outer - inner, thickness * 2);
            _w = (_l - 4 * thickness) / 2;
            if (_l > 4 * _r + _w)
            {
                for (angle = angles)
                {
                    rotate(angle)
                    {
                        translate([ (outer - _w) / 2 - thickness, 0, 0 ])
                        {
                            oval(_r, _w, thickness);
                        }
                    }
                }
            }
        }
    }
}

$fn = 30;
//$fn = 360; // Descomentar para mayor definición.
angles = angles(360, 360 / lines);
//---------------------------------------------------------------
// Dibujo de la base
//---------------------------------------------------------------
if (bottom > diameter)
{
    translate([ 0, 0, -thickness ])
    {
        base(bottom, diameter, thickness, rod, angles);
    }
}
//---------------------------------------------------------------
// Dibujo de la tapa
//---------------------------------------------------------------
if (top > diameter)
{
    translate([ 0, 0, height ])
    {
        base(top, diameter, thickness, rod, angles);
    }
}
//---------------------------------------------------------------
// Dibujo del tubo
//---------------------------------------------------------------
if (height)
{
    difference()
    {
        spool(diameter, height, thickness, rod, angles);
        if (notch)
        {
            angle = (angles ? min(angles) : 0) + 10;
            rotate(angle)
            {
                translate([ diameter / 2 - thickness * 1.5, 0, 0 ])
                {
                    cube([ thickness * 2, notch, height ]);
                }
            }
        }
    }

}
