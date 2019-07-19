use <../Array/join.scad>
/**
 * Construye el nombre del archivo STL generado.
 *
 * @author  Joaquín Fernández
 * @license CC-BY-NC-4.0
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Functions/Utils/stlName.scad
 *
 * @param {String} name Nombre del módulo que genera el modelo.
 * @param {Array}  args Argumentos de llamada del módulo.
 *
 * @return {String}
 */
function stlName(name, args) = str(
    "FILE: ",
    name,
    "(",
    arrayJoin([
        for (_a = args)
            is_list(_a)
                ? str("[#", len(_a), "#]")
                : str(_a)
    ]),
    ").stl"
);
