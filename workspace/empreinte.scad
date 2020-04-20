// Un peigne pour prendre des empreintes
// 
// temps impression 10 min pour 4 x 10 mm

dia = 3;	// brochettes en bambou
n = 59;
height = 20;
$fn = 36;
wall = 1.5;
gap = 0.75;

// ============================================================================

bande();

// ============================================================================

module bande () {
	difference () {
		linear_extrude(height)
		hull() {
			circle(d = dia + 2 * wall);
			
			translate([n * (dia + gap), 0, 0])
			circle(d = dia + 2 * wall);
		}
		
		for (i = [0:n]) {
			translate([i* (dia + gap), 0, -0.1])
			cylinder(d = dia, h = height + 0.2);
		}

	}
}

