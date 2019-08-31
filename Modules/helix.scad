/**
 * Módulo para generar espirales 3D y tornillos.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/helix.scad
 * @license CC-BY-NC-4.0
 */
//-----------------------------------------------------------------------------
/**
 * Dibuja una espiral 3D según los valores de avance del ángulo y altura
 * hasta completar las altura especificada.
 *
 * @param {Float} height    Altura de la espiral.
 * @param {Float} pitch     Valor del avance en el eje Z.
 * @param {Float} angle     Ángulo de avance para cada segmento.
 * @param {Float} direction Sentido de giro (1 para levógiro o -1 para dextrógiro).
 */
module helix(height = 10, pitch = 1, angle = 10, direction = -1)
{
    for (_n = [ 0 : height / pitch ])
    {
        translate([ 0, 0, _n * pitch ])
        {
            rotate([ 0, 0, _n * angle ])
            {
                render()
                {
                    hull()
                    {
                        $fs = 0.01;
                        for (_z = [ 0, pitch ])
                        {
                            translate([ 0, 0, _z ])
                            {
                                rotate([ 90, 0, _z ? angle : 0 ])
                                {
                                    linear_extrude(height = 0.0001, convexity = 10)
                                    {
                                        children();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

/**
 * Dibuja una espiral 3D dando los grados que deben recorrerse y la altura.
 *
 * @param {Float} degrees   Grados que debe recorrer el espiral.
 * @param {Float} height    Altura de la espiral.
 * @param {Float} direction Sentido de giro (1 para levógiro o -1 para dextrógiro).
 */
module helixDegrees(degrees = 360, height = 100, direction = -1)
{
    _count = floor(abs(($fn ? $fn : 36) * degrees / 360));
    helix(height, height / _count, direction * degrees / _count, direction)
    {
        children();
    }
}

/**
 * Dibuja un tornillo usando una espiral.
 * Se puede especificar una figura 2D como hijo para generar el filete de la rosca.
 *
 * @param {Float}   height    Altura del tornillo.
 * @param {Float}   pitch     Valor del avance en el eje Z.
 * @param {Float}   angle     Ángulo de avance para cada segmento.
 * @param {Float}   direction Sentido de giro (1 para levógiro o -1 para dextrógiro).
 * @param {Float}   diameter  Diámetro del tornillo.
 * @param {Float}   tolerance Tolerancia para ajustar la rosca.
 * @param {Float}   thickness Grosor del filete de la rosca.
 * @param {Boolean} chamfer   Si es `true` se achaflana la punta.
 */
module helixThread(height = 100, pitch = 1, angle = 10, direction = -1, diameter = 10, thickness = 1, tolerance = 0, chamfer = true)
{
    _d = diameter + tolerance;
    difference()
    {
        union()
        {
            translate([ 0, 0, - height / 2 - thickness ])
            {
                helix(height + thickness, pitch, angle, direction)
                {
                    if ($children)
                    {
                        children();
                    }
                    else
                    {
                        _t = thickness + tolerance / 2;
                        translate([ _d / 2, 0 ])
                        {
                            polygon(
                                points = [
                                    [ 0          , 0           ],
                                    [ 0.3333 * _t, 0.3333 * _t ],
                                    [ 0.3333 * _t, 0.6666 * _t ],
                                    [ 0          , 1      * _t ],
                                ]
                            );
                        }
                    }
                }
            }
            cylinder(d = _d, h = height, center = true);
        }
        translate([ 0, 0, - height / 2 - 2 * thickness ])
        {
            cylinder(d = _d + 2 * thickness, h = 2 * thickness);
        }
        translate([ 0, 0, height / 2 ])
        {
            if (chamfer)
            {
                rotate_extrude(convexity = 10)
                {
                    _t = thickness;
                    polygon(
                        points = [
                            [ 0            , _d   ],
                            [ 0            , 0    ],
                            [ (_d - _t) / 2, 0    ],
                            [ _d           , - _d ],
                            [ _d           , _d   ],
                        ]
                    );
                }
            }
            else
            {
                cylinder(d = _d + 2 * thickness, h = 2 * thickness);
            }
        }
    }
}
