/**
 * Genera una caja para almacenar proyectos y/o objetos. También permite generar la tapa de la caja.
 * Varias cajas pueden ser colocadas de manera apilada usando una varilla roscada.
 *
 * Cada caja puede ser personalizada usando varios parámetros:
 *
 * - Medidas (ancho, alto y largo).
 * - Configuración del tornillo para apilarlas y/o colocar la tapa (diámetro del tornillo,
 *   diámetro de la cabeza, altura de la cabeza, largo del tornillo).
 * - Seleccionar las paredes a imprimir.
 * - Patrón a usar en la parte inferior para disminuir la cantidad de filamento o para permitir el paso de
 *   objetos entre cajas, por ejemplo, para conectar algunos circuitos entre sí.
 *
 * Aunque puede generar cajas, su principal uso es utilizarlo como base para otros diseños que generen
 * soportes o piezas que se colocan sobre la base.
 *
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Box/stackable.scad
 * @license CC-BY-NC-4.0
 * @see     http://www.thingiverse.com/thing:3861344
 */
border    = 1.5;               // Radio del borde de algunas esquinas.
margin    = 0;                 // Margen para el patrón de la base.
thickness = 1.5;               // Grosor de las paredes.
screw     = [ 4.2, 6.0, 2.0 ]; // Configuración del tornillo:
                               // 0 - Diámetro del tornillo.
                               // 1 - Diámetro de la cabeza del tornillo.
                               // 2 - Altura de la cabeza del tornillo.
                               // 3 - Largo del tornillo. Si no se especifica se usa el alto de la caja.
//----------------------------------------------------------
use <./rounded.scad>
use <../Pattern/bars.scad>
use <../Pattern/honeycomb.scad>
//----------------------------------------------------------
// Constantes
//----------------------------------------------------------
function SCREW_DIAMETER()      = 0; // Diámetro del tornillo.
function SCREW_HEAD_DIAMETER() = 1; // Diámetro de la cabeza del tornillo.
function SCREW_HEAD_HEIGHT()   = 2; // Altura de la cabeza del tornillo.
function SCREW_LENGTH()        = 3; // Longitud del tornillo.
//----------------------------------------------------------
// Calcula el tamaño de cada lado de las esquinas en función del tornillo y el groso de las paredes.
function getSide(screw, thickness) = let(_hd = screw[SCREW_HEAD_DIAMETER()], _sd = screw[SCREW_DIAMETER()])
    (_hd ? _hd : (_sd ? _sd : 0)) + 2 * thickness;
//----------------------------------------------------------

/**
 * Dibuja cada una de las esquinas.
 *
 * @param {Float}   height    Altura de la esquina.
 * @param {Float[]} screw     Configuración del tornillo.
 * @param {Float}   thickness Grosor de las paredes.
 * @param {Float}   border    Radio de los bordes.
 */
module boxStackableCorner(height, screw = screw, thickness = thickness, border = border)
{
    _s = getSide(screw, thickness);
    difference()
    {
        _eps = 0.01;
        _sd  = screw[SCREW_DIAMETER()];
        boxRounded(_s, _s, height, border);
        if (_sd)
        {
            _hd = screw[SCREW_HEAD_DIAMETER()];
            _hh = screw[SCREW_HEAD_HEIGHT()];
            _sl = screw[SCREW_LENGTH()];
            _l  = _sl == undef ? height : _sl;
            assert(border < _s / 2, "El radio del borde no puede ser mayor que el lado de la esquina");
            assert(_hd == undef || _hd == 0 || _hd > _sd, "El diámetro de la cabeza no puede ser menor que el del tornillo");
            translate([ 0, 0, - (_l + _eps) / 2 ])
            {
                cylinder(d = _sd, h = height + _eps);
            }
            if (_hd && _hh)
            {
                for (_angle = [ 0, 180 ])
                {
                    rotate([ _angle, 0, 0 ])
                    {
                        translate([ 0, 0, height / 2 - _hh ])
                        {
                            cylinder(d = _hd, h = _hh + _eps);
                            translate([ 0, 0, - _hd / 2 + _eps ])
                            {
                                cylinder(d1 = 0, d2 = _hd, h  = _hd / 2);
                            }
                        }
                    }
                }
            }
        }
    }
}

/**
 * Dibuja la tapa de la bandeja.
 *
 * @param {Float}   width     Ancho de la tapa.
 * @param {Float}   length    Longitud de la tapa.
 * @param {Float[]} screw     Configuración del tornillo.
 * @param {Float}   thickness Grosor de la tapa.
 * @param {Float}   border    Radio de los bordes.
 */
module boxStackableCover(width, length, screw = screw, thickness = thickness, border = border)
{
    _d = screw[SCREW_DIAMETER()];     // Diámetro del tornillo.
    _a = max([ _d, screw[SCREW_HEAD_DIAMETER()] ]);
    _l = thickness + _a / 2;
    difference()
    {
        _eps = 0.01;
        boxRounded(width, length, thickness, border);
        for (_x = [ -1, 1 ])
        {
            for (_y = [ -1, 1 ])
            {
                translate([ _x * (width / 2 - _l), _y * (length / 2 - _l), 0 ])
                {
                    cylinder(d = _d, h = thickness + _eps, center = true);
                }
            }
        }
    }
}

/**
 * Dibuja un patrón sobre la base para minimizar la superficie a imprimir y permitiendo
 * el paso de objetos entre bandejas.
 *
 * @param {Float}  width     Ancho de la parte interna de la bandeja (eje X)
 * @param {Float}  height    Altura de la bandeja (eje Y)
 * @param {Float}  length    Largo de la bandeja (eje Z)
 * @param {Float}  thickness Grosor de las paredes.
 * @param {String} pattern   Patrón a usar para minimizar el uso de filamento en la base.
 * @param {Float}  margin    Margen a dejar al dibujar el patrón en la base.
 * @param {Float}  radius    Radio a usar en algunos patrones.
 */
module boxStackablePattern(width, height, length, thickness = thickness, pattern = "none", margin = 0, radius = 1)
{
    _t = 2 * thickness;
    _h = height - 2 * margin;
    _w = width - 2 * margin;
    difference()
    {
        cube([ width, height, length ]);
        if (pattern == "bars")
        {
            translate([ (width + _w) / 2, height / 2, 0 ])
            {
                rotate([ 0, 0, 90 ])
                {
                    bars(_w, _h, radius, _t, radius);
                }
            }
        }
        else if (pattern == "honeycomb")
        {
            translate([ _w / 2 + margin, _h / 2 + margin, 0 ])
            {
                honeycombCube(_w, _h, _t, width >= height ? height / 3 : height / 5, thickness);
            }
        }
        else if (pattern == "rect")
        {
            translate([ width / 2, height / 2, 0 ])
            {
                cube([ _w, _h, 2 * thickness ], center = true);
            }
        }
    }
}

/**
 * Módulo para dibuja una bandeja de manera genérica.
 *
 * @param {Float}   width     Ancho de la parte interna de la bandeja (eje X)
 * @param {Float}   height    Altura de la bandeja (eje Y).
 * @param {Float}   length    Largo de la bandeja (eje Z).
 * @param {Float[]} screw     Configuración del tornillo.
 * @param {Float}   thickness Grosor de las paredes
 * @param {Float}   border    Radio del borde de las esquinas.
 * @param {Float}   base      Longitud de la base.
 *                            Si no se especifica se usa la longitud de la bandeja.
 * @param {Float[]} walls     Índices de las paredes a dibujar.
 * @param {String}  pattern   Patrón a usar para minimizar el uso de filamento en la base.
 * @param {Float}   pmargin   Margen a dejar al dibujar el patrón en la base.
 * @param {Float}   pradius   Radio a usar en algunos patrones.
 */
module boxStackableTray(width, height, length, screw = screw, thickness = thickness, border = border, base = 0, walls = [ 1, 2, 3, 4 ], pattern = "none", pmargin = 0, pradius = 1)
{
    _s = getSide(screw, thickness);
    _l = length - 2 * _s;
    _b = base && base < length ? base - _s : _l;
    _w = width - 2 * _s;
    //-----------------------------------------------------------------
    // Esquinas
    //-----------------------------------------------------------------
    for (_x = [ -1, 1 ])
    {
        for (_y = [ -1, 1 ])
        {
            translate([ _x * (width - _s) / 2, _y * (length - _s) / 2, 0])
            {
                boxStackableCorner(height, screw, thickness, border);
            }
        }
    }
    //-----------------------------------------------------------------
    // Pletinas que unen las esquinas
    //-----------------------------------------------------------------
    for (_x = [ -1, 1 ])
    {
        translate([ _x * (_w + _s) / 2, 0, - (height - thickness) / 2 ])
        {
            cube([ _s, _l + 2 * thickness, thickness ], center = true);
        }
    }
    for (_y = [ -1, 1 ])
    {
        translate([ 0, _y * (_l + _s) / 2, - (height - thickness) / 2 ])
        {
            cube([ _w + 2 * thickness, _s, thickness ], center = true);
        }
    }
    //-----------------------------------------------------------------
    // Paredes de la bandeja.
    //-----------------------------------------------------------------
    for (_x = [ -1, 1 ])
    {
        if (search(_x == -1 ? 1 : 3, walls))
        {
            translate([ _x * (width - thickness) / 2, 0, 0 ])
            {
                cube([ thickness, length - _s, height ], center = true);
            }
        }
    }
    for (_y = [ -1, 1 ])
    {
        if (search(_y == -1 ? 4 : 2, walls))
        {
            translate([ 0, _y * (length - thickness) / 2, 0 ])
            {
                cube([ width - _s, thickness, height ], center = true);
            }
        }
    }
    //-----------------------------------------------------------------
    // Base
    //-----------------------------------------------------------------
    translate([ - _w / 2, - length / 2 + _s, - height / 2 ])
    {
        boxStackablePattern(_w, _b, thickness, 2 * thickness, pattern, pmargin, pradius);
    }
}
