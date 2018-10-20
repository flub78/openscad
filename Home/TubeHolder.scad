/**
 * Genera un soporte para colocar un tubo como los usados en los armarios.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Home/TubeHolder.scad
 * @license CC-BY-NC-4.0
 * @see     http://www.thingiverse.com/thing:3165425
 */
//------------------------------------------
// Valores personalizables
//------------------------------------------
diam      = 25.4;  // Diámetro del tubo
height    = 48;    // Altura de la pieza (eje Y)
radius    = 2;     // Radio de las equinas.
screw     = 5;     // Diámetro del tornillo a usar.
thickness = 16;    // Grosor de la pieza (eje Z)
width     = 55;    // Anchura de la pieza (eje X)
test      = false; // `true` para generar una lámina delgada para hacer pruebas.
headType  = 2;     // Diferentes tipos de acabados en la cabeza del tornillo:
                   // 0 - Ninguno
                   // 1 - Hexagonal
                   // 2 - Avellanado
                   // 3 - Hueco
//------------------------------------------
// Otras variables
//------------------------------------------
margin = diam / 4;       // Margen entre el tubo y el borde superior.
rtube  = (diam + 2) / 2; // Radio del tubo. Sumamos 2 al diámetro para tener holgura.
eps    = 0.001;          // Ajuste de algunas medidas para que en Preview se vea bien
$fn    = 75;

/**
 * Dibuja el bloque sobre el que se coloca el tubo.
 */
module block()
{
    difference()
    {
        // Base
        hull()
        {
            for (x = [ radius, width - radius ])
            {
                for (y = [ radius, height - radius ])
                {
                    translate([ x, y, 0 ])
                    {
                        cylinder(r = radius, h = thickness, center = true);
                    }
                }
            }
        }
        // Ranura para el tubo
        translate([ width / 2, height - margin, 0 ])
        {
            cube([ rtube * 2, rtube * 2, thickness + eps ], center = true);
            translate([ 0, - rtube, 0 ])
            {
                cylinder(r = rtube, h = thickness + eps, center = true);
            }
        }
        // Redondeo de las esquinas internas.
        for (x = [ -1, 1 ])
        {
            translate([
                width / 2 + x * (rtube + radius - eps),
                height - radius,
                0
            ])
            {
                difference()
                {
                    translate([ - x * radius / 2, radius / 2, 0 ])
                    {
                        cube([ radius, radius, thickness + eps ], center = true);
                    }
                    cylinder(r = radius, h = thickness + eps, center = true);
                }
            }
        }
    }
}
/**
 * Dibuja los agujeros para los tornillos.
 */
module screws()
{
    dhead  = screw * 1.9;
    w      = width / 2 - rtube;
    screws = [
        [ w / 2,         height * 0.8, 0 ],
        [ width - w / 2, height * 0.8, 0 ],
        [ width / 2,     (height - margin) * 0.5 - rtube, 0 ]
    ];
    for (screwCoord = screws)
    {
        translate(screwCoord)
        {
            cylinder(d = screw, h = thickness + eps, center = true);
            if (headType)
            {
                translate([ 0, 0, thickness / 2 - 1.5 + eps ])
                {
                    if (headType == 1)
                    {
                        cylinder(
                            d      = dhead,
                            h      = 3,
                            center = true,
                            $fn    = 6
                        );
                    }
                    else if (headType == 2)
                    {
                        cylinder(
                            d1     = screw,
                            d2     = dhead,
                            h      = screw * 0.75,
                            center = true
                        );
                    }
                    else if (headType == 3)
                    {
                        cylinder(
                            d      = dhead,
                            h      = screw * 0.75,
                            center = true
                        );
                    }
                }
            }
        }
    }
}
//------------------------------------------
// Inicio del script
//------------------------------------------
difference()
{
    block();
    screws();
    // En modo test eliminamos la mayor parte del soporte
    // dejando solamente una lámina delgada para hacer pruebas.
    if (test)
    {
        translate([ width / 2, height / 2, 0 ])
        {
            translate([ 0, 0, thickness / 2 ])
            {
                cube([ width * 2, height * 2, 4.8 ], center = true);
            }
            translate([ 0, 0, -3.6 ])
            {
                cube([ width * 2, height * 2, thickness ], center = true);
            }
        }
    }
}
