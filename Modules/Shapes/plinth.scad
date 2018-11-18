/**
 * Genera una base para soportar diversos tipos de objetos.
 *
 * @param top    Configuración de la parte superior (radio, altura y borde).
 * @param bottom Configuración de la parte inferior o base (radio, altura y borde).
 * @param screw  Configuración del tornillo para sujetar el portalámparas (diámetro y separación del borde).
 * @param radius Radio a usar para unir la parte inferior y superior.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Shapes/plinth.scad
 * @license CC-BY-NC-4.0
 */
module plinth(top, bottom, screw = 0, radius = 8)
{
    rb     = bottom[2] == undef ? 0 : bottom[2];
    rt     = top[2]    == undef ? 0 : top[2];
    points = [
        [ 0, 0 ],
        [ 0, top[1] ],
        [ top[0] - rt, top[1] ],
        [ top[0], top[1] - rt ],
        [ top[0], bottom[1] ]
    ];
    difference()
    {
        rotate_extrude()
        {
            offset(r = -radius) 
            {
                offset(delta = radius) 
                {
                    if (rb < 0)
                    {
                        polygon(
                            points = concat(
                                points, 
                                [
                                    [ bottom[0], bottom[1] ],
                                    [ bottom[0], -rb ],
                                    [ bottom[0] + rb, 0 ]
                                ]
                            )
                        );
                        translate([ bottom[0] + rb, -rb ])
                        {
                            circle(r = -rb);
                        }
                    }
                    else
                    {
                        polygon(
                            points = concat(
                                points, 
                                [
                                    [ bottom[0] - rb, bottom[1] ],
                                    [ bottom[0], bottom[1] - rb ],
                                    [ bottom[0], 0 ]
                                ]
                            )
                        );
                        if (rb > 0)
                        {
                            translate([ bottom[0] - rb, bottom[1] - rb ])
                            {
                                circle(r = rb);
                            }
                        }
                    }
                    if (rt)
                    {
                        translate([ top[0] - rt, top[1] - rt ])
                        {
                            circle(r = rt);
                        }
                    }
                }
            }
        }
        if (screw && screw[0] && screw[1])
        {
            _a = screw[2];
            _d = screw[0];
            _f = _d * (1 + sin(40.5) / sin(49.5));
            for (x = [ -1, 1 ])
            {
                translate([ x * screw[1], 0, 0 ])
                {
                    cylinder(d = _d, h = bottom[1] * 4, center = true);
                    if (_a < 0)
                    {
                        cylinder(d1 = _f, d2 = _d, h  = _d / 2);
                    }
                    else if (_a > 0)
                    {
                        translate([ 0, 0, bottom[1] - _d / 2 ])
                        {
                            cylinder(d1 = _d, d2 = _f, h  = _d / 2);
                        }
                    }
                }
            }
        }
    }
}