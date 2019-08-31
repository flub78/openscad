/**
 * Genera un tornillo con su respectiva tuerca para sujetar carretes de 
 * cualquier tipo y tamaño, principalmente pensado para rollos de filamento.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/3DPrinter/SpoolHolder.scad
 * @license CC-BY-NC-4.0
 * @url     https://www.thingiverse.com/thing:3838390
 */
//-----------------------------------------------------------------------------
use <../Modules/helix.scad>
use <../Modules/Cylinder/spool.scad>
//-----------------------------------------------------------------------------
bDiameter = 90;    // Diámetro de la base.
bHeight   = 20;    // Altura de la base.
bType     = 1;     // Tipo de base a generar llamando al módulo `base{bType}`);
height    = 60;    // Altura del tornillo.
count     = 4;     // Cantidad de palas a dibujar.
rod       = 8.6;   // Diámetro de la varilla central.
thickness = 4;     // Grosor de las paredes.
bearing   = false; // `false` o medidas del rodamiento ([ diámetro externo, grosor ]).
                   // El diámetro interno se especifica en la variable `rod`.
//-----------------------------------------------------------------------------
epsilon = $preview ? 0.01 : 0;
rb      = bearing ? bearing[0] / 2 + thickness : 0;
rr      = rod / 2 + thickness;
radius  = max(rr, rb);
$fn     = 160;
//-----------------------------------------------------------------------------

/**
 * Dibuja la base según el valor de la variable `bType`.
 */
module base()
{
    if (bType == 1)
    {
        base1();
    }
    else if (bType == 2)
    {
        base2();
    }
    else if (bType == 3)
    {
        base3();
    }
    else
    {
        base0();
    }
}

/**
 * Base usada para pruebas del tornillo y rosca.
 */
module base0()
{
    cylinder(r = radius + thickness, h = bHeight);
    cylinder(r = radius + 3 * thickness, h = thickness);
}

/**
 * Dibuja la base tanto de la tuerca como del tornillo usando segmentos 
 * dando como resultado una forma cónica.
 */
module base1()
{
    /**
     * Figura 2D usada como base rotándola.
     */
    module b(r, l)
    {
        translate([ radius, - r ])
        {
            square([ l, 2 * r ]);
            translate([ l, r ])
            {
                circle(r = r);
            }
        }
    }
    //--------------------------------------------------------
    cylinder(r = radius + thickness, h = bHeight);
    difference()
    {
        cylinder(d = bDiameter, h = thickness);
        translate([ 0, 0, - epsilon / 2 ])
        {
            cylinder(d = bDiameter - 2 * thickness, h = thickness + epsilon);
        }
    }
    for (_a = [ 0 : 360 / count : 359 ])
    {
        rotate([ 0, 0, _a ])
        {
            render()
            {
                _l = bDiameter / 2 - radius - thickness / 2;
                // Parte inferior recta.
                linear_extrude(thickness)
                {
                    b(thickness / 2, _l);
                }
                translate([ 0, 0, thickness - epsilon ])
                {
                    hull()
                    {
                        _e = 0.001;
                        // Parte inferior donde empieza la conicidad.
                        linear_extrude(_e)
                        {
                            b(thickness / 2, _l);
                        }
                        // Parte superior donde termina la conicidad.
                        translate([ 0, 0, bHeight - thickness - 2 * _e ])
                        {
                            linear_extrude(_e)
                            {
                                b(thickness / 2, thickness / 2);
                            }
                        }
                    }
                }
            }
        }
    }
}

/**
 * Dibuja la base tanto de la tuerca como del tornillo con forma cilíndrica para usarse
 * con carretes de diámetro fijo.
 */
module base2()
{
    spool(bDiameter, bHeight, thickness, 0, [  for (_a = [ 0 : 360 / count : 359 ]) _a ]);
    cylinder(r = radius + thickness, h = bHeight);
    difference()
    {
        cylinder(d = bDiameter + 2 * thickness, h = thickness);
        translate([ 0, 0, - epsilon / 2 ])
        {
            cylinder(d = bDiameter, h = thickness + epsilon);
        }
    }
}

/**
 * Dibuja una base cónica pero eliminando unas porciones.
 */
module base3()
{
    difference()
    {
        cylinder(r2 = radius + thickness, d1 = bDiameter, h = bHeight);
        for (_a = [ 0 : 360 / count : 359 ])
        {
            rotate([ 0, 0, _a ])
            {
                translate([ bDiameter / 2 + thickness, 0, - epsilon ])
                {
                    scale([ 1, 1.33, 1 ])
                    {
                        cylinder(r = bDiameter / count, h = bHeight + 2 * epsilon);
                    }
                }
            }
        }
    }
}

/**
 * Dibuja un sólido para dejar el espacio para el rodamiento.
 */
module bearing()
{
    _d = bearing[0];
    _h = bearing[1];
    cylinder(d = _d, h = _h);
    translate([ 0, 0, _h ])
    {
        cylinder(d1 = _d, d2 = 0, h = _d / 2);
    }
}

/**
 * Dibuja la tuerca.
 */
module nut(tolerance = 0.75)
{
    _h = 2 * thickness;
    difference()
    {
        if ($children)
        {
            children();
        }
        else
        {
            base();
        }
        translate([ 0, 0, bHeight / 2 - epsilon ])
        {
            thread(2 * bHeight, tolerance);
        }
        translate([ 0, 0, bHeight + epsilon / 2 - _h ])
        {
            cylinder(d1 = rod + thickness, r2 = radius + thickness / 2, h = _h + epsilon);
        }
        if (!bearing)
        {
            translate([ 0, 0, _h - epsilon / 2 ])
            {
                rotate([ 180, 0, 0 ])
                {
                    cylinder(d1 = rod + thickness, r2 = radius + thickness / 2, h = _h + epsilon);
                }
            }
        }
    }
}

/**
 * Dibuja el tornillo.
 */
module screw()
{
    difference()
    {
        union()
        {
            if ($children)
            {
                children();
            }
            else
            {
                base();
            }
            translate([ 0, 0, height / 2 + bHeight - epsilon / 2 ])
            {
                thread();
            }
        }
        cylinder(d = rod, h = 2 * (bHeight + height), center = true);
        if (bearing)
        {
            translate([ 0, 0, - epsilon ])
            {
                bearing();
            }
            translate([ 0, 0, bHeight + height + epsilon])
            {
                rotate([ 180, 0, 0 ])
                {
                    bearing();
                }
            }
        }
    }
}

module thread(height = height, tolerance = 0)
{
    helixThread(
        angle     = 5,
        diameter  = 2 * radius,
        height    = height + epsilon,
        pitch     = 0.175,
        thickness = 1.25 * thickness,
        tolerance = tolerance
    );
}

//------------------------------------------------------------
echo(str("SpoolHolder-", bDiameter, "x", bHeight + height, "x", thickness, "-b", bType, "x", count, ".stl"));
screw();
translate([ bDiameter + 3 * thickness, 0, 0 ])
{
    nut();
}
