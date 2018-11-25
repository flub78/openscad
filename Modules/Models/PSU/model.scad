 /**
 * Genera un modelo que puede ser usado como negativo para marcar los tornillos y
 * rectángulos de la fuente.
 *
 * @param {Float[]} config    Configuración básica del modelo.
 * @param {Float}   thickness Grosor de las paredes donde se imprimirá el modelo.
 * @param {Integer} model     Índice de la configuración de los rectángulos a eliminar según marca y modelo.
 *                            Dichos rectángulos pueden ser el interruptor, enchufe, etc.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Models/PSU/model.scad
 * @license CC-BY-NC-4.0
 */
//----------------------------------------------------------
use <../../Pattern/honeycomb.scad>
//----------------------------------------------------------
module psuModel(config, thickness = 5, model = -1)
{
    translate([ 0, 0, config[2] / 2 ])
    {
        color("Orange")
        {
            cube([ config[0], config[1], config[2] ], center = true);
        }
    }
    // Agujeros para los tornillos.
    _screws = config[3];
    if (_screws)
    {
        translate([ 0, 0, - thickness / 2 ])
        {
            for (_config = _screws)
            {
                translate([ _config[0], _config[1], 0 ])
                {
                    color("Khaki")
                    {
                        cylinder(d = _config[2] == undef ? 3.5 : _config[2], h = thickness, center = true);
                    }
                }
            }
        }
    }
    // Panales para la ventilación.
    _honeycomb = config[4];
    if (_honeycomb)
    {
        for (_config = _honeycomb)
        {
            translate([ _config[0], _config[1], - thickness / 2 + 0.001 ])
            {
                color("Gold")
                {
                    cube([ _config[2], _config[3], thickness ], center = true);
                    //honeycombCube(_config[2], _config[3], thickness, 10, 2.4);
                }
            }
        }
    }
    _rects = config[5][model];
    if (_rects)
    {
        // Rectángulos según el modelo seleccionado.
        for (_rect = _rects)
        {
            translate([ _rect[0], _rect[1], - thickness ])
            {
                color("Tomato")
                {
                    cube([ _rect[2], _rect[3], thickness ]);
                }
            }
        }
    }
}
