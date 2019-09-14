 /**
 * Dibuja unas barras de manera repetida hasta completar la longitud.
 *
 * @param {Float}   length    Longitud del área a dibujar (eje X).
 * @param {Float}   width     Ancho de cada barra (eje X).
 * @param {Float}   height    Alto de cada barra (eje Y).
 * @param {Float}   thickness Grosor de las barras (eje Z).
 * @param {Float}   sep       Separación de las barras. Si no se especifica, se calcula.
 * @param {Boolean} rounded   Indica si se deben redondear los extremos.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Pattern/bars.scad
 * @license CC-BY-NC-4.0
 */
module bars(length, width, height, thickness, sep = 0, rounded = true)
{
    _n     = floor(length / height);
    _w     = rounded ? abs(width - height) : width;
    _count = sep > 0
        ? floor((length - sep) / (height + sep))
        : _n * height == length
            ? _n - 1
            : _n;
    _sep   = sep > 0 ? sep : (length - _count * height) / (_count + 1);
    _y0    = height / 2 + (length - _count * (_sep + height) + _sep) / 2;
    for (_y = [ 0 : _count - 1 ])
    {
        translate([ 0, _y * (_sep + height) + _y0, 0 ])
        {
            cube([ _w, height, thickness ], center = true);
            if (rounded)
            {
                for (_x = [ - _w / 2, _w / 2 ])
                {
                    translate([ _x, 0, 0 ])
                    {
                        cylinder(d = height, h = thickness, center = true);
                    }
                }
            }
        }
    }
}
