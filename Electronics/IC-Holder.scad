/*
 * Soporte para almacenar circuitos integrados.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Electronics/IC-Holder.scad
 * @license CC
 */
use <../Functions/ceilMultiple.scad>
/*
 * Dimensiones de los diferentes tipos de ICs.
 *
 *    |----w1----|
 *     __________
 *    |          |
 * h1 |          | 
 *    |   ____   |
 *    |  |    |  |
 * h2 |  |    |  |
 *    |__|-w2-|__|
 */
types = [
    // Nombre             h1   h2    w1   w2
    [ "DIP4",             3.9, 3.9,  8.3, 7.2 ],
    [ "DIPSwitch",        7.0, 3.3, 10.0, 8.0 ],
    [ "DPDT6Pin-7x7x12", 13.0, 3.6,  7.0, 4.7 ],
    [ "BarDisplay",       7.8, 7.8, 25.6, 1.8 ]
];
//------------------------------------------
// Variables configurables.
//------------------------------------------
// Tipo seleccionado, usado para obtener las medidas del
// array `types`.
type = 0;
// Valor del `layer height` a usar.
lh = 0.3;
// Cantidad de soportes
n = 1;
// Altura.
l = ceilMultiple(45, lh);
// Diámetro del pin, M3 por defecto.
d = 3;
// Grosor de las paredes
f = 4 * lh;
// Indica si se agregan las ranuras en la parte superior.
// Ver comentarios en el módulo `slot` para asignar su valor.
slotSize  = 0;
// Cantidad de lados del polígono a dibujar en el slot.
// Se usa si slotSize > 0.
slotSides = 50;
//------------------------------------------
// Variables calculadas a partir del tipo.
//------------------------------------------
// Altura del cuerpo del IC
h1 = ceilMultiple(types[type][1], lh) + 2 * lh;
// Altura de las patas del IC
h2 = ceilMultiple(types[type][2], lh) + 2 * lh;
// Anchura externa
w1 = ceilMultiple(types[type][3], lh) + 4 * lh;
// Anchura interna.
w2 = ceilMultiple(types[type][4], lh) - 4 * lh;
// Ruta a dibujar.
path = [
    [ - w1 / 2, - h2 ],
    [ - w1 / 2,   h1 ],
    [   w1 / 2,   h1 ],
    [   w1 / 2, - h2 ],
    [   w2 / 2, - h2 ],
    [   w2 / 2,    0 ],
    [ - w2 / 2,    0 ],
    [ - w2 / 2, - h2 ]
];
/**
 * Dibuja el soporte.
 */
module holder()
    {
    difference()
    {
        union()
        {
            linear_extrude(f)
            {
                polygon(path);
            }
            linear_extrude(l)
            {
                difference()
                {
                    offset(r = f)
                    {
                        polygon(path);
                    }
                    polygon(path);
                }
            }
        }
        if (slotSize >= 0)
        {
            maxLength = l - ceilMultiple(d, lh);
            slots     = ceil(maxLength / 30);
            sl        = floor(maxLength / slots);
            for (i = [ 0 : slots - 1 ])
            {
                translate([ 0, h1 + f / 2, (sl - f) * i + f ])
                {
                    slot(sl - (slots == 1 ? 3 * f : 2 * f), slotSize);
                }
            }
        }
        translate([ 0, h1 + f + lh, l - d ])
        {
            rotate([ 90, 0, 0 ])
            {
                difference()
                {
                    pin();
                }
            }
        }
    }
}
/**
 * Dibuja el pin para evitar que se salgan los ICs.
 *
 * @param {Number} tolerance Valor a usar para modificar las
 *                           dimensiones del pin y dejar holgura.
 */
module pin(tolerance = 0)
{
    _d  = min(d + tolerance, w2 - 2 * (f + lh), l - 2 * (f + lh));
    if (_d >= 1.75)
    {
        _dm = _d + 2 * f;
        _dx = _dm / 2 - _d * 0.25;
        difference()
        {
            union()
            {
                translate([ 0, 0, - f / 2 - lh ])
                {
                    cylinder(d = _dm, h = f);
                }
                cylinder(d = _d, h = h1 + 2.5 * f);
                translate([ 0, 0, h1 + 2.5 * f + _d / 2 ])
                {
                    scale([ 1.2, 1.2, 1.75 ])
                    {
                        sphere(d = _d);
                    }
                }
            }
        }
    }
}
/**
 * Dibuja las ranuras de la parte superior para ver el código del IC.
 *
 * @param {Number} length Longitud del slot.
 * @param {Number} side   Valor del lado del polígono a usar
 *                        para dibujar la superficie.
 *                        Si es 0, se usa una ranura redondeada.
 *                        Si es < 0, no se crea la ranura.
 */
module slot(length, side = 0)
{
    if (side > 0)
    {
        _w  = w1 - f;
        _nx = floor(_w / (side + 2 * lh));
        _nz = floor(length / (side + 2 * lh));
        if (_nx && _nz)
        {
            _dx = (_w - side * _nx) / _nx;
            _dz = (length - side * _nz) / _nz;
            for (_x = [ 0 : _nx - 1 ])
            {
                for (_z = [ 0 : _nz - 1 ])
                {
                    translate([
                        - _w / 2 - 2 * lh + _x * (side + _dx) + _dx + f,
                        0,
                        _z * (side + _dz) + _dz + f 
                    ])
                    {
                        rotate([ 90, 0, 0 ])
                        {
                            cylinder(d = side, h = 2 * f, center = true, $fn = slotSides);
                        }
                    }
                }
            }
        }
    }
    else if (side == 0)
    {
        _w = w1 - 4 * f;
        _y = ceilMultiple(_w / 2, lh);
        rotate([ 90, 0, 0 ])
        {
            hull()
            {
                for (_i = [ -1, 1 ])
                {
                    translate([ 0, _i == -1 ? length - _y : _y, - h1 / 2 ])
                    {
                        cylinder(d = _w, h = h1);
                    }
                }
            }
        }
    }
}
//---------------------------------------------------
$fn = 50;
// n = floor(45 / (w1 + f));
for (x = [ 0 : n - 1 ])
{
    translate([ x * (w1 + f), 0, 0 ])
    {
        holder();
    }
}
// Recordar escalar el pin para que entre sin problemas.
//pin();