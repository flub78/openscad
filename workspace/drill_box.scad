/*
 * Drill box
 */
 
$fn = 72;
 
slack = 0.5;   // mechanical clearance
space = 1.0;     // space between drills
wall = 1.5;

bds = [
	[ 7, 110],
    [ 7.5, 113 ],
    [ 8, 116 ],
    [  8.5, 118 ],
    [ 9, 126 ],
    [ 9.5, 126 ],
	[ 10, 133 ],
];

sds = [
    [ 1, 33 ],
    [ 1.5, 38 ],
    [ 2, 48 ],
    [ 2.5, 56 ],
    [ 3, 60 ],
    [ 3.5, 70 ],
    [ 4, 74 ],
    [ 4.5, 80],
	[ 5, 85 ],
	[ 5.5, 93],
	[ 6, 93],
	[ 6.5, 101 ]
];
all = [
    [ 1, 33 ],
    [ 1.5, 38 ],
    [ 2, 48 ],
    [ 2.5, 56 ],
    [ 3, 60 ],
    [ 3.5, 70 ],
    [ 4, 74 ],
    [ 4.5, 80],
	[ 5, 85 ],
	[ 5.5, 93],
	[ 6, 93],
	[ 6.5, 101 ],
	[ 7, 110],
    [ 7.5, 113 ],
    [ 8, 116 ],
    [  8.5, 118 ],
    [ 9, 126 ],
    [ 9.5, 126 ],
	[ 10, 133 ],
];

/*
 * Cumulated size of the drills 
 * d = [[diameter, length], ...]
 * i : index in the list
 */
function sigma(d, i) =
	(i == 0 ? d[i][0] : d[i][0] + sigma(d, i - 1));

/*
 * Max diameter
 */ 
function max_dia (d, i) =
	(i == 0) ? d[i][0] : max(d[i][0], max_dia (d, i-1)) ;

/*
 * Max length
 */
function max_len (d, i) =
	(i == 0) ? d[i][1] : max(d[i][1], max_len (d, i-1)) ;

/*
 * Smallest length
 */ 
function min_len (d, i) =
	(i == 0) ? d[i][1] : min(d[i][1], min_len (d, i-1)) ;

height = 35;


/**
 * Generate the box for the drills
 */
module box (dr) {
	len = len(dr); 
	length = sigma(dr, len - 1) + wall * 2 + space * len;
	width = max_dia(dr, len - 1) + 2 * wall;
	height = 25;
	
	echo ("box elt=", len);
	echo ("max_dia", max_dia(dr, len -1));
	echo ("sigma_dia", sigma(dr, len -1));
	echo ("length=", length);

	difference () {
		color("red")
		cube([length, width, height]);

		// holes
		for (i = [0: len -1]) {
			// echo ("translate: ",wall + sigma(dr, i) - dr[i][0] / 2 + space * i);
			translate ([wall + sigma(dr, i) - dr[i][0] / 2 + space * i, width/2, wall])
				# cylinder(dr[i][1], d= dr[i][0] + slack);
		}		
	}
	
	// The base
	base_width = 2 * wall;
	base_height = 2 * wall;
	translate([-(base_width + slack), -(base_width + slack), 0])
		cube([length + 2 * (base_width + slack), width + 2 * (base_width + slack), base_height]);
}

/**
 * Generate the box for the drills
 */
module top (dr) {
	len = len(dr) ;
	length = sigma(dr, len - 1) + wall * 2 + space * len;
	width = max_dia(dr, len - 1) + 2 * wall;
	height = max_len(dr, len - 1);

	ext_len = length + 2 * (wall + slack);
	ext_width = width + 2 * (wall + slack);
	ext_height = height + wall + slack;
	
	difference() {
		color("green")
		translate ([- (wall + slack), - (wall + slack), wall])
		cube ([ext_len, ext_width, ext_height]);
		
		translate ([-slack / 2, -slack / 2, 0])
		cube([length + slack, width + slack, height]);
	}
	
	// holes
	for (i = [0: len -1]) {
		// echo ("translate: ",wall + sigma(dr, i) - dr[i][0] / 2 + space * i);
		// translate ([wall + sigma(dr, i) - dr[i][0] / 2 + space * i, width/2, wall + height - (height - dr[i][1]) + slack])
		translate ([wall + sigma(dr, i) - dr[i][0] / 2 + space * i, 
			width/2, 
			wall + height - (height - dr[i][1]) + slack - dr[i][1]/ 2 + height / 2])
		cube([dr[i][0] + space, width + slack, height - dr[i][1]], center=true);
		// cylinder(height - dr[i][1], d= dr[i][0] + slack);
	}
}

/**
 * a top easier to open
 */
module top_plus (dr) {
	
	len = len(dr); 
	length = sigma(dr, len - 1) + wall * 2 + space * len;
	width = max_dia(dr, len - 1) + 2 * wall;
	height = 25;
	height = max_len(dr, len - 1);
	
	difference () {
		top(dr);
		
		// cut half cylinder
		translate([length / 2, 0, 0])
		rotate([90, 0, 0])
		cylinder(h = width * 4, d = 30, center = true);
		
		// cut off the corner
		translate([0,0, height])
		rotate([0, -45, 0])
		cube([length * 2, width * 4, 40], center=true);
	}
}

box(all);
color("yellow", alpha = 0.6) top_plus (all);
