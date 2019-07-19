use <./hollow.scad>
use <../Shapes/propeller.scad>
/**
 * Dibuja un clindro que puede ser usado para enrollar papel, filamento, etc.
 * Se le puede poner un agujero central para colocarle un tornillo.
 *
 * @param diameter  Diámetro del cilindo.
 * @param height    Altura del cilindro.
 * @param thickness Grosor de las paredes del cilindro.
 * @param rod       Diámetro del tornillo central.
 * @param angles    Listado de ángulos de los soportes.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Cylinder/spool.scad
 * @license CC-BY-NC-4.0
 */
module spool(diameter, height, thickness, rod, angles = [])
{
    _e = is_undef(epsilon) ? ($preview ? 0.001 : 0) : epsilon;
    difference()
    {
        union()
        {
            cylinderHollow(diameter, height, thickness);
            propeller(diameter - thickness / 2, height, thickness, angles);
        }
        if (rod)
        {
            translate([ 0, 0, height / 2 - _e / 2 ])
            {
                cylinder(d = rod, h = height + _e, center = true);
            }
        }
    }
    if (rod)
    {
        cylinderHollow(rod + thickness, height, thickness);
    }
}
