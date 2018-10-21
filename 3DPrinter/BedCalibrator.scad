/**
 * Dibuja un patrón que permite facilitar la calibración de la cama caliente.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/3DPrinter/BedCalibrator.scad
 * @license CC-BY-NC-4.0
 * @see     http://www.thingiverse.com/thing:3168462
 */
//-----------------------------------------------------------------------------
// Valores personalizables
//-----------------------------------------------------------------------------
count               = 4;     // Cantidad de divisiones de cada lado.
drawCircles         = true;  // Dibujar círculos?
drawHorizontalLines = true;  // Dibujar líneas horizontales (eje X)?
drawVerticalLines   = true;  // Dibujar líneas verticales (eje Y)?
drawObliqueLines    = true;  // Dibujar líneas oblicuas (a 45º).
side                = 180;   // Longitud de cada lado.
thickness           = 1.2;   // Grosor de las líneas.
//-----------------------------------------------------------------------------
/**
 * Dibuja la distancia entre 2 puntos cartesianos.
 */
module line(x, y, xmax, ymax, thickness, angle = 45)
{
    translate([ x, y, - thickness / 2 ])
    {
        rotate(angle)
        {
            square(
                [ 
                    thickness,
                    norm([ xmax - abs(2 * x), ymax - abs(2 * y) ]) - thickness
                ], 
                center = true
            );
        }
    }
}
/**
 * Dibuja el marco.
 */
module marco(side, thickness = 0.9)
{
    difference()
    {
        square(side, center = true);
        square(side - 2 * thickness, center = true);
    }
}
//-----------------------------------------------------------------------------
// Inicio del script.
//-----------------------------------------------------------------------------
mside = side / 2;
size  = side / count;
linear_extrude(thickness)
{
    marco(side, thickness);
    for (a = [ - mside : size : mside ])
    {
        if (a != -mside && a != mside)
        {
            if (drawHorizontalLines)
            {
                translate([ 0, a ])
                {
                    square([ side, thickness ], center = true);
                }
            }
            if (drawVerticalLines)
            {
                translate([ a, 0 ])
                {
                    square([ thickness, side ], center = true);
                }
            }
        }
        if (drawObliqueLines)
        {
            line( a, a, side, side, thickness,  45);
            line(-a, a, side, side, thickness, -45);
        }
    }
    if (drawCircles)
    {
        for (i = [ 1 : count ])
        {
            difference()
            {
                circle(d = i * size, $fn = 180);
                circle(d = i * size - 2 * thickness, $fn = 180);
            }
        }
    }
}
