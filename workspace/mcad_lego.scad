use <MCAD/lego_compatibility.scad>

// Examples:
//   standard LEGO 2x1 tile has no pin
      block(1,2,1/3,reinforcement=false,flat_top=true);
//   standard LEGO 2x1 flat has pin
      translate([50, 0, 0]) block(1,2,1/3,reinforcement=true);
//   standard LEGO 2x1 brick has pin
	translate([100, 0, 0]) block(1,2,1,reinforcement=true);
//   standard LEGO 2x1 brick without pin
	 translate([0, 50, 0]) block(1,2,1,reinforcement=false);
//   standard LEGO 2x1x5 brick has no pin and has hollow knobs
	translate([50, 50, 0]) block(1,2,5,reinforcement=false,hollow_knob=true);

	translate([100, 50, 0]) block(2,4, 1,reinforcement=true,hollow_knob=true);

