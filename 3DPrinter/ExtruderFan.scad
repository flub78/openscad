/**
 * Genera un ducto para el ventilador de un extrusor.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/3DPrinter/ExtruderFan.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3885769
 */
//------------------------------------------------
// Variables configurables
//------------------------------------------------
angleFrom =   0;   // Ángulo inicial del cuerpo de la tobera.
angleTo   = 360;   // Ángulo final del cuerpo de la tobera.
count     =   8;   // Cantidad de agujeros a abrir en la tobera.
dx        =  42.0; // Distancia X desde la punta de impresión a la salida del ventilador.
dz        =  28.0; // Distancia Z desde la punta de impresión a la salida del ventilador.
sx        =  13.0; // Dimensión X del conector de salida del ventilador del extrusor.
sy        =  16.5; // Dimensión Y del conector de salida del ventilador del extrusor.
sz        =   7.0; // Dimensión Z del conector de salida del ventilador del extrusor.
inner     =   3.0; // Radio del elemento interno de la tobera.
outer     =   6.0; // Radio del elemento externo de la tobera.
radius    =  16.0; // Radio de la tobera.
rmink     =   0.8; // Radio para redondear algunas aristas.
thickness =   1.0; // Grosor de las paredes
delta     =   5.0; // Valor Y a desplazar el cuerpo con respecto al centro del círculo.
//------------------------------------------------
// Variables calculadas
//------------------------------------------------
cx  = radius + 1.5 * inner + 0.5 * outer; // Centro del círculo.
sxt = sx / 2 + thickness;
syt = sy + 2 * thickness;
t   = 2 * thickness;
th  = thickness;
//------------------------------------------------

/**
 * Devuelve el ángulo que corresponde con la longitud especificada.
 *
 * @param {Float} length Longitud a convertir en ángulo.
 *
 * @return {Float}
 */
function getAngle(length) = (180 / 3.14159) * (length / cx);

/**
 * Dibuja un arco que permite unir el cuerpo con la tobera mediante la operación `hull`.
 *
 * @param {Float}   length   Longitud del arco.
 * @param {Float}   diameter Diámetro del arco.
 * @param {Integer} type     Tipo de operación a realizar en algunos elementos (1: diferencia, 2: unión).
 */
module arc(length, diameter = outer, type = 1)
{
    _a = getAngle(length);
    translate([ 0, 0, diameter / 2 ])
    {
        rotate([ 0, 0, - _a / 2 ])
        {
            rotate_extrude(angle = _a, convexity = 10, $fn = 180)
            {
                translate([ radius + inner, 0 ])
                {
                    if (type == 1)
                    {
                        difference()
                        {
                            circle(d = diameter);
                            translate([ - diameter * 2, - diameter ])
                            {
                                square([ diameter * 2, diameter * 2 ]);
                            }
                        }
                    }
                    else if (type == 2)
                    {

                        circle(d = diameter);
                        translate([ - diameter * 2, - diameter ])
                        {
                            square([ diameter * 2, diameter * 2 ]);
                        }
                    }
                }
            }
        }
    }
}

/**
 * Dibuja el cuerpo que se conecta con la turbina del extractor de la impresora.
 * Los puntos de los polígonos 2D siguen este patrón:
 *
 *              g---h
 *              |   |
 *           e--f---i--j
 *           |         |
 *           d         k
 *           /        /
 *          /        /
 *  b------c        /
 *  |              /
 *  |             /
 *  a-----------l
 */
module body()
{
    _l = min(dx - cx, dz) / 2;
    _m = _l * tan(30); // Ángulo de inclinación (< 45)
    _o = outer + _l;
    _p = outer + _m;
    translate([ 0, delta + syt / 2, 0 ])
    {
        difference()
        {
            translate([ 0, - rmink, 0 ])
            {
                rotate([ 90, 0, 0 ])
                {
                    minkowski()
                    {
                        linear_extrude(syt - rmink * 2, convexity = 10)
                        {
                            offset(delta = - rmink)
                            {
                                polygon(
                                    points = [
                                        [ cx           , 0     ], // a
                                        [ cx           , outer ], // b
                                        [ dx - sxt - _m, outer ], // c
                                        [ dx - sxt     , _o    ], // d
                                        [ dx - sxt     , dz    ], // e
                                        [ dx + sxt     , dz    ], // j
                                        [ dx + sxt     , _o    ], // k
                                        [ dx + sxt - _p, 0     ], // l
                                    ]
                                );
                            }
                        }
                        sphere(r = rmink);
                    }
                }
                // Conexión superior con el ventilador.
                translate([ dx, rmink - sy / 2 - th, dz ])
                {
                    boxRounded(sx, sy, sz, rmink);
                }
            }
            // Cavidad interna
            translate([ 0, - 2 * th, 0 ])
            {
                rotate([ 90, 0, 0 ])
                {
                    linear_extrude(sy - t, convexity = 10)
                    {
                        polygon(
                            points = [
                                [ 0                 , th           ], // a
                                [ 0                 , outer - th   ], // b
                                [ dx - sxt - _m + th, outer - th   ], // c
                                [ dx - sxt + t      , _o           ], // d
                                [ dx - sx / 2 + th  , dz + sz      ], // f
                                [ dx - sx / 2 + th  , dz + sz + th ], // g
                                [ dx + sxt - t      , dz + sz + th ], // h
                                [ dx + sxt - t      , _o           ], // i
                                [ dx + sxt - _p - th, th           ], // l
                            ]
                        );
                    }
                }
            }
        }
    }
}

/**
 * Dibuja una caja con las esquinas redondeadas.
 *
 * @param {Float} x Longitud de la caja sobre el eje X.
 * @param {Float} y Longitud de la caja sobre el eje Y.
 * @param {Float} z Altura de la caja.
 * @param {Float} r Radio a usar para redondear las esquinas.
 */
module boxRounded(x, y, z, r = 1)
{
    _x = x / 2 - r;
    _y = y / 2 - r;
    linear_extrude(z)
    {
        hull()
        {
            for (_i = [ - _x, _x ])
            {
                for (_j = [ - _y, _y ])
                {
                    translate([ _i, _j ])
                    {
                        circle(r = r);
                    }
                }
            }
        }
    }
}

/**
 * Conecta la tobera con el cuerpo.
 */
module connector()
{
    _a = getAngle(delta);
    difference()
    {
        hull()
        {
            translate([ cx, delta, outer / 2 ])
            {
                minkowski()
                {
                    cube([ outer - rmink, syt - 2 * rmink, outer - 2 * rmink ], center = true);
                    sphere(r = rmink);
                }
            }
            rotate([ 0, 0, _a ])
            {
                arc(2 * sy, outer);
            }
        }
        translate([ 0, 0, thickness ])
        {
            rotate([ 0, 0, _a ])
            {
                arc(2 * sy + t, outer - t, 2);
            }
        }
        translate([ cx, delta, outer / 2 ])
        {
            cube([ outer + radius, sy - t, outer - t ], center = true);
        }
    }
}

/**
 * Dibuja la tobera
 */
module outlet(count = count)
{
    /**
     * Elemento que se extruye rotando para generar la circunferencia central.
     */
    module _(inner, outer)
    {
        hull()
        {
            translate([ 0, inner / 2 ])
            {
                circle(d = inner);
            }
            translate([ inner, outer / 2 ])
            {
                circle(d = outer);
            }
        }
    }

    /**
     * Elemento que se sustrae para permitir la salida del aire.
     */
    module __(inner = 2, outer = 4)
    {
        _m = max(inner, outer);
        hull()
        {
            for (_z = [ -1, 1 ])
            {
                translate([ 0, 0, _z * outer / 2 ])
                {
                    sphere(d = inner);
                }
                translate([ outer, 0, _z * inner / 2 ])
                {
                    sphere(d = outer);
                }
            }
        }
    }
    //-------------------------------------------------------------------------
    _ra = angleTo - angleFrom;
    difference()
    {
        rotate([ 0, 0, 180 + angleFrom ])
        {
            rotate_extrude(angle = _ra, convexity = 10, $fn = 180)
            {
                translate([ radius, 0 ])
                {
                    difference()
                    {
                        _(inner, outer);
                        offset(delta = - thickness)
                        {
                            _(inner, outer);
                        }
                    }
                }
            }
        }
        _da = _ra / count;
        for (_a = [ angleFrom : _da : angleTo - _da / 2 ])
        {
            rotate([ 0, 0, _a + _da / 2 ])
            {
                translate([ - radius - inner / 2 + thickness, 0, inner / 2 - thickness ])
                {
                    __(inner / 2, outer / 2);
                }
            }
        }
        rotate([ 0, 0, getAngle(delta) ])
        {
            arc(sy + t, outer + 0.02);
        }
    }
    if (abs(_ra) < 360)
    {
        for (_a = [ angleFrom, angleTo ])
        {
            rotate([ 0, 0, 180 + _a ])
            {
                translate([ radius, 0, 0 ])
                {
                    rotate([ 90, 0, 0 ])
                    {
                        translate([ 0, 0, - thickness / 2 ])
                        {
                            linear_extrude(thickness)
                            {
                                _(inner, outer);
                            }
                        }
                    }
                }
            }
        }
    }
}
//-----------------------------------------------------------------------------
// Inicio del script.
//-----------------------------------------------------------------------------
$fn = 30;
difference()
{
    union()
    {
        outlet();
        connector();
        body();
    }
    //-------------------------------------------------------------------------
    // Corte sobre el plano XZ
    //-------------------------------------------------------------------------
    translate([ - cx, 0, - thickness ])
    {
//        cube([ dx * 2, cx * 2, 2 * dz ]);
    }
    //-------------------------------------------------------------------------
    // Corte sobre el plano XY
    //-------------------------------------------------------------------------
    translate([ - cx, - cx, outer / 2 ])
    {
//        cube([ dx * 2, cx * 2, 2 * dz ]);
    }
}

