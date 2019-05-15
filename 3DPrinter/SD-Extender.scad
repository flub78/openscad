/**
 * Genera un contenedor para almacenar pilas.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/3DPrinter/SD-Extender.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3632487
 */
//---------------------------------------------------------------
diameter    = 1.5;                           // Diámetro a usar para redondear los bordes.
thickness   = 1.8;                           // Grosor de las paredes.
connector   = [ 22.5, 2 * thickness,  3.0 ]; // Medidas de la ranura para pasar el conector (x, y, z).
size        = [ 35.4, 51.9,          12.0 ]; // Medidas del lector de la tarjeta (x, y, z).
supportW    = size[0] / 2;                   // Ancho del soporte para colocar el extensor sobre la impresora.
supportL    = size[1] / 3;                   // Longitud del soporte para colocar el extensor sobre la impresora.
supportH    = 8.0;                           // Alto del soporte. Es el grosor del marco de la impresora.
supportType = 2;                             // Tipo de soporte a generar.
//---------------------------------------------------------------
/**
 * Dibuja la base donde se introduce el lector.
 */
module base()
{
    difference()
    {
        cube(
            [ 
                size[0] + 2 * dt + diameter,
                size[1] +     dt,
                size[2] + 2 * dt + diameter
            ],
            center = true
        );
        translate([ 0, dt, 0 ])
        {
            cube(size + [ diameter, 0, diameter ], center = true);
        }
        translate([ 0, - size[1] / 2, 0 ])
        {
            cube(connector + [ diameter, diameter, diameter ], center = true);
        }
    }
}

/**
 * Dibuja el soporte de tipo 1.
 *
 * @param {Float} Ancho del soporte (@see supportW).
 * @param {Float} Longitud del soporte (@see supportL).
 */
module type1(width, height)
{
    _w = width + 2 * dt + diameter;
    translate([ 0, 0, (supportH + diameter) / 2 ])
    {
        cube([  _w, dt, supportH + diameter ], center = true);
        translate([ 0, - (height - dt) / 2, (supportH + thickness) / 2 ])
        {
            cube([ _w, height, dt ], center = true);
        }
    }
}

/**
 * Dibuja el soporte de tipo 2.
 *
 * @param {Float} Ancho del soporte (@see supportW).
 * @param {Float} Longitud del soporte (@see supportL).
 */
module type2(width, height)
{
    _w = width + 2 * dt + diameter;
    translate([ 0, 0, height / 2 ])
    {
        cube([  _w, dt, height ], center = true);
        translate([ 0, - (supportH + dt), 0 ])
        {
            cube([ _w, dt, height ], center = true);
        }
    }
}

//---------------------------------------------------------------
// Inicio del script.
//---------------------------------------------------------------
$fn = $preview ? 90 : 120;
dt  = thickness - diameter;
minkowski()
{
    union()
    {
        base();
        if (supportType == 1)
        {
            translate([ 0, size[1] / 2, (size[2] + thickness + dt) / 2 ])
            {
                type1(supportW, supportL);
            }
        }
        else if (supportType == 2)
        {
            translate([ 0, size[1] / 2, (size[2] + thickness + dt) / 2 ])
            {
                type2(supportW, supportL);
            }
        }
    }
    sphere(d = diameter);
}
