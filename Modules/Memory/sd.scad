/*
 * Módulos y funciones para trabajar con memorias SD.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Memory/sd.scad
 * @license CC-BY-NC-4.0
 */
/**
 * Devuelve las medidas de la memoria SD.
 *
 * @param {Number} tolerance Tolerancia a usar para las medidas.
 *
 * @return {Number[]}
 */
function getSdSize(tolerance = 0) = [
    24  + tolerance, 
    32  + tolerance, 
    2.1 + tolerance
];
/**
 * Dibuja una tarjeta SD.
 * Es útil para dejar el espacio en una figura usando la operación `difference`.
 * En este caso se recomienda:
 *
 * - Disminuir el radio para que entre mejor la memoria y usar la 
 *   transformación `scale(1.xx)` para dejar holgura.
 * - Aumentar el valor de `thickness` si se quiere dejar una profundidad mayor.
 *
 * @param radius Radio para redondear los bordes.
 */
module sd(radius = 0.5)
{
    _size = getSdSize();
    _X  = 4;
    // Grosor de la memoria
    _C  = _size[2];
    // Radio de los bordes.
    _R  =  radius;
    // Anchuras a usar
    _A  = _size[0];
    _A1 = _size[0] - _X;
    // Alturas a usar
    _B  = _size[1];
    _B1 = _size[1] - _X;
    // Construimos la ruta.
    _path      = [
        [       _R,        0 ],
        [       _R,       _R ],
        [   0     ,       _R ],
        [   0     , _B -  _R ],
        [  _R     , _B -  _R ],
        [  _R     , _B       ],
        [ _A1     , _B       ],
        [  _A     , _B1      ],
        [  _A     ,       _R ],
        [  _A - _R,       _R ],
        [  _A - _R,        0 ]
    ];
    difference()
    {
        linear_extrude(_C)
        {
            union()
            {
                polygon(_path);
                for (_i = [ 1, 4, len(_path) - 2 ])
                {
                    translate(_path[_i])
                    {
                        circle(r = _R, $fn = 50);
                    }
                }
            }
        }
    }
}
