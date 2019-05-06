/**
 * Genera un contenedor para almacenar pilas.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Storage/Pringles/batteries.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3612377
 */
//---------------------------------------------------------------
use <../../Modules/Cylinder/battery.scad>
use <./container.scad>
//---------------------------------------------------------------

/**
 * Soporte para pilas cilíndricas.
 *
 * @param {String} name      Nombre o tipo de la pila.
 * @param {Float}  sep       Separación mínima entre las pilas.
 * @param {Float}  tolerance Tolerancia a usar dependiendo de la punta de la impresora.
 * @param {Float}  from      Radio inicial para empezar (eje radial).
 *
 * @see https://en.wikipedia.org/wiki/List_of_battery_sizes
 */
module batteries(name = "AAA", sep, tolerance = 0.6, from = 0)
{
    _battery = getBattery(name);
    if (_battery)
    {
        difference()
        {
            conc(
                length    = _battery[2] + tolerance,
                plength   = _battery[2] / 3,
                width     = _battery[1] + tolerance,
                height    = _battery[1] + tolerance,
                thickness = sep,
                from      = from
            );
            title(name);
        }
        echo(str("Pringles-batteries-", name, ".stl"));
    }
    else
    {
        echo(str("Tipo de pila desconocido: ", name));
    }
}

//-----------------------------------------------------------------------------
// batteries("18650", 5);
// batteries("AAAA", 0.9);
// batteries("AAA", 0.8, 0.6, 6.7);
// batteries("AA", 1.2, 0.9, 10);
