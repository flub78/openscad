/**
 * Renderiza el contenedor de una clema para realizar conexiones eléctricas.
 * La clema puede ser extraída e insertada en este diseño para realizar
 * otros tipos de usos.
 *
 * @param {Float[]} block     Medidas del bloque (ancho, alto, largo).
 * @param {Float[]} screw     Medidas del tornillo (diámetro, alto, separación).
 * @param {Float}   thickness Grosor de las paredes.
 * @param {String}  type      Tipo de clema (block, cylinder).
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Electrical/terminalBlock.scad
 * @license CC-BY-NC-4.0
 */
module terminalBlock(block, screw, thickness = 0.7, type = "block")
{
    terminalWidth  = block[0];
    terminalHeight = block[1];
    terminalLength = block[2];
    screwDiam      = screw[0];
    screwHeight    = screw[1];
    screwSep       = screw[2];
    dthickness     = 2 * thickness;
    difference()
    {
        union()
        {
            difference()
            {
                cube(
                    size = [
                        terminalWidth  + dthickness,
                        terminalLength + dthickness,
                        terminalHeight + dthickness
                    ],
                    center = true
                );
                cube(
                    size = [
                        terminalWidth,
                        terminalLength + dthickness,
                        terminalHeight
                    ],
                    center = true
                );
            }
            
            translate([ 
                0,
                0,
                terminalHeight + dthickness - (screwHeight - thickness) / 2
            ])
            {
                if (type == "cylinder")
                {
                    for (y = [ -1, 1 ])
                    {
                        translate([ 0, y * screwSep / 2, 0 ])
                        {
                            cylinder(
                                d      = screwDiam + dthickness,
                                h      = screwHeight,
                                center = true,
                                $fn    = 50
                            );
                       }
                    }
                }
                else if (type == "block")
                {
                    cube(
                        size   = [
                            terminalWidth  + dthickness,
                            terminalLength + dthickness,
                            screwHeight
                        ],
                        center = true,
                        $fn    = 50
                    );
                }
            }
        }
        for (y = [ -1, 1 ])
        {
            translate([0, y * screwSep / 2, terminalWidth + thickness])
            {
                cylinder(
                    d      = screwDiam, 
                    h      = terminalHeight + dthickness, 
                    center = true,
                    $fn    = 50
                );
           }
        }
    }
}
//-------------------------------------------
// Ejemplo
//-------------------------------------------
// terminalBlock(
//     [ 4.375, 4.9, 11.2 ], 
//     [ 3.85,  3.5,  6   ],
//     0.5, 
//     "block"
// );
//-------------------------------------------