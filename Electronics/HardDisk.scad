/**
 * Genera un contenedor para almacenar discos duros.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Electronics/HardDisk.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3642857
 */
//---------------------------------------------------------------
use <../Modules/Box/rounded.scad>
use <../Modules/Models/SFF/8200.scad>
use <../Modules/Models/SFF/8300.scad>
//---------------------------------------------------------------

/**
 * Dibuja el contenedor de discos duros.
 *
 * Dependiendo del valor de `model` y `desktop` tenemos las siguientes posibilidades
 * para el valor estándar de la altura:
 *
 * ```
 * - 2.5" (desktop = false)
 *    - 0: 19.05
 *    - 1: 17.00
 *    - 2: 15.00
 *    - 3: 12.70
 *    - 4: 10.50
 *    - 5:  9.50
 *    - 6:  8.47
 *    - 7:  7.00
 *    - 8:  5.00
 * - 3.5" (desktop = true)
 *    - 0: 42.00
 *    - 1: 26.10
 *    - 2: 17.80
 * ```
 *
 * @param {Integer} model     Modelo del disco duro.
 * @param {Float}   thickness Grosor de las paredes del contenedor.
 * @param {Integer} count     Cantidad de discos duros a almacenar.
 * @param {Boolean} desktop   Indica si el disco duro es de PC (3.5") o portátil (2.5").
 * @param {Float}   tolerance Tolerancia a usar en las medidas del disco duro.
 * @param {Float}   screws    Indica si se dejan los espacios para los tornillos.
 * @param {Integer} padding   Ancho de la pestaña a usar como separador entre discos.
 * @param {Boolean} notch     Indica si se genera el espacio para sacar el disco con el dedo.
 * @param {Float}   radius    Radio a usar para redondear los bordes.
*/
module hardDisk(model = 1, thickness = 1.8, count = 2, desktop = true, tolerance = 0.9, screws = true, padding = 7, notch = true, radius = 1.2)
{
    _size    = desktop
                ? sff8300(tolerance = tolerance, type = model)
                : sff8200(tolerance = tolerance, type = model);
    _width   = _size[desktop ? 3 : 4];
    _height  = _size[1];
    _length  = _size[desktop ? 2 : 6];
    _dt      = 2 * thickness;
    _d       = (_height - _dt) * 0.7;
    _dy      = _height + thickness;
    _ty      = thickness + count * _dy;
    difference()
    {
        boxRounded(_width + _dt, _ty, _length + thickness, radius, thickness);
        for (_n =  [ 0 : count - 1 ])
        {
            translate([ - _width / 2, _n * _dy + thickness - _ty / 2, - (_length + thickness) / 2 + thickness ])
            {
                if (desktop)
                {
                    sff8300Model(_length + 0.01, screws ? _dt : 0, slot = 5, tolerance = tolerance, type = model);
                }
                else
                {
                    sff8200Model(_length + 0.1, screws ? _dt : 0, slot = 5, tolerance = tolerance, type = model);
                }
                if (notch)
                {
                    hull()
                    {
                        for (_x = [ _d + thickness, _width - (_d + thickness) ])
                        {
                            translate([ _x, _height / 2, - thickness / 2 ])
                            {
                                cylinder(h = 2 * _dt, d = _d, center = true);
                            }
                        }
                    }
                }
                if (_n)
                {
                    if (padding)
                    {
                        _dz = 2 * padding + thickness;
                        translate([ _width / 2, thickness / 2, _dz ])
                        {
                            rotate([ 90, 0, 0 ])
                            {
                                hardDiskSeparator(_dt, _width, _length - _dz + thickness, padding);
                            }
                        }
                    }
                    else
                    {
                        translate([ _width / 2, - epsilon, _length / 2 ])
                        {
                            cube([ _width, _dt + 2 * epsilon, _length ], center = true);
                        }
                    }
                }
            }
        }
    }
}

/**
 * Dibuja el separador de los discos.
 *
 * @param {Float}   thickness Grosor del separador.
 * @param {Float}   width     Ancho del espacio a dejar en el separador.
 * @param {Float}   length    Longitud del espacio a dejar en el separador.
 * @param {Integer} padding   Ancho de la pestaña a usar como separador entre discos.
 * @param {Float}   radius    Radio a usar para redondear el borde.
 */
module hardDiskSeparator(thickness, width, length, radius = 4)
{
    _r  = radius;
    _r2 = _r * _r;
    _w  = width / 2;
    _a  = _w;
    _b  =  length - 2 * _r;
    _p  = [
        [  0,  0      ],
        // Inferior
        for (_x = [ 0 : 0.1 : _r ]) [ _a - 2 * _r + _x, - sqrt(_r2 - pow(_x, 2)) + _r ],
        // Superior
        for (_x = [ - _r : 0.1 : 0 ]) [ _a + _x, sqrt(_r2 - pow(_x, 2)) + _b ],
        [ _w, _b + _r ],
        [ _w, length  ],
        [  0, length  ]
    ];
    intersection()
    {
        translate([ - width / 2, 0 ])
        {
            cube([ width, length, thickness ]);
        }
        union()
        {
            linear_extrude(thickness, convexity = 10)
            {
                polygon(points = _p);
            }
            mirror([ 1, 0, 0 ])
            {
                linear_extrude(thickness, convexity = 10)
                {
                    polygon(points = _p);
                }
            }
        }
    }
}

//---------------------------------------------------------------
//epsilon = $preview ? 0.01 : 0;
//$fn     = $preview ? 60   : 180;
//hardDisk();
