 /**
 * Genera el modelo para el concentrador USB de 4 puertos.
 *
 * @param {Float} layer3 Altura de la última capa.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Models/hub4ports.scad
 * @license CC-BY-NC-4.0
 */
//----------------------------------------------------------
use <../Box/rounded.scad>
//----------------------------------------------------------
module usbHub4Ports(layer3 = 2)
{
    // Dimensiones: 44 x 100 x (layer1 + layer2 + layer3)
    layer1 = 14;
    layer2 = 1;
    boxRounded(44, 100, layer1, 7.0);
    translate([ 7.5, 0, (layer1 + layer2) / 2 ])
    {
        boxRounded(25.2, 96.0, layer2, 4.5);
        translate([ 0, 0, (layer2 + layer3) / 2 ])
        {
            boxRounded(21.5, 92.0, layer3, 2.8);
        }
    }
    for (b = [ 0 : 3 ])
    {
        translate([ -10, -33 + b * 18.75, 7 ])
        {
            cylinder(d = 2, h = layer2 + layer3);
        }
    }
}
