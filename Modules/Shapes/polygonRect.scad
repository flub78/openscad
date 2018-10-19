use <../../Functions/Utils/message.scad>
/**
 * Dibuja un rectángulo con polígonos inscritos para disminuir la 
 * cantidad de filamente a usar. Se recomienda que el polígono no
 * genere lados con menos de 45º.
 *
 * @param width   Ancho del rectángulo
 * @param height  Altura del rectángulo
 * @param depth   Grosor del rectángulo
 * @param sides   Cantidad de lados del polígono a inscribir. Por defecto es un octágono.
 * @param xMargin Margen a dejar entre el círculo y el borde horizontal.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Shapes/polygonRect.scad
 * @license CC-BY-NC-4.0
 */
module polygonRect(width, height, depth, sides = 8, xMargin = 2)
{
    _diameter = width - xMargin * 2;
    if (_diameter > 0)
    {
        difference()
        {
            cube(
                size   = [ width, height, depth ],
                center = true
            );
            _numShapes = floor((height - depth * 2) / _diameter);
            if (_numShapes > 0)
            {
                _yMargin = height / (_numShapes * 2);
                translate([ 0, height / 2 + _yMargin, 0 ])
                {
                    for (_y = [ 1 : _numShapes ])
                    {
                        translate([ 0, - _y * (2 * _yMargin), 0 ])
                        {
                            cylinder(
                                d      = _diameter, 
                                h      = depth, 
                                center = true, 
                                $fn    = sides
                            );
                        }
                    }
                }
            }
            else
            {
                utilsMessageError("ERROR[polygonRect]: Proporción entre `height` y `width` no permite dibujar el polígono dentro del rectángulo.");
            }
        }
    }
    else
    {
        utilsMessageError("ERROR[polygonRect]: El margen es muy grande");
    }
}
