/**
 * Módulos para dibujar cajas con bordes redondeados.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Box/rounded.scad
 * @license CC-BY-NC-4.0
 */
/**
 * Dibuja un bloque con los bordes XY redondeados.
 *
 * @param width  Ancho del bloque (eje X).
 * @param height Largo del bloque (eje Y).
 * @param length Alto del bloque (eje Z).
 * @param radius Radios del borde de cada esquina.
 */
module boxRounded(width, height, length, radius = [1,1,1,1])
{
    if (radius)
    {
        // Si se pasa un número, lo convertimos a un array.
        _radius = radius != undef && len(radius) == undef
            ? [ radius, radius, radius, radius ]
            : radius;
        translate([ 0, 0, - length / 2 ])
        {
            linear_extrude(length)
            {
                hull()
                {
                    for (_y = [ -1, 1 ])
                    {
                        for (_x = [ -1, 1 ])
                        {
                            _r = min(
                                _radius[(_y > 0 ? 2 : 0) + (_x > 0 ? 1 : 0)],
                                width / 2,
                                height / 2
                            );
                            translate([
                                _x * (width  / 2 - _r),
                                _y * (height / 2 - _r)
                            ])
                            {
                                if (_r)
                                {
                                    circle(r = _r, center = true, $fn = 100);
                                }
                                else
                                {
                                    square(0.01, center = true);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    else
    {
        cube([ width, height, length ], center = true);
    }
}
/**
 * Dibuja un bloque con todos los bordes redondeados.
 *
 * @param width  Ancho del bloque (eje X).
 * @param height Largo del bloque (eje Y).
 * @param length Alto del bloque (eje Z).
 * @param radius Radio del borde.
 */
module boxRounded3d(width, height, length, radius = 1)
{
    if (radius > 0)
    {
        hull()
        {
            for (z = [ -1, 1 ])
            {
                for (y = [ -1, 1 ])
                {
                    for (x = [ -1, 1 ])
                    {
                        translate([
                            x * (width  / 2 - radius),
                            y * (height / 2 - radius),
                            z * (length / 2 - radius)
                        ])
                        {
                            sphere(r = radius, center = true);
                        }
                    }
                }
            }
        }
    }
    else
    {
        cube([ width, height, length ], center = true);
    }
}
