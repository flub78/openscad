/**
 * Genera topes para usarlos en las mesas de trabajo Wolfcraft
 * aunque pueden ajustarse las medidas para trabajar con 
 * cualquier marca.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Tools/WolfcraftStops.scad
 * @license CC-BY-NC-4.0
 */
//------------------------------------
use <../Modules/pinTab.scad>
//------------------------------------
$fn = 250;
pinTab(
    diameter  = 20.1,
    tabLength = 0.9,
    pinLength = 18.9,
    thickness = 0.6,
    angles    = []
);