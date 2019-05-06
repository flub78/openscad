/**
 * Constantes usadas por los módulos y que no deberían tocarse salvo que se
 * sepa lo que se está haciendo.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Storage/Pringles/constants.scad
 * @license CC-BY-NC-4.0
 * @see     https://www.thingiverse.com/thing:3612377
 */
INNER      = 73;   // Diámetro interior del cilindro.
OUTER      = 77.7; // Diámetro exterior del cilindro.
LENGTH     = 35;   // Altura por defecto del cilindro.
THICKNESS  = 0.9;  // Grosor de las paredes del cilindro.
LID_HEIGHT = 6.6;  // Altura de la tapa plástica.
RADIUS     = 1.2;  // Radio del anillo de ajuste de la tapa
OFFSET     = 1.5;  // Distancia del borde al centro del anillo.

function getConstants() = [ INNER, OUTER, LENGTH, THICKNESS, LID_HEIGHT, RADIUS, OFFSET ];
