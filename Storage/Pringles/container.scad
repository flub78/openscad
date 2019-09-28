/**
 * Genera un contenedor para usarse con las tapas de las latas Pringles.
 *
 * En caso de no disponer de la tapa, se puede usar el módulo `lid` para generarla.
 *
 * También aporta diversos módulos para crear patrones rectangulares o concéntricos
 * a partir de figuras 2D o divisiones radiales.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Storage/Pringles/container.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3612377
 */
//---------------------------------------------------------------
use <../../Functions/Math/line.scad>
use <../../Modules/Box/rounded.scad>
use <../../Modules/Cylinder/arc.scad>
use <../../Modules/Shapes/concentric.scad>
use <../../Modules/Shapes/rectangular.scad>
use <./constants.scad>
//---------------------------------------------------------------
$fn        = $preview ? 90 : 240;
constants  = getConstants();
INNER      = constants[0];
OUTER      = constants[1];
LENGTH     = constants[2];
THICKNESS  = constants[3];
LID_HEIGHT = constants[4];
RADIUS     = constants[5];
OFFSET     = constants[6];
//---------------------------------------------------------------
/**
 * Dibuja la base del contenedor en 2D para que se extruya.
 *
 * @param {Float} length    Longitud del contenedor (eje Z).
 * @param {Float} thickness Grosor de las paredes del contenedor.
 */
module base(length = LENGTH, thickness = THICKNESS)
{
    _inner  = INNER / 2;
    _outer  = OUTER / 2;
    _i      = _inner - 0.5;
    _side   = _outer - _i;
    _b      = (OUTER - RADIUS - INNER) / 8;
    _h      = norm([ _b, _b ]);

    _p1     = [ _i, 0 ];
    _p2     = [ _outer, length ];
    _co     = [ _outer, _side ];
    _pa     = splice([ 0, 0 ], _co, _p1, _b, -1.08);
    _pb     = splice(_p1, _p2, _co, _b, -1.08);
    _points =  [
        _pa[0],
        _pa[1],
        _pa[2],
        _pb[0],
        _pb[1],
        _pb[2],
        [ _outer              , length - LID_HEIGHT - _b ], // 6
        [ _outer - _b         , length - LID_HEIGHT - _b ], // 7
        [ _outer - _b         , length - LID_HEIGHT      ], // 8
        [ _outer - RADIUS     , length - LID_HEIGHT      ], // 9
        [ _outer - RADIUS     , length - _b              ], // 10
        [ _outer - RADIUS - _b, length - _b              ], // 11
        [ _outer - RADIUS - _b, length                   ], // 12
        [ _inner              , length                   ], // 13
        [ _inner + _b         , length                   ], // 14
        [ _inner + _b         , length - _b              ], // 15
        [ _inner              , length - _b              ], // 16
        [ _inner              , thickness * 2            ], // 17
        [ 0                   , thickness * 2            ], // 18
        [ 0                   , 0                        ]  // 19
    ];
    polygon(points = _points);
    difference()
    {
        // Anillo para que la tapa ajuste.
        translate([ _outer - RADIUS, length - RADIUS - OFFSET ])
        {
            circle(r = RADIUS);
        }
        translate([ _inner - RADIUS, length - 2 * RADIUS - OFFSET ])
        {
            square([ RADIUS, 2 * RADIUS ]);
        }
    }
    for (_p = [ 1, 4, 7, 11, 15 ])
    {
        translate(_points[_p])
        {
            circle(r = _b);
        }
    }
}


/**
 * Dibuja el contenedor principal.
 *
 * @param {Float} length Longitud del contenedor (eje Z).
 */
module container(length = LENGTH)
{
    rotate_extrude(convexity = 10)
    {
        base(length);
    }
    translate([ 0, 0, 2 * THICKNESS ])
    {
        children();
    }
}

/**
 * Repite un forma 2D generando un patrón concéntrico centrado.
 *
 * @param {Float} length    Longitud del contenedor (eje Z).
 * @param {Float} plength   Longitud del patrón (eje Z).
 * @param {Float} width     Ancho de cada elemento (eje circular).
 * @param {Float} height    Altura de cada elemento (eje radial).
 * @param {Float} thickness Grosor de las paredes del patrón.
 * @param {Float} from      Radio inicial para empezar (eje radial).
 */
module conc(length = LENGTH, plength = 9.5, width = 10, height = 10, thickness = THICKNESS, from = 0)
{
    from2dChildren(length, plength, str("conc-", length, "x", plength, "-", width, "x", height))
    {
        concentric(INNER + 0.1, width, height, thickness, from)
        {
            if ($children)
            {
                children();
            }
            else
            {
                circle(d = min(width, height));
            }
        }
   }
}

/**
 * Genera un grupo de cilindros concéntricos.
 *
 * @param {Float} count     Cantidad de cilindros.
 * @param {Float} length    Longitud del contenedor (eje Z).
 * @param {Float} plength   Longitud del patrón (eje Z).
 * @param {Float} thickness Grosor de las paredes de cada cilindro.
 * @param {Float} sides     Cantidad de lados de cada arco.
 */
module cylinders(count = 2, length = LENGTH, plength = LENGTH - 2 * THICKNESS, thickness = 1.8, sides = 360)
{
    _r  = INNER / 2;
    _dr = (_r + thickness) / (count + 1);
    from2dChildren(length, plength, str("cyl-", length, "x", plength, "-", sides, "x", count))
    {
        difference()
        {
            circle(r = _r + 0.1);
            arcs(_dr, _r, thickness, $fn = sides);
        }
    }
}

/**
 * Genera el contenedor a partir de un patrón 2D pasado como hijo del módulo.
 *
 * @param {Float}  containerLength Longitud del contenedor (eje Z).
 * @param {Float}  childrenLength  Longitud a extruir el patrón 2D (eje Z).
 * @param {String} name            Nombre a asignar al archivo generado.
 */
module from2dChildren(containerLength = LENGTH, childrenLength = LENGTH / 2, name = "")
{
    if (name)
    {
        echo(str("Pringles-", name, ".stl"));
    }
    container(containerLength + 3 * THICKNESS)
    {
        difference()
        {
            cylinder(d = INNER + 0.1, h = childrenLength - 0.001);
            linear_extrude(childrenLength)
            {
                children();
            }
        }
    }
}

/**
 * Dibuja la tapa del contenedor si no se quiere usar la de
 * la lata de Pringles.
 */
module lid()
{
    _inner = INNER / 2;
    _outer = OUTER / 2;
    _r     = THICKNESS / 3;
    rotate_extrude(convexity = 10)
    {
        difference()
        {
            offset(r = -_r)
            {
                offset(delta = _r)
                {
                    translate([ 0, LENGTH ])
                    {
                        boxRounded2d(_outer, THICKNESS, [ 0, _r, 0, 0 ]);
                        translate([ _outer - THICKNESS, - LID_HEIGHT + _r ])
                        {
                            boxRounded2d(THICKNESS, LID_HEIGHT - _r, [ 0, 0, _r, _r ]);
                        }
                    }
                }
            }
            translate([ _outer - RADIUS - THICKNESS / 2, LENGTH - RADIUS - OFFSET ])
            {
                circle(r = RADIUS + 0.3);
            }
        }
    }
}

/**
 * Repite un forma 2D generando un patrón rectangular centrado.
 *
 * @param {Float} length    Longitud del contenedor (eje Z).
 * @param {Float} plength   Longitud del patrón (eje Z).
 * @param {Float} width     Ancho de cada elemento (eje X).
 * @param {Float} height    Altura de cada elemento (eje Y).
 * @param {Float} thickness Grosor de las paredes del patrón.
 */
module rect(length = LENGTH, plength = 9.5, width = 7.5, height = 6.9, thickness = THICKNESS)
{
    from2dChildren(length, plength, str("rect-", length, "x", plength, "-", width, "x", height))
    {
        rectangular(INNER + 0.1, width, height, thickness)
        {
            if ($children)
            {
                children();
            }
            else
            {
                square([ width, height ]);
            }
        }
    }
}

/**
 * Genera el texto a imprimir en el contenedor.
 *
 * @param {String} string Texto a imprimir.
 * @param {Float}  size   Tamaño de la fuente.
 * @param {String} valign Alineación vertical de las letras.
 * @param {Float}  z      Coordenada Z de la posición del texto.
 */
module title(string, size = 12, valign = "bottom", z = LENGTH - LID_HEIGHT - 3 * THICKNESS)
{
    _len    = len(string);
    _rad    = 3.1415927 / 180;
    _radius = OUTER / 2;
    _step   = size / _radius;
    rotate([ 0, 0, - 0.5 * _step * _len / _rad ])
    {
        for(_i = [ 0 : _len ])
        {
            rotate(_i * _step / _rad)
            {
                translate([0, _radius - THICKNESS / 2, z - size ])
                {
                    rotate([90, 0, 185])
                    {
                        linear_extrude(THICKNESS)
                        {
                            text(
                                string[_i],
                                size   = size,
                                valign = valign
                            );
                        }
                    }
                }
            }
        }
    }
}
//-----------------------------------------------------------------------------
// Contenedor
//-----------------------------------------------------------------------------
// Vacío:
// container(LENGTH);

// Generando cuadrados en un patrón rectangular:
// rect();

// Generando círculos en un patrón rectangular:
// rect(width = 9, height = 9) circle(d = 9);

// Generando cuadrados en un patrón rectangular:
// rect(length = 15, width = 9, height = 9) square(9, center = true);

// Generando cículos en un patrón concéntrico.
//conc();

// Generando hexágonos en un patrón concéntrico.
// conc(length = 15, width = 9, height = 9) circle(d = 9, $fn = 6);

// Generando cilindros concéntricos.
// cylinders(3);

//-----------------------------------------------------------------------------
// Tapa
//-----------------------------------------------------------------------------
// rotate([180, 0, 0])
// {
//     translate([ 0, 0, -LENGTH ])
//     {
//         lid();
//     }
// }
