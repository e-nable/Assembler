// assemble e-NABLE hand prosthetic components into a customized design.

/*

This program assembles the components from various e-NABLE designs, and scales and arranges them based on measurements.

Included designs:

- Assembler source is https://github.com/e-nable/e-NABLE-Assembler
- Cyborg Beast http://www.thingiverse.com/thing:261462 by JorgeZuniga, verson 1.4 by Marc Petrykowski 
- Creo version of Cyborg Beast http://www.thingiverse.com/thing:340750 by Ryan Dailey
- Parametric Gauntlet from http://www.thingiverse.com/thing:270259 by David Orgeman
- Cyborg Beast Short Gauntlet (Karuna's Gauntlet) http://www.thingiverse.com/thing:270322 by Frankie Flood 
- Parametric Finger v2  http://www.thingiverse.com/thing:257544 by David Orgeman

Note that while parameters are commented using Customizer notation, this script won't work in Customizer because it includes STL files. For use in Customizer, the plan is to compile the STL files into OpenSCAD.

Done:
- Then map the control points, and scale them .
- For the OpenSCAD files, modularize and integrate them.
- Then scale them.
- And add a 'selection' mechanism, so you can pick which gauntlet, palm, finger, options, etc.
- And add a set of measurements to drive the scaling (TBD).
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
include <CreoCyborgLeftPalm.scad>
include <Creo Cyborg Finger.scad>
include <Creo Cyborg Proximal Phalange.scad>
include <CyborgThumbPhalange.scad>
include <CreoCyborgThumbPhalange.scad>
include <CyborgThumbFinger.scad>
include <CreoCyborgThumbFinger.scad>
include <KarunaGauntlet.scad>
include <ModelArm.scad>

/* [Selectors] */

// Selectors

// Part to render/print
part = 0; //[0:Assembled, 1:Gauntlet, 2:Palm, 3:Finger Proximal, 4:Finger Distal, 5:Thumb Proximal, 6:Thumb Distal]

// Which finger design do you like
fingerSelect = 1; //[1:Cyborg Beast, 2:David, 3:Creo Cyborg Beast]
// Which palm design do you like?
palmSelect = 1; //[1:Cyborg Beast, 2:Cyborg Beast Parametric, 3:Creo Cyborg Beast]
gauntletSelect = 1; //[1:Parametric Gauntlet, 2:Karuna Short Gauntlet]

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
Left9 = 31.05;
Right9 = 72.23;
//Length of Elbow to wrist joint
Left10 = 147.5;
Right10 = 230.6;
//Hand flexion
LeftFlexion = 90;
RightFlexion = 90;
//Hand extension
LeftExtension = 90;
RightExtension = 90;
// Padding thickness (mm) between hand and parts
padding = 5;

// Which hand is the prosthetic for?
prostheticHand=0; // [0:Left, 1:Right]

// pack in arrays to pass around more easily. 
// e,g, Left4 = measurements[0][4], Right9 = measurements[1][9].
// measurements[0][0] is the prosthetic hand, measurements[1][0] is the other one.

measurements = [[prostheticHand, Left1, Left2, Left3, Left4, Left5, Left6, Left7, 
		Left8, Left9, Left10, LeftFlexion, LeftExtension],
	[1-prostheticHand, Right1, Right2, Right3, Right4, Right5, Right6, Right7, 
		Right8, Right9, Right10, RightFlexion, RightExtension]];

echo("Measurements: left", measurements[0]);
echo("Measurements: right", measurements[1]);

/* [Fixtures] */

// MM diameter of wrist bolt. M5=5.5, M3=3.3, etc.
WristBolt = 5.5;
// MM diameter of knuckle bolt. M5=5.5, M3=3.3, etc.
KnuckleBolt = 3.3;
// MM diameter of finger joint bolt. M5=5.5, M3=3.3, etc.
JointBolt = 3.3;
// MM diameter of thumb bolt. M5=5.5, M3=3.3, etc.
ThumbBolt = 3.3;

/* [Label] */

label="http://eNABLE.us/NCC1701/1";
font="Letters.dxf";

/* [Hidden] */

// Constants to make code more readable
CyborgBeastFingers = 1;
DavidFingers = 2;
CyborgBeastPalm = 1;
CBParametricPalm = 2;

// Calculations

//echo("in Assembly scale ",scale," scaleW ",scaleW);

fullHand = 1-prostheticHand;
// so we can use array references, like measurement[fullHand][0].

// width of wrist on prosthetic hand
targetWidth = measurements[prostheticHand][5]+2*padding+10; // outside of gauntlet
//echo("wrist width ",targetWidth);
Wrist_Width=targetWidth-10; // assume gauntlet is 5mm thick (2 sides)
//echo("gauntlet width ",Wrist_Width);
Wrist_Width=55;
gauntletWScale = (targetWidth-10)/Wrist_Width;
//echo("David gauntlet width scale ",gauntletWScale);

//%cube([55,5,5], center=true);

/* [Parametric Gauntlet] */

// Parametric Gauntlet parameters
Print_Tuners=false;//default value true
gauntletOffset = [0, -8, -4];
Pivot_Screw_Size=M4;

// Offset for Cyborg Beast Parametric Palm

parametricPalmOffset = [-21.5,25.5,-18];

// offsets of Cyborg Beast finger to align to palm

fingerOffset = [15, 58,-4];

// offset for David Finger to align to palm

davidFingerProximalOffset = [20,74,-6];
davidFingerDistalOffset = [20,74+38,3];
Scale_Factor=.8;

// offsets of proximal phalange to align to palm 

phalangeOffset = [38, 52, -5];

// finger spacing

// compute the control points.
//
// wristControl = center of wrist
// knuckleControl = center of knuckles
// elbowControl = end of elbow
// tipControl = center of fingertips

//echo(measurements[prostheticHand]);

wristControl = [0,0,0];
palmLen = measurements[fullHand][9];
//echo("Palm len ", palmLen);
armLen = measurements[prostheticHand][10];
//echo("Arm len ", armLen);
knuckleControl = [0,palmLen,0];
elbowControl = [0,-armLen,0];

//echo("Wrist control ",wristControl);
//echo("Knuckle control ", knuckleControl);
//echo("Elbow control ", elbowControl);

targetLen = knuckleControl[1]-wristControl[1];
//echo("In Assembly target len is ",targetLen);
targetWidth = measurements[prostheticHand][5]+2*padding+10;
//echo("In Assembly target width is ",targetWidth);

CBscale = CBScaleLen(targetLen);
CBscaleW = CBScaleWidth(targetWidth);
CCBscale = CCBScaleLen(targetLen);
CCBscaleW = CCBScaleWidth(targetWidth);

//echo("in Assembly scale ",scale," scaleW ",scaleW);

// Thumb position and angle for cyborg beast
//thumbControl = [/*62.5-22.7*/ 39.8,13.5,0]; // location of thumb hinge
thumbControl = [40,18+.5,2-3]; // location of thumb hinge for Creo palm
thumbRotate = [0,13+5,-90]; // angle of thumb hinge for Creo palm

fingerSpacing = 14.5;
//fingerSpacing = targetWidth / 3;
//echo("FINGER SPACING ",fingerSpacing);

// draw what's asked for

scale([1-2*prostheticHand,1,1]) { // mirrors left/right

if (part==0) assembled(CBscale, CBscaleW, CCBscale, CCBscaleW); // Complete assembly of all parts, for preview.

if (part==1) { // Gauntlet. Make a sequence of ifs when there are more models. ADD GAUNTLETS HERE
	if (gauntletSelect==1) scale([gauntletWScale,1,1]) DavidGauntlet();
	if (gauntletSelect==2) KarunaGauntlet();
	}

if (part==2) { // Palms
	if (palmSelect == CyborgBeastPalm) {
		echo("cyborg beast palm len scale "+scale*100+"% width scale "+scaleW*100+"%.");
		CyborgLeftPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font);
		}
	if (palmSelect == CBParametricPalm) {
		echo("cyborg parametric palm");
		CyborgBeastParametricPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font);
		}
	if (palmSelect == 3) {
		echo("Creo cyborg beast palm");
		CreoCyborgLeftPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font);
		}
	// ADD PALMS HERE
	}

if (part==3) { // Finger Proximals
	scale([scaleW,scale,scale]) {
		if (fingerSelect==CyborgBeastFingers) 
			scale([CBscaleW,CBscale,CBscale]) CyborgProximalPhalange();
		if (fingerSelect==DavidFingers) DavidFingerProximal();
		if (fingerSelect==3) 
			scale([CCBscaleW,CCBscale,CCsBscale]) CreoCyborgProximalPhalange();
	// ADD FINGER PROXIMALS HERE
		}
	}
if (part==4) { // Finger Distals
		if (fingerSelect==CyborgBeastFingers) 
			scale([CBscaleW,CBscale,CBscale]) CyborgFinger();
		if (fingerSelect==DavidFingers) DavidFingerDistal();
		if (fingerSelect==3) 
			scale([CCBscaleW,CCBscale,CCBscale]) rotate([0,180,0]) CreoCyborgFinger();
		// ADD FINGER DISTALS HERE
	}
if (part==5) scale([scaleW,scale,scale]) CyborgThumbPhalange();
if (part==6) scale([scaleW,scale,scale]) rotate([0,180,0]) CyborgThumbFinger();
}

// Draw all of the parts. Like above but translating to appropriate positions.

module assembled(CBscale, CBscaleW, CCBscale, CCBscaleW) {
	// scaling for selected palm
	scaleW = palmSelect==1? CBscaleW : CCBScaleW;
	scale = palmSelect==1? CBscale : CCBScale;

	//%showControlPoints();
	// Four Fingers
	//echo("FINGERS");
	//echo(fingerSpacing);
	translate(knuckleControl) {
		//sphere(10); // check knuckle position
		for (fX = [-1.5:1:1.5]) {
			translate([fX*fingerSpacing*scaleW, 0, 0]) {
				if (fingerSelect==CyborgBeastFingers) {
					echo("beast fingers scale ",str(scale*100),"% scale width ",scaleW*100,"%.");
					//sphere(10);
					//translate(phalangeOffset)
					scale([CBscaleW,CBscale,CBscale]) CyborgProximalPhalange();
					//translate(fingerOffset) 
					translate([0,22*scale,0]) 
					rotate([0,180,0])
						scale([CBscaleW,CBscale,CBscale]) CyborgFinger();
					}
				if (fingerSelect==DavidFingers) {
					echo("david fingers");
					translate(davidFingerProximalOffset)
						scale([scaleW,scale,scale]) DavidFingerProximal();
					translate(davidFingerDistalOffset)
						scale([scaleW,scale,scale]) rotate([0,180,90]) DavidFingerDistal();
					}
				if (fingerSelect==3) {
					echo("Creo beast fingers scale ",scale*100,"% scale W ",scaleW*100,"%.");
					scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgProximalPhalange();
					translate([0,29*CCBscale,0]) scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgFinger();
					}
				// ADD FINGERS HERE
				}
			}
		}

	if (palmSelect == CyborgBeastPalm) {
		//echo("cyborg beast palm");
		CyborgLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font);
		}

	if (palmSelect == CBParametricPalm) {
		echo("cyborg beast parametric palm");
		CyborgBeastParametricPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font);
		}
	if (palmSelect == 3) {
		echo("Creo cyborg beast palm");
		CreoCyborgLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font);
		}
	// ADD PALMS HERE

   // For the cyborg beast palm the thumb is here:

	thPhalangeLen = thumbPhalangeLen; // from import

	translate([thumbControl[0]*scaleW,thumbControl[1],thumbControl[2]]) rotate(thumbRotate) {
		if (fingerSelect==3) {
			CreoCyborgThumbPhalange();
			translate([0,thPhalangeLen,0]) scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgThumbFinger();
			}
		else if (fingerSelect==1) {		
			CyborgThumbPhalange();
			translate([0,thPhalangeLen,0]) scale([CBscaleW,CBscale,CBscale]) CyborgThumbFinger();
			}
		}

	if (gauntletSelect==1)
		scale([gauntletWScale*1.03,1,1]) translate(gauntletOffset) rotate([0,0,-90]) DavidGauntlet();
	if (gauntletSelect==2) KarunaGauntlet(measurements, padding);
	// ADD GAUNTLETS HERE

	%ModelArm(measurements);
	//showControlPoints();
	}

module showControlPoints() {
	translate(wristControl) color("yellow") sphere(5);
	translate(knuckleControl) color("blue") sphere(5);
	translate(elbowControl) color("green") sphere(5);
	translate(thumbControl) color("red") sphere(5);
	}

