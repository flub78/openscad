/*
 * Soporte para almacenar circuitos integrados.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Electronics/IC-Holder.scad
 * @license CC
 *
 ***********************************************
 *
 * Esquema de algunas variables:
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
function roundToLayerHeight(value) = ceil(value / lh) * lh;

// Dimensiones de los diferentes tipos de ICs.
types = [
    // Nombre      h1   h2    w1   w2
    [ "DIP4",      4.5, 4.5,  9.5, 6.0 ],
    [ "DIPSwitch", 7.8, 3.9, 10.5, 6.6 ]
];
//------------------------------------------
// Variables configurables.
//------------------------------------------
// Tipo seleccionado, usado para obtener las medidas.
type = 0;
// Layer Height
lh = 0.3;
// Cantidad de soportes
n = 3;
// Altura.
l = roundToLayerHeight(51);
// Diámetro del pin, M3 por defecto.
d = 3;
// Grosor de las paredes
f = 4 * lh;
// Indica si se agregan las ranuras en la parte superior
addSlots = true;
//------------------------------------------
// Variables calculadas a partir del tipo.
//------------------------------------------
// Altura del cuerpo del IC
h1 = roundToLayerHeight(types[type][1]);
// Altura de las patas del IC
h2 = roundToLayerHeight(types[type][2]);
// Anchura externa
w1 = roundToLayerHeight(types[type][3]);
// Anchura interna.
w2 = roundToLayerHeight(types[type][4]);
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
                    offset(delta = f)
                    {
                        polygon(path);
                    }
                    polygon(path);
                }
            }
        }
        if (addSlots)
        {
            maxLength = l - roundToLayerHeight(d);
            slots     = ceil(maxLength / 30);
            sl        = floor(maxLength / slots);
            for (i = [ 0 : slots - 1 ])
            {
                translate([ 0, 0, (sl - f) * i + f ])
                {
                    slot(sl - (slots == 1 ? 3 * f : 2 * f));
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
    _d  = d + tolerance;
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
/**
 * Dibuja las ranuras de la parte superior para ver el código del IC.
 *
 * @param {Number} length Longitud del slot.
 */
module slot(length)
{
    _d = w1 - 4 * f;
    _y = roundToLayerHeight(_d / 2);
    rotate([ 90, 0, 0 ])
    {
        hull()
        {
            for (_i = [ -1, 1 ])
            {
                translate([ 0, _i == -1 ? length - _y : _y, - h1 - f ])
                {
                    cylinder(d = _d, h = h1);
                }
            }
        }
    }
}
//---------------------------------------------------
$fn = 50;
for (x = [ 0 : n - 1 ])
{
    translate([ x * (w1 + f), 0, 0 ])
    {
        holder();
    }
}
// Quitamos 2 layerHeights para tener holgura.
//pin(- 2 * lh);