 /**
 * Dibuja un tubo cuadrado con 2 líneas en X y un eje que lo atraviesa.
 *
 * @param {Float}     side      Tamaño de cada lado del tubo.
 * @param {Float}     length    Longitud del tubo.
 * @param {Float}     diameter  Diámetro del eje que lo atraviesa.
 * @param {Float}     thickness Grosor de las paredes del tubo.
 * @param {Integer[]} slot      Índices de las ranuras a dibujar (1~8).
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Box/x.scad
 * @license CC-BY-NC-4.0
 */
module boxX(side, length, diameter, thickness, slots = [])
{
    _angle   = 45;
    // Valor inútil pero permite que OpenSCAD renderice los trazos en modo preview.
    _epsilon = $preview ? 0.001 : 0; 
    _side    = side - thickness * 2;
    _l       = length / 2;
    _t       = thickness * 1.5;
    _2t      = thickness * 2;
    _s       = side / 2;
    difference()
    {
        union()
        {
            difference()
            {
                cube([  side,  side, length ], center = true);
                cube([ _side, _side, length + _epsilon ], center = true);
            }
            for(_n = [ -1, 1 ])
            {
                rotate(_n * _angle)
                {
                    cube([ norm([ _side, _side ]), thickness, length ], center = true);
                }
            }
            cylinder(d = diameter + _2t, h = length, center = true);
            if (slots)
            {
                for (_slot = slots)
                {
                    _sign = _slot > 4 ? -1 : 1;
                    if (_slot == 1 || _slot == 6)
                    {
                        translate([ _sign * _s - thickness, -_s, -_l ])
                        {
                            cube([ _2t, _t, length ]);
                        }
                    }
                    else if (_slot == 2 || _slot == 5)
                    {
                        translate([ _sign * _s - thickness, _s - _t, -_l ])
                        {
                            cube([ _2t, _t, length ]);
                        }
                    }
                    else if (_slot == 3 || _slot == 8)
                    {
                        translate([ _s - _t, _sign * _s - thickness, -_l ])
                        {
                            cube([ _t, _2t, length ]);
                        }
                    }
                    else if (_slot == 4 || _slot == 7)
                    {
                        translate([ -_s, _sign * _s - thickness, -_l ])
                        {
                            cube([ _t, _2t, length ]);
                        }
                    }
                }
            }
        }
        cylinder(d = diameter, h = length + _epsilon, center = true);
        if (slots)
        {
            union()
            {
                for (_slot = slots)
                {
                    _sign   = _slot > 4 ? -1 : 1;
                    _offset = _sign * _s - thickness * (_slot > 4 ? 1.5 : 0.5);
                    if (_slot == 1 || _slot == 6)
                    {
                        translate([ _offset, -_s + thickness * 0.25, -_l + _epsilon ])
                        {
                            cube([ _2t, thickness, length ]);
                        }
                    }
                    else if (_slot == 2 || _slot == 5)
                    {
                        translate([ _offset, _s - thickness * 1.25, -_l + _epsilon ])
                        {
                            cube([ _2t, thickness, length ]);
                        }
                    }
                    else if (_slot == 3 || _slot == 8)
                    {
                        translate([ _s - thickness * 1.25, _offset, -_l + _epsilon ])
                        {
                            cube([ thickness, _2t, length ]);
                        }
                    }
                    else if (_slot == 4 || _slot == 7)
                    {
                        translate([ -_s + thickness * 0.25, _offset, -_l + _epsilon ])
                        {
                            cube([ thickness, _2t, length ]);
                        }
                    }
                }
            }
        }
    }
}
