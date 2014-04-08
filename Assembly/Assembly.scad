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
- And add a 'selection' mechanism, so you can pick which gauntlet, palm, finger, options, etc.
- And add a set of measurements to drive the scaling (TBD).

Note that while parameters are commented using Customizer notation, this script won't work in Customizer because it includes STL files. For use in Customizer, the plan is to compile the STL files into OpenSCAD.

*/
// includes for each component. Note that STL components are represented by a simple OpenSCAD wrapper.

include <../Parametric_Gauntlet/David-Gauntlet.scad>
include <../David-Finger/David-FingerProximal.scad>
include <../David-Finger/David-FingerDistal2.scad>
include <Cyborg Proximal Phalange 1.0.scad>
include <Cyborg FInger 1.0.scad>
include <../Cyborg_Beast/OpenSCAD Files/cyborgbeast07e.scad>
include <CyborgLeftPalm.scad>

/* [Measurements] */
// See Measurement Guide at:
// https://docs.google.com/a/popk.in/document/d/1LX3tBpio-6IsMMo3aaUdR-mLwWdv1jS4ooeEHb79JYo for details.

//Length of Elbow Joint
Left1 = 0;
Right1 = 0;
//Distance between lateral and medial side of the forearm proximal to the elbow joint
Left2 = 0;
Right2 = 0;
//Distance between lateral and medial side of the middle forearm
Left3 = 0;
Right3 = 0;
//Distance between lateral and medial side of the forearm proximal to the wrist
Left4 = 0;
Right4 = 0;
//Wrist Joint distance from lateral to medial side
Left5 = 0;
Right5 = 0;
//Distance from wrist to distal end on thumb side (Lateral)
Left6 = 0;
Right6 = 0;
//Distance from wrist to distal middle end of effected hand
Left7 = 0;
Right7 = 0;
//Distance from Lateral and Medial sides of the distal part of the hand
Left8 = 0;
Right8 = 0;
//Distance from wrist to distal end on thumb side (Medial)
Left9 = 0;
Right9 = 0;
//Length of Elbow to wrist joint
Left10 = 0;
Right10 = 0;
//Hand flexion
LeftFlexion = 90;
RightFlexion = 90;
//Hand extension
LeftExtension = 90;
RightExtension = 90;

/* [Fixtures] */

// MM diameter of wrist bolt. M5=5.5, M3=3.3, etc.
WristBolt = 5.5;
// MM diameter of knuckle bolt. M5=5.5, M3=3.3, etc.
KnuckleBolt = 3.3;
// MM diameter of finger joint bolt. M5=5.5, M3=3.3, etc.
JointBolt = 3.3;
// MM diameter of thumb bolt. M5=5.5, M3=3.3, etc.
ThumbBolt = 3.3;

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
palmSelect = CyborgBeastPalm; //[1:Cyborg Beast, 2:Cyborg Beast Parametric]

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

if (part==0) assembled();
if (part==1) DavidGauntlet();
if (part==2) CyborgBeastParametricPalm();
if (part==3) CyborgProximalPhalange();
if (part==4) CyborgFinger();
//if (part==5) CyborgProximalPhalange();
//if (part==6) CyborgProximalPhalange();

module assembled() {

	for (fX = [0:fingerSpacing:3*fingerSpacing]) {
		translate([fX, 0, 0]) {
			if (fingerSelect==CyborgBeastFingers) {
				translate(phalangeOffset)
					CyborgProximalPhalange();
				translate(fingerOffset) rotate([0,180,0])
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
		CyborgLeftPalm();
		}

	if (palmSelect == CBParametricPalm) {
		translate(parametricPalmOffset) CyborgBeastParametricPalm();
		}

	//import("Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Thumb Finger 1.0.stl");
	//import("Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Thumb Phalange 1.0.stl");

	translate(gauntletOffset)
		rotate([0,0,-90]) DavidGauntlet();
	}


