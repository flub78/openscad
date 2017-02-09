/*
 * Módulos y funciones para trabajar con memorias MicroSD.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Memory/micro-sd.scad
 * @license CC-BY-NC-4.0
 */
/**
 * Devuelve las medidas de la memoria MicroSD.
 *
 * @param {Number} tolerance Tolerancia a usar para las medidas.
 *
 * @return {Number[]}
 */
function getMicroSdSize(tolerance = 0) = [
    11 + tolerance, 
    15 + tolerance, 
     1 + tolerance
];
/**
 * Dibuja una tarjeta MicroSD.
 * Es útil para dejar el espacio en una figura usando la operación `difference`.
 * En este caso se recomienda:
 *
 * - Disminuir el radio para que entre mejor la memoria y usar la 
 *   transformación `scale(1.xx)` para dejar holgura.
 * - Aumentar el valor de `thickness` si se quiere dejar una profundidad mayor.
 *
 * @param radius    Radio para redondear los bordes.
 * @param showTab   Indica si se debe mostrar la pestaña superior.
 */
module microSd(radius = 0.8, showTab = 0)
{
    _size = getMicroSdSize();
    // Grosor de la memoria
    _C  = _size[2];
    _C1 = 0.7;
    // Radio de los bordes.
    _R  =  radius;
    // Anchuras a usar
    _A  = _size[0];
    _A1 =  9.7;
    // Alturas a usar
    _B  = _size[1];
    _B1 =  6.0; // 6.4
    _B2 = _B - _B1;
    // Único valor que se debe calcular.
    _X  = _B2 + (_A - _A1);
    // Construimos la ruta.
    _path      = [
        [       _R,        0 ],
        [       _R,       _R ],
        [   0     ,       _R ],
        [   0     , _B -  _R ],
        [  _R     , _B -  _R ],
        [  _R     , _B       ],
        [ _A1 - _R, _B       ],
        [ _A1 - _R, _B -  _R ],
        [ _A1     , _B -  _R ],
        [ _A1     , _X       ],
        [  _A     , _B2      ],
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
                for (_i = [ 1, 4, 7, 12 ])
                {
                    translate(_path[_i])
                    {
                        circle(r = _R, $fn = 50);
                    }
                }
            }
        }
        if (showTab)
        {
            translate([ 0, 1.84, _C1 ])
            {
                cube([ _A, _B, _C ]);
            }
        }
    }
}
