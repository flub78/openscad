/**
 * Genera un contenedor para almacenar discos duros.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Electronics/HardDisk.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3642857
 */
//---------------------------------------------------------------
// Variables personalizables
//---------------------------------------------------------------
count     = 2;    // Cantidad de discos duros a almacenar.
desktop   = true; // Indica si el disco duro es de PC (3.5") o portátil (2.5").
notch     = true; // Indica si se genera el espacio para sacar el disco con el dedo.
padding   = 20;   // Ancho de la pestaña a usar como separador entre discos.
screws    = true; // Indica si se dejan los espacios para los tornillos.
thickness = 1.8;  // Grosor de las paredes del contenedor.
tolerance = 0.9;  // Tolerancia a usar en las medidas del disco duro.
model     = 1;    // Tipo de disco duro (altura estándar):
                  // 2.5"
                  //    0: 19.05
                  //    1: 17.00
                  //    2: 15.00
                  //    3: 12.70
                  //    4: 10.50
                  //    5:  9.50
                  //    6:  8.47
                  //    7:  7.00
                  //    8:  5.00
                  // 3.5"
                  //    0: 42.00
                  //    1: 26.10
                  //    2: 17.80
//---------------------------------------------------------------
use <../Modules/Box/rounded.scad>
use <../Modules/Models/SFF/8200.scad>
use <../Modules/Models/SFF/8300.scad>
//---------------------------------------------------------------
// Valores calculados. No tocar sin estar seguro.
//---------------------------------------------------------------
size    = desktop
            ? sff8300(tolerance = tolerance, type = model)
            : sff8200(tolerance = tolerance, type = model);
width   = size[desktop ? 3 : 4];
height  = size[1];
length  = size[desktop ? 2 : 6];
dt      = 2 * thickness;
d       = (height - dt) * 0.7;
dy      = height + thickness;
ty      = thickness + count * dy;
epsilon = $preview ? 0.01 : 0;
$fn     = $preview ? 60   : 180;

/**
 * Dibuja el separador de los discos.
 *
 * @param {Float} thickness Grosor del separador.
 * @param {Float} radius    Radio a usar para redondear el borde.
 * @param {Float} width     Ancho del espacio a dejar en el separador.
 * @param {Float} length    Longitud del espacio a dejar en el separador.
 */
module separator(thickness = thickness, radius = 5, width = width - padding, length = length - padding)
{
    _r  = radius;
    _r2 = _r * _r;
    _w  = width / 2;
    _a1 = _w - _r;
    _a2 = _w + _r;
    _b  =  length - _r;
    linear_extrude(thickness)
    {
        polygon(
            points = [
                [   _a1, 0 ],
                for (_x = [ 0 : 0.1 : _r ]) [ _x + _a1, - sqrt(_r2 - pow(_x, 2)) + _r ],
                [    _w, _b ],
                for (_x = [ - _r : 0.1 : 0 ]) [ _a2 + _x, sqrt(_r2 - pow(_x, 2)) + _b ],
                [   _a2, _b +     _r ],
                [   _a2, _b + 2 * _r ],
                [ - _a2, _b + 2 * _r ],
                [ - _a2, _b +     _r ],
                for (_x = [ _r : -0.1 : 0 ]) [ - _a2 + _x, sqrt(_r2 - pow(_x, 2)) + _b ],
                [ -  _w, _b ],
                for (_x = [ _r : -0.1 : 0 ]) [ - (_x + _a1), - sqrt(_r2 - pow(_x, 2)) + _r ],
                [ - _a1, 0 ],
            ]
        );
    }
}

//---------------------------------------------------------------
// Inicio del script.
//---------------------------------------------------------------
difference()
{
    boxRounded(width + dt, ty, length + thickness, 1.2, thickness);
    for (n =  [ 0 : count - 1 ])
    {
        translate([ - width / 2, n * dy + thickness - ty / 2, - (length + thickness) / 2 + thickness ])
        {
            if (desktop)
            {
                sff8300Model(length + 5, screws ? dt : 0, slot = 5, tolerance = tolerance, type = model);
            }
            else
            {
                sff8200Model(length + 5, screws ? dt : 0, slot = 5, tolerance = tolerance, type = model);
            }
            if (notch)
            {
                hull()
                {
                    for (_x = [ d + thickness, width - (d + thickness) ])
                    {
                        translate([ _x, height / 2, - thickness / 2 ])
                        {
                            cylinder(h = 2 * dt, d = d, center = true);
                        }
                    }
                }
            }
            if (n)
            {
                if (padding)
                {
                    translate([ width / 2, dt / 4, padding - dt ])
                    {
                        rotate([ 90, 0, 0 ])
                        {
                            separator(dt);
                        }
                    }
                }
                else
                {
                    translate([ width / 2, - epsilon, length / 2 ])
                    {
                        cube([ width, dt + 2 * epsilon, length ], center = true);
                    }
                }
            }
        }
    }
    translate([ 0, 0, (length + thickness) / 2 - dt / 2 + 0.01 ])
    {
        cube([ width, count * height, dt ], center = true);
    }
}
