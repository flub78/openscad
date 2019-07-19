 /**
 * Modelo para el concentrador USB de 4 puertos.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Models/hub4ports.scad
 * @license CC-BY-NC-4.0
 */
//----------------------------------------------------------
use <../Box/rounded.scad>
//----------------------------------------------------------
/**
 * Dimensiones del concentrador sin incluir los 2 relieves superiores.
 *
 * @return {Float[]}
 */
function usbHub4PortsSize() = [ 44, 100, 14 ];

/**
 * Genera el modelo para el concentrador USB de 4 puertos.
 *
 * @param {Float} layer3 Altura de la última capa.
 */
module usbHub4Ports(layer3 = 2)
{
    _size   = usbHub4PortsSize();
    // Dimensiones: 44 x 100 x (_layer1 + _layer2 + layer3)
    _layer1 = _size[2];
    _layer2 = 1;
    boxRounded(_size[0], _size[1], _layer1, 7.0);
    translate([ 7.5, 0, (_layer1 + _layer2) / 2 ])
    {
        boxRounded(25.2, 96.0, _layer2, 4.5);
        translate([ 0, 0, (_layer2 + layer3) / 2 ])
        {
            boxRounded(21.5, 92.0, layer3, 2.8);
        }
    }
    for (b = [ 0 : 3 ])
    {
        translate([ -10, -33 + b * 18.75, 7 ])
        {
            cylinder(d = 2, h = _layer2 + layer3);
        }
    }
}
