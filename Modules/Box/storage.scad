/**
 * Módulo para dibujar un bloque con huecos.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Box/storage.scad
 * @license CC-BY-NC-4.0
 */
//--------------------------------------------------------------------------
use <../../Functions/Array/sum.scad>
use <../../Functions/Array/fill.scad>
use <../../Functions/Utils/message.scad>
use <./rounded.scad>
//--------------------------------------------------------------------------
function calcTranslation(side, percents, index, thickness) = thickness
      + arraySum(percents, index - 1) * side
      + percents[index] * side / 2;
//--------------------------------------------------------------------------
/**
 * Dibujar un bloque con huecos.
 * Mediante el valor que se aplica al parámetro `radius` se pueden
 * obtener 3 funcionalidades diferentes:
 *
 * - Cero     : No se redondea ningún borde, ni externo ni interno.
 * - Negativo : Todos los bordes se redondean con el radio especificado.
 * - Positivo : Solamente se redondean los bordes externos y los 4 internos.
 *
 * @param width     Ancho del bloque (eje X).
 * @param height    Largo del bloque (eje Y).
 * @param length    Alto del bloque (eje Z).
 * @param radius    Radio del borde.
 * @param thickness Borde de las paredes.
 * @param rows      Número de huecos sobre el eje X.
 * @param cols      Número de huecos sobre el eje Y.
 */
module boxStorage(width, height, length, radius, thickness, rows, cols)
{
    _rows    = rows[0] == undef ? arrayFill(rows, 1 / rows) : rows;
    _cols    = cols[0] == undef ? arrayFill(cols, 1 / cols) : cols;
    _numRows = len(_rows);
    _numCols = len(_cols);
    _height  = height - thickness * (_numCols + 1);
    _width   = width  - thickness * (_numRows + 1);
    if (abs(arraySum(_rows, _numRows) - 1) > 1e9)
    {
        utilsMessageError("ERROR(boxStorage): SUM(rows) != 1.0");
    }
    if (abs(arraySum(_cols, _numCols) - 1) > 1e9)
    {
        utilsMessageError("ERROR(boxStorage): SUM(cols) != 1.0");
    }
    difference()
    {
        boxRounded(width, height, length, abs(radius));
        translate([ (thickness - width) / 2, (thickness - height) / 2, thickness ])
        {
            for (y = [ 1 : _numCols ])
            {
                for (x = [ 1 : _numRows ])
                {
                    translate([
                        calcTranslation(
                            _width,
                            _rows,
                            x - 1,
                            (x - 0.5) * thickness
                        ),
                        calcTranslation(
                            _height,
                            _cols,
                            y - 1,
                            (y - 0.5) * thickness
                        ),
                        0
                    ])
                    {
                        boxRounded(
                            _rows[x - 1] * _width,
                            _cols[y - 1] * _height,
                            length,
                            radius > 0
                                ? [
                                    x == 1        && y == 1        ? radius : 0,
                                    x == _numRows && y == 1        ? radius : 0,
                                    x == 1        && y == _numCols ? radius : 0,
                                    x == _numRows && y == _numCols ? radius : 0
                                ]
                                : radius < 0
                                    ? -radius
                                    : 0
                        );
                    }
                }
            }
        }
    }
}
