/**
 * Dibuja un soporte para memorias SD o MicroSD que puede
 * insertarse en cajas para cartuchos Nintendo DS.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Storage/NintendoMemoryHolder.scad
 * @license CC-BY-NC-4.0
 */
use <../Functions/Math/floorMultiple.scad>
use <../Modules/Box/rounded.scad>
use <../Modules/Memory/micro-sd.scad>
use <../Modules/Memory/sd.scad>
//-------------------------
// Valores personalizables
//-------------------------
// Tamaño usado para imprimir la pieza.
layerHeight = 0.3;
// 0: Imprime una SD, 1: Imprime 4 MicroSD.
isMicroSd   = 1;
//-------------------------
// Valores calculados
//-------------------------
scaledBy    = isMicroSd ? 1.05 : 1.02;
length      = floorMultiple(3.8, layerHeight);
height      = floorMultiple(35, layerHeight);
width       = floorMultiple(33, layerHeight);
size        = (isMicroSd ? getMicroSdSize() : getSdSize()) * scaledBy;
countX      = floor(width  / (size[0] + 1));
countY      = floor(height / (size[1] + 1));
sepX        = (width  - countX * size[0]) / (countX + 1);
sepY        = (height - countY * size[1]) / (countY + 1);
$fn         = 75;
difference()
{
    boxRounded(width, height, length, 3.3);
    translate([ - width / 2, - height / 2, length / 2 - size[2] * 1.25 ])
    {
        for (x = [ 1 : countX ])
        {
            for (y = [ 1 : countY ])
            {
                translate([
                    size[0] * (x - 1) + x * sepX,
                    size[1] * (y - 1) + y * sepY,
                    0.01
                ])
                {
                    scale([ scaledBy, scaledBy, size[2] * 1.25 ])
                    {
                        if (isMicroSd)
                        {
                           microSd(0.4);
                        }
                        else
                        {
                            sd();
                        }
                    }
                }
            }
        }
    }
}
