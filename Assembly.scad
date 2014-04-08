// assemble e-NABLE hand prosthetic components into a customized design.

/*

This program will assemble the components e-NABLE designs.

This first pass simply loads the parts and offsets them
from the 'random' origins so that the parts align for
viewing.

Next steps:
- For the STL files, get "no holes" versions.
- Then map the control points, and scale them .
- For the OpenSCAD files, modularize and integrate them.
- Then scale them.

Done:
- Add a 'selection' mechanism, so you can pick which gauntlet, palm, finger, options, etc.
- Add a set of measurements to drive the scaling (TBD).

Note that while parameters are commented using Customizer notation, this script won't work in Customizer because it includes STL files. For use in Customizer, the plan is to compile the STL files into OpenSCAD.

*/
// includes

include <Parametric_Gauntlet/David-Gauntlet.scad>
include <David-Finger/David-FingerProximal.scad>
include <David-Finger/David-FingerDistal2.scad>
include <Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Proximal Phalange 1.0.scad>
include <Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg FInger 1.0.scad>
include <Cyborg_Beast/OpenSCAD Files/cyborgbeast07e.scad>

/* [Hidden] */

// Constants to make code more readable
CyborgBeastFingers = 1;
DavidFingers = 2;
CyborgBeastPalm = 1;
CBParametricPalm = 2;

/* [Selectors] */

// Selectors

// Part to render/print
part = 0; //[0:Assembled, 1:Gauntlet, 2:Palm, 3:Finger Proximal, 4:Finger Distal, 5:Thumb Proximal, 6:Thumb Distal]

// Which finger design do you like
fingerSelect = CyborgBeastFingers; //[1:Cyborg Beast, 2:David]
// Which palm design do you like?
palmSelect = CBParametricPalm; //[1:Cyborg Beast, 2:Cyborg Beast Parametric]

/* [Full Arm Measurements] */

// Width of elbow (cm)
fElbowWidth = 6.267;
// Width of arm near elbow
fArm1 = 6.562;
// Width of arm middle
fArm2 = 5.914;
// Width of arm near wrist
fArm3 = 4.878;
// Width at wrist (base of thumb)
fWristWidth = 5.185;
// Base of thumb to base of pinkie
fKnuckleWidth = 7.252;
// Elbow to wrist
fArmLength = 23.06;
// Wrist to end of longest finger
fFingerLength = 13.64;
// Wrist to pinke first joint past knuckle
fJointLength = 7.223;

/* [Partial Arm Measurements] */

// Width of elbow (cm)
pElbowWidth = 6.647;
// Width of arm near elbow
pArm1 = 6.404;
// Width of arm middle
pArm2 = 4.695;
// Width of arm near wrist
pArm3 = 3.514;
// Width at wrist (base of thumb)
pWristWidth = 3.597;
// Elbow to wrist
pArmLength = 14.75;
// Wrist to end (Left)
pPalmLengthL = 2.727;
// Wrist to end (Middle)
pPalmLengthM = 3.180;
// Wrist to end (Right)
pPalmLengthR = 3.106;

/* [Parametric Gauntlet] */

// Parametric Gauntlet parameters
Print_Tuners=false;//default value true
Wrist_Width=50;
gauntletOffset = [-21, -7, -19];
Pivot_Screw_Size=M4;

// Offset for Cyborg Beast Parametric Palm

parametricPalmOffset = [-21.5,25.5,-18];

// offsets of Cyborg Beast finger to align to palm

fingerOffset = [-4, 59, -17];

// offset for David Finger to align to palm

davidFingerProximalOffset = [0,76,-19];
Scale_Factor=.8;

// offsets of proximal phalange to align to palm

phalangeOffset = [18, 53, -18];

// finger spacing

fingerSpacing = -14.5;

for (fX = [0:fingerSpacing:3*fingerSpacing]) {
	translate([fX, 0, 0]) {
		if (fingerSelect==CyborgBeastFingers) {
			translate(phalangeOffset)
				//import("Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Proximal Phalange 1.0.stl");
			CyborgProximalPhalange();
			translate(fingerOffset) rotate([0,180,0])
			//import("Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Finger 1.0.stl");
			CyborgFinger();
			}
		if (fingerSelect==DavidFingers) {
			translate(davidFingerProximalOffset)
				DavidFingerProximal();
//			translate(davidFingerProximalOffset)
//				DavidFingerDistal();
			}
		}
	}

if (palmSelect == CyborgBeastPalm) {
	import("Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Left Palm 1.0.stl");
	}

if (palmSelect == CBParametricPalm) {
	translate(parametricPalmOffset) CyborgBeastParametricPalm();
	}

//import("Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Thumb Finger 1.0.stl");
//import("Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Thumb Phalange 1.0.stl");

translate(gauntletOffset)
	rotate([0,0,-90]) DavidGauntlet();



