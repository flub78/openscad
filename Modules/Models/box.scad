/**
 * Modelo que dibuja una caja que puede tener tornillos y ranuras y que
 * puede usarse como un negativo sobre otra caja y obtener la diferencia.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Models/box.scad
 * @license CC-BY-NC-4.0
 *
 * @param {Float}   width     Anchura del modelo a generar.
 * @param {Float}   height    Altura del modelo a generar.
 * @param {Float}   length    Longitud del modelo a generar.
 * @param {Float}   thickness Grosor del bloque donde se insertará el modelo.
 * @param {Float}   screw     Diámetro del tornillo a usar.
 * @param {Float}   slot      Longitud de la ranura donde se insertarán los tornillos.
 * @param {Float}   tolerance Valor a usar para ajustar las medidas estándar.
 * @param {Float[]} side      Coordenadas de los agujeros laterales.
 * @param {Float[]} bottom    Coordenadas de los agujeros inferiores.
 */
module modelBox(width, height, length, thickness, screw = 0, slot = 0, side = [], bottom = [])
{
    _eps = $preview ? 0.01 : 0;
    cube([ width, height, length ]);
    // Agujeros laterales
    for (_side = side)
    {
        if (slot)
        {
            hull()
            {
                for (_n = [ - slot / 2, slot / 2 ])
                {
                    translate([ width / 2, _side[0], _side[1] + _n ])
                    {
                        rotate([ 0, 90, 0 ])
                        {
                            cylinder(d = screw, h = 2 * width, center = true);
                        }
                    }
                }
            }
        }
        else
        {
            translate([ width / 2, _side[0], _side[1] ])
            {
                rotate([ 0, 90, 0 ])
                {
                    cylinder(d = screw, h = 2 * width, center = true);
                }
            }
        }
    }
    // Agujeros inferiores
    for (_bottom = bottom)
    {
        if (slot)
        {
            hull()
            {
                for (_n = [ - slot / 2, slot / 2 ])
                {
                    translate([ width - _bottom[0], _eps, _bottom[1] + _n ])
                    {
                        rotate([ 90, 0, 0 ])
                        {
                            cylinder(d = screw, h = thickness + 2 * _eps);
                        }
                    }
                }
            }
        }
        else
        {
            translate([ width - _bottom[0], _eps, _bottom[1] ])
            {
                rotate([ 90, 0, 0 ])
                {
                    cylinder(d = screw, h = thickness + 2 * _eps);
                }
            }
        }
    }
}
