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


//Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/CyborgLeftPalm.scad

include <../Parametric_Gauntlet/David-Gauntlet.scad>
include <../david-Finger/David-FingerProximal.scad>
include <../david-Finger/David-FingerDistal2.scad>
include <Cyborg Proximal Phalange 1.0.scad>
include <Cyborg Finger 1.0.scad>
include <../Cyborg_Beast/OpenSCAD Files/cyborgbeast07e.scad>
include <CyborgLeftPalm.scad>

/* [Measurements] */
// See Measurement Guide at:
// https://docs.google.com/a/popk.in/document/d/1LX3tBpio-6IsMMo3aaUdR-mLwWdv1jS4ooeEHb79JYo for details.
// The default values are the ones from the photo in that document.

//Length of Elbow Joint (mm)
Left1 = 66.47;
Right1 = 62.67;
//Distance between lateral and medial side of the forearm proximal to the elbow joint
Left2 = 64.04;
Right2 = 65.62;
//Distance between lateral and medial side of the middle forearm
Left3 = 46.35;
Right3 = 59.14;
//Distance between lateral and medial side of the forearm proximal to the wrist
Left4 = 35.14;
Right4 = 48.78;
//Wrist Joint distance from lateral to medial side
Left5 = 35.97;
Right5 = 51.85;
//Distance from wrist to distal end on thumb side (Lateral)
Left6 = 31.05;
Right6 = 0;
//Distance from wrist to distal middle end of effected hand
Left7 = 31.80;
Right7 = 0;
//Distance from Lateral and Medial sides of the distal part of the hand
Left8 = 40.97;
Right8 = 72.52;
//Distance from wrist to distal end on thumb side (Medial)
Left9 = 0;
Right9 = 136.4;
//Length of Elbow to wrist joint
Left10 = 147.5;
Right10 = 230.6;
//Hand flexion
LeftFlexion = 90;
RightFlexion = 90;
//Hand extension
LeftExtension = 90;
RightExtension = 90;

// pack in arrays to pass around more easily

measurements = [[Left1, Left2, Left3, Left4, Left5, Left6, Left7, 
		Left8, Left9, Left10, LeftFlexion, LeftExtension],
	[Right1, Right2, Right3, Right4, Right5, Right6, Right7, 
		Right8, Right9, Right10, RightFlexion, RightExtension]];

echo("Measurements: left");
echo(measurements[0]);
echo("Measurements: right");
echo(measurements[1]);

// Which hand is the prosthetic for?
prostheticHand=0; // [0:Left, 1:Right]

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

// Calculations

fullHand = 1-prostheticHand;
// so we can use array references, like measurement[fullHand][0].

/* [Selectors] */

// Selectors

// Part to render/print
part = 0; //[0:Assembled, 1:Gauntlet, 2:Palm, 3:Finger Proximal, 4:Finger Distal, 5:Thumb Proximal, 6:Thumb Distal]

// Which finger design do you like
fingerSelect = CyborgBeastFingers; //[1:Cyborg Beast, 2:David]
// Which palm design do you like?
palmSelect = 1; //[1:Cyborg Beast, 2:Cyborg Beast Parametric]

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

// compute the control points.
//
// wristControl = center of wrist
// knuckleControl = center of knuckles
// elbowControl = end of elbow
// tipControl = center of fingertips

echo(measurements[prostheticHand]);

wristControl = [0,0,0];
palmLen = measurements[prostheticHand][6];
echo("Palm len ", palmLen);
armLen = measurements[prostheticHand][9];
echo("Arm len ", armLen);
knuckleControl = [0,palmLen,0];
elbowControl = [0,-armLen,0];

echo("Wrist control ",wristControl);
echo("Knuckle control ", knuckleControl);
echo("Elbow control ", elbowControl);

showControlPoints();

fingerSpacing = -14.5;

if (part==0) assembled();
if (part==1) DavidGauntlet();
if (part==2) {
	if (palmSelect == CyborgBeastPalm) {
		echo("cyborg beast palm");
		CyborgLeftPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl);
		}
	if (palmSelect == CBParametricPalm) {
		echo("cyborg parametric palm");
		CyborgBeastParametricPalmAssembled(assemble=false, wrist=wristControl, knuckle=knuckleControl);
		}
	}

if (part==3) CyborgProximalPhalange();
if (part==4) CyborgFinger();
// add parts here as they're integrated into the model
// and add logic to honor selection

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
		echo("cyborg beast palm");
		CyborgLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl);
		}

	if (palmSelect == CBParametricPalm) {
		echo("cyborg beast parametric palm");
		CyborgBeastParametricPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl);
		}

	//import("Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Thumb Finger 1.0.stl");
	//import("Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Thumb Phalange 1.0.stl");

	translate(gauntletOffset)
		rotate([0,0,-90]) DavidGauntlet();

	showControlPoints();

	%previewArm(measurements, prostheticHand);
	}

module showControlPoints() {
	%translate(wristControl) color("yellow") sphere(5);
	%translate(knuckleControl) color("blue") sphere(5);
	%translate(elbowControl) color("green") sphere(5);
	}

module previewArm(measurements, hand) {
	// Can someone write this? That is, display the arm and fingers based on the measurements.
	}


// Wrapper class for CyborgBeastParametricPalm, aligns and configures to measurements
// Align palm to wrist and palm control points:
//module CyborgBeastParametricPalmAssembled(wrist, knuckle, measurements, prostheticHand) {
//	//translate(parametricPalmOffset)
//	CyborgBeastParametricPalm();
//	}