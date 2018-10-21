/**
 * Bandeja usada como embudo para permitir guardar piezas pequeñas.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Storage/FunnelTray.scad
 * @license CC-BY-NC-4.0
 * @see     http://www.thingiverse.com/thing:3168339
 */
//-----------------------------------------------------------------------------
// Valores personalizables
//-----------------------------------------------------------------------------
funnelLength = 6;   // Longitud del embudo
funnelWidth  = 3;   // Ancho del embudo.
radius       = 3;   // Radio de los bordes.
thickness    = 1.2; // Grosor de las paredes.
trayHeight   = 5;   // Alto del contenedor de las cajas (eje Z).
trayLength   = 50;  // Largo del contenedor de las cajas (eje Y).
trayWidth    = 30;  // Ancho del contenedor de las cajas (eje X).
//-----------------------------------------------------------------------------
use <../Functions/Math/line.scad>
//-----------------------------------------------------------------------------
function coord(i)  = sign(points[i][0] - points[i + 1][0]) == sign(points[i][1] - points[i + 1][1])
    ? [ points[i + 1][0], points[i    ][1] ]
    : [ points[i    ][0], points[i + 1][1] ];

/**
 * Dibuja la base de la bandeja.
 */
module base()
{
    polygon(points = points);
    for (i = [ 0, 2, 4 ])
    {
        translate(coord(i))
        {
            circle(r = radius);
        }
    }
    for (i = [ 8, 11 ])
    {
        translate(points[i])
        {
            circle(r = r);
        }
    }
}
//-----------------------------------------------------------------------------
// Inicio del script.
//-----------------------------------------------------------------------------
$fn    = 150;
f      = funnelLength + thickness / 2;
r      = thickness / 2;
xf     = max(trayWidth - funnelWidth * 2, thickness + radius);
point0 = [ xf, trayLength ];
point1 = [ trayWidth - 2 * thickness - funnelWidth, trayLength + funnelLength ];
point2 = [ trayWidth - r, trayLength + funnelLength ];
eq     = getEq(point1, point0);
data   = splice(point0, point2, point1, r);
angle  = data[0];
points = [
    [ trayWidth, radius ],
    [ trayWidth - radius, 0 ],
    [ radius, 0 ],
    [ 0, radius ],
    [ 0, trayLength - radius ],
    [ radius, trayLength ],
    point0,
    data[1],
    data[2],
    data[3],
    point2,
    [ trayWidth - r, trayLength + funnelLength - r ],
    [ trayWidth, trayLength + funnelLength - r ],
    [ trayWidth, trayLength + f ],
];

translate([ 0, 0, - thickness ])
{
    linear_extrude(thickness)
    {
        base();
    }
}
difference()
{
    linear_extrude(trayHeight - thickness)
    {
        difference()
        {
            base();
            offset(-thickness)
            {
                base();
            }
            polygon(
                points = [
                    [ (points[8][1] - r - eq[1]) / eq[0] + thickness / sin(angle), points[8][1] - r ],
                    [ points[8][0] + r * sin(angle), points[8][1] - r * cos(angle) ],
                    points[8],
                    points[7],
                    points[9],
                    points[13],
                    points[12],
                    points[11],
                    [ points[11][0] - r, points[11][1] ],
                    [ points[11][0] - r, points[11][1] - r ],
                ]
            );
        }
    }
}
for (i = [ 8, 11 ])
{
    translate(points[i])
    {
        cylinder(r = r, h = trayHeight - thickness);
    }
}
