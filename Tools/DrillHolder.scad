/**
 * Dibuja una caja para guardar brocas.
 * Modificando los valores de la variable `sizes` se puede incluso
 * usar para guardar otros tipos de elementos tales como lápices,
 * bolígrafos, pinceles, etc..
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Tools/DrillHolder.scad
 * @license CC-BY-NC-4.0
 */
use <../Functions/flatten.scad>
use <../Functions/ceilMultiple.scad>
use <../Modules/Box/hollow.scad>
//-----------------------------------------------------------------------
// Valores personalizables
//-----------------------------------------------------------------------
// Valor del "layer height"
// El grosor de las paredes se calcula en función a este valor.
lh = 0.3;
// Indica si se agrega la muesca para sacar las brocas más fácilmente.
cut = true;
// Indica si se muestra la tapa o la caja.
showBox = 0;
// Dimensiones de las brocas: [0]: Diámetro, [1]: Largo
// Si se quiere holgura, tomar en cuenta a la hora de asignar los valores.
// Se pueden poner en cualquier orden pero si se ponen de mayor a menor
// se aprovecha el espacio que queda para guardar tornillos, puntas, etc.
sizes = [
    [ 10, 133 ],
    [  8, 117 ],
    [  6,  93 ],
    [  5,  86 ],
    [  4,  74 ],
    [  3,  61 ]
];
//-----------------------------------------------------------------------
// Fin de la personalización.
//-----------------------------------------------------------------------
function offsetX(i, total = 0, thickness = 0) = i > 0
    ? offsetX(i - 1, total + sizes[i - 1][0] + thickness + d, thickness)
    : total + thickness;

function flatSizes(idx = 0, i = len(sizes) - 1, arr = []) = flatten(sizes, idx, i, arr);

// Grosor de las paredes.
b  = ceilMultiple(1.2, lh);
// Altura de la parte de la tapa que entra en la caja
ci = ceilMultiple(3.75, lh);
// Valor a usar como holgura.
// Esto permite poner las medidas absolutas sin estar pendiente 
// de sumarle un pequeño espacio para que la broca entre fácil.
d  = 4 * lh;
// Cantidad de elementos
n  = len(sizes);
// Altura interna de la caja (eje Z)
h  = ceilMultiple(max(flatSizes(0)) + d + ci, lh);
// Largo interno de la caja (eje Y)
l  = ceilMultiple(max(flatSizes(1)) + d, lh);
// Anchura interna de la caja (eje X)
w  = offsetX(n, 0, b) - 2 * b;
//-----------------------------------------------------------------------
// Inicio
//-----------------------------------------------------------------------
module box(w, l, h, b)
{
    _2b = 2 * b;
    difference()
    {
        difference()
        {
            union()
            {
                boxHollow(w, l, h, _2b);
                for (i = [ 0 : n - 1 ])
                {
                    translate([ offsetX(i, 0, b), b, 0 ])
                    {
                        boxHollow(
                            ceilMultiple(sizes[i][0] + d,lh),
                            ceilMultiple(sizes[i][1] + d, lh),
                            h,
                            b
                        );
                    }
                }
            }
            if (cut)
            {
                // Hacemos una muesca para sacar las brocas fácilmente.
                // La altura de las pestaña que queda es la mitad 
                // de la broca más fina.
                dy = min(flatSizes(1));
                translate([ _2b, dy / 4, _2b + min(flatSizes(0)) / 2 ])
                {
                    cube([ w - b, dy / 2, h ]);
                }
            }
        }
        // Colocamos la tapa para sacar la muesca de cierre.
        _h = h + 2 * _2b;
        _l = l + 2 * _2b;
        _w = w + 2 * _2b;
        translate([ _w, 0, _h ])
        {
            rotate([ 0, 180, 0 ])
            {
                cover(_w, _l, _2b, _2b);
            }
        }
    }
}
module cover(w, l, h, b, t = 0, hi = ci)
{
    _b = b + t;
    _d = b - t;
    _l = l - _b * 2;
    _w = w - _b * 2;
    difference()
    {
        union()
        {
            // Bloque externo
            cube([ w, l, h ]);
            translate([ _b, _b, h ])
            {
                // Bloque interno
                cube([ _w, _l, hi - t ]);
                translate([ 0, 0, (hi - t) / 2 ])
                {
                    for (i = [ 0, 1 ])
                    {
                        // Pestañas lado corto
                        //translate([ _w / 2, i * _l, t / 2 ])
                        //{
                        //    sphere(d = _d, center = true, $fn = 20);
                        //}
                        // Pestañas lado largo
                        translate([ i * _w, _l / 2, t / 2 ])
                        {
                            sphere(d = _d, center = true, $fn = 20);
                        }
                    }
                }
            }
        }
        for (i = [ 0, 1 ])
        {
            // Muescas lado corto
            //translate([ _w / 2 - b, i * (l - b / 2), b / 2 ])
            //{
            //    cube([ 4 * b, b / 2, 10 ]);
            //}
            // Muescas lado largo
            translate([ i * (w - b / 2), _l / 2 - b, b / 2 ])
            {
                cube([ b / 2, 4 * b, b ]);
            }
        }
    }
}
if (showBox)
{
    box(w, l, h, b);
}
else
{
    cover(
        w + 4 * b,
        l + 4 * b,
        2 * b,
        2 * b,
        1.5 * lh
    );
}
