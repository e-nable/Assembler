// assemble Cyborg Beast components

/*

This program will assemble the components of the 
Cyborg Beast. The components will be "no holes" 
versions of the STL files, with origin at the center of the back joint, and it will scale and position the
parts based on measurements.

This first pass simply loads the parts and offsets them
from the 'random' origins so that the parts align for
viewing.

*/

include <../../Parametric_Gauntlet/David-Gauntlet.scad>

// offsets of finger to align to palm

fingerX = -4;
fingerY = 59;
fingerZ = -17;

// offsets of proximal phalange to align to palm

phalangeX = 18;
phalangeY = 53;
phalangeZ = -18;

// finger spacing

fingerSpacing = -14.5;

// Gauntlet parameters

gauntletX = -21;
gauntletY = -7;
gauntletZ = -18.5;
gauntletScale = .83;

echo(fingerX,fingerSpacing,fingerX+3*fingerSpacing);
for (fX = [fingerX:fingerSpacing:fingerX+3*fingerSpacing]) {
	translate([phalangeX-fingerX+fX, phalangeY, phalangeZ]) 
		import("../STL Files/STL Files (Marc Petrykowsk)/Cyborg Proximal Phalange 1.0.stl");
	translate([fX, fingerY, fingerZ]) rotate([0,180,0]) 
		import("../STL Files/STL Files (Marc Petrykowsk)/Cyborg Finger 1.0.stl");
	}

import("../STL Files/STL Files (Marc Petrykowsk)/Cyborg Left Palm 1.0.stl");
//import("../STL Files/STL Files (Marc Petrykowsk)/Cyborg Thumb Finger 1.0.stl");
//import("../STL Files/STL Files (Marc Petrykowsk)/Cyborg Thumb Phalange 1.0.stl");

translate([gauntletX, gauntletY, gauntletZ]) 
	scale(gauntletScale)
		rotate([0,0,-90]) DavidGauntlet();



