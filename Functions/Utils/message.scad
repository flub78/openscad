/**
 * Muestra diversos mensajes realzados por la consola.
 * A pesar de ser módulos están dentro de funciones ya que no
 * renderizan contenido.
 *
 * @author  Joaquín Fernández
 * @license CC-BY-NC-4.0
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/Utils/message.scad
 */
/**
 * Muestra un mensaje HTML por la consola.
 *
 * @param {String} message Mensaje a mostrar.
 * @param {String} fgcolor Color del texto mensaje.
 * @param {String} bgcolor Color del fondo del texto mensaje.
 * @param {String} size    Tamaño del texto a usar.
 */
module utilsMessage(message, fgcolor = "black", bgcolor = "white", size = "20")
{
    echo(
        str(
            "<div style='background-color:", bgcolor, ";color:", fgcolor, ";font-weight:bold;font-size:", size, "px;'>",
                "------------------------------------------------",
                "<br />", message, "<br />",
                "------------------------------------------------",
            "</div>"
        )
    );
}
/**
 * Muestra un mensaje de error.
 *
 * @param {String} message Mensaje a mostrar.
 */
module utilsMessageError(message)
{
    utilsMessage(message, "red", "lightsalmon", 20);
}
/**
 * Muestra un mensaje de informativo.
 *
 * @param {String} message Mensaje a mostrar.
 */
module utilsMessageInfo(message)
{
    utilsMessage(message, "blue", "cyan", 15);
}
/**
 * Muestra un aviso.
 *
 * @param {String} message Mensaje a mostrar.
 */
module utilsMessageWarning(message)
{
    utilsMessage(message, "brown", "gold", 17);
}
