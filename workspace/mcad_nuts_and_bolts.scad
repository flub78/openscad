use <MCAD/nuts_and_bolts.scad>

translate([0,15]) # nutHole(size = 6, units="MM", tolerance = 0.5);
	
boltHole(size = 6, length=20,units="MM", tolerance = 0.5, $fn=72);