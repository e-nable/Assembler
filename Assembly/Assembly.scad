// assemble e-NABLE hand prosthetic components into a customized design.

/*

This program assembles the components from various e-NABLE designs, and scales and arranges them based on measurements.

    Copyright (C) 2014, Laird Popkin

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
include <../Cyborg_Beast/OpenSCAD Files/cyborgbeast07e.scad>
include <Cyborg Proximal Phalange 1.0.scad>
include <Cyborg Finger 1.0.scad>
include <CyborgLeftPalm.scad>
include <CreoCyborgLeftPalm.scad>
include <Creo Cyborg Finger.scad>
include <Creo Cyborg Proximal Phalange.scad>
include <CyborgThumbPhalange.scad>
include <CyborgNTLeftPalm.scad>
include <CreoCyborgThumbPhalange.scad>
include <CyborgThumbFinger.scad>
include <CreoCyborgThumbFinger.scad>
include <KarunaGauntlet.scad>
include <ModelArm.scad>

/* [Selectors] */

// Selectors

// Part to render/print
part = 0; //[0:Assembled, 1:Gauntlet, 2:Palm, 3:Finger Proximal, 4:Finger Distal, 5:Thumb Proximal, 6:Thumb Distal]
echo("part ",part);

//echo("LABEL Part to render/print");
//echo("PARAM part = 0; //[0:Assembled, 1:Gauntlet, 2:Palm, 3:Finger Proximal, 4:Finger Distal, 5:Thumb Proximal, 6:Thumb Distal]");

// Which finger design do you like
fingerSelect = 1; //[1:Cyborg Beast, 2:David, 3:Creo Cyborg Beast]
echo("fingerSelect ",fingerSelect);

// Which palm design do you like?
palmSelect = 4; //[1:Cyborg Beast, 2:Cyborg Beast Parametric, 3:Creo Cyborg Beast, 4:Cyborg Beast with Thumb Cutout]
echo("palmSelect ",palmSelect);

//echo("LABEL Which palm design do you like?");
//echo("PARAM palmSelect = 4; //[1:Cyborg Beast, 2:Cyborg Beast Parametric, 3:Creo Cyborg Beast, 4:Cyborg Beast with Thumb Cutout]");

gauntletSelect = 2; //[1:Parametric Gauntlet, 2:Karuna Short Gauntlet]
echo("gauntletSelect ",gauntletSelect);

/* [Measurements] */
// See Measurement Guide at:
// https://docs.google.com/a/popk.in/document/d/1LX3tBpio-6IsMMo3aaUdR-mLwWdv1jS4ooeEHb79JYo for details.
// The default values are the ones from the photo in that document.

// Note that only the full hand palm length (L/R9) and full hand knuckle width (L/R8) are 
// required and used for scaling static designs. The remaining measurements are available for
// use in more sophisticated parametric designs.

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
LeftFlexion = 0;
RightFlexion = 0;
//Hand extension
LeftExtension = 0;
RightExtension = 0;
// Padding thickness (mm) between hand and parts
padding = 5;

// Which hand is the prosthetic for?
prostheticHand=0; // [0:Left, 1:Right for mirroring hand]
echo("prosthetic hand ",prostheticHand);

pHand = prostheticHand;

// pack in arrays to pass around more easily.
// e,g, Left4 = measurements[0][4], Right9 = measurements[1][9].
// measurements[0][0] is the prosthetic hand, measurements[1][0] is the other one.

measurements = [[pHand, Left1, Left2, Left3, Left4, Left5, Left6, Left7, 
		Left8, Left9, Left10, LeftFlexion, LeftExtension],
	[1-pHand, Right1, Right2, Right3, Right4, Right5, Right6, Right7, 
		Right8, Right9, Right10, RightFlexion, RightExtension]];

//Comment out except when testing code:

measurements = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],[1, 0, 0, 0, 0, 55, 0, 0, 55, 71, 0, 0, 0]];

echo("Measurements: prosthetic", measurements[0]);
echo("Measurements: full", measurements[1]);

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

label="http://webapp.e-NABLE.me/";
font="Letters.dxf";

/* [Hidden] */

// Constants to make code more readable
CyborgBeastFingers = 1;
DavidFingers = 2;
CyborgBeastPalm = 1;
CBParametricPalm = 2;

// Calculations

// true if we should print a thumb, false if not. This logic will
// change as we add more designs

haveThumb = palmSelect != 4;

//echo("in Assembly scale ",scale," scaleW ",scaleW);

fullHand = 1-pHand;

// so we can use array references, like measurement[fullHand][0].

//Wrist_Width=55;
//gw = 0+(targetWidth-10)/55;
//echo("gauntlet width scale ",gw," for target ",targetWidth," wrist ", Wrist_Width," or ",(targetWidth-10)/Wrist_Width);

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

//echo(measurements[pHand]);

wristControl = [0,0,0];
palmLen = measurements[fullHand][9];
//echo("Palm len ", palmLen);
armLen = measurements[pHand][10];
//echo("Arm len ", armLen);
knuckleControl = [0,palmLen,0];
elbowControl = [0,-armLen,0];

//echo("Wrist control ",wristControl);
//echo("Knuckle control ", knuckleControl);
//echo("Elbow control ", elbowControl);

targetLen = knuckleControl[1]-wristControl[1]+padding;
//echo("In Assembly target len is ",targetLen);
targetWidth = measurements[fullHand][8]+padding;
//echo("In Assembly target width is ",targetWidth);

// note that we have to compute all design's scaling factors so that we can scale both the palm an the fingers
// e,g, scale the cyborg beast palm by CBScale, and scale fingers from the Creo Cyborg Beast at CCBscale.

// XXXscale is the length scale (also used for height)
// YYYscaleW is the width scale

// TODO: make this a function of each design

// compute cyborg beast palm scaling
CBscale = CBScaleLen(targetLen);
CBscaleW = CBScaleWidth(targetWidth);
// compute creo cyborg beast scaling
CCBscale = CCBScaleLen(targetLen);
CCBscaleW = CCBScaleWidth(targetWidth);

// set scales based on selected palm. 
// As there are more models, this expression is going to get ugly

scale = (palmSelect==1)||(palmSelect==4)? CBscale : CCBscale;
scaleW =(palmSelect==1)||(palmSelect==4)? CBscaleW : CCBscaleW*1.27;

echo("in Assembly CD scale ",CBscale,CBscaleW," CCB scale ",CCBscale,CCBscaleW," using scale ", scale, scaleW);

// Thumb position and angle for cyborg beast
//thumbControl = [/*62.5-22.7*/ 39.8,13.5,0]; // location of thumb hinge
thumbControl = [40,18+.5,2-3]; // location of thumb hinge for Creo palm
thumbRotate = [0,13+5,-90]; // angle of thumb hinge for Creo palm

// TODO: Put thumb control and rotate into palms as functions
// then assign here based on selected palm

// spacing between fingers for the selected palm design

// TODO: make this a function in each palm design

fingerSpacing = (palmSelect==1)||(palmSelect==4)? 14.5 : 17.5; // spacing of fingers for CB and CCB models

//fingerSpacing = targetWidth / 3;
//echo("FINGER SPACING ",fingerSpacing);

// draw what's asked for

scale([1-2*prostheticHand,1,1]) { // mirrors left/right based on input selection

if (part==0) assembled(CBscale, CBscaleW, CCBscale, CCBscaleW, scale, scaleW); // Complete assembly of all parts, for preview.

if (part==1) { // Gauntlet. Make a sequence of ifs when there are more models. ADD GAUNTLETS HERE

	if (gauntletSelect==1)
		scale([scaleW*.7,1,1]) translate(gauntletOffset) rotate([0,0,-90]) DavidGauntlet();
	if (gauntletSelect==2) 
		scale([scaleW*.87,1,1]) KarunaGauntlet(measurements, padding);

//	if (gauntletSelect==1) scale([scaleW,1,1]) DavidGauntlet();
//	if (gauntletSelect==2) scale([scaleW,1,1]) KarunaGauntlet();
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
	if (palmSelect == 4) {
		echo("cyborg beast with thumb cutout palm len scale "+scale*100+"% width scale "+scaleW*100+"%.");
		CyborgNTLeftPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font);
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
if (part==5) if (haveThumb) scale([scaleW,scale,scale]) CyborgThumbPhalange();
// TODO: Add other designs here
if (part==6) if (haveThumb) scale([scaleW,scale,scale]) rotate([0,180,0]) CyborgThumbFinger();
// TODO: add other designs here
}

// Draw all of the parts. Like above but translating to appropriate positions.

module assembled(CBscale, CBscaleW, CCBscale, CCBscaleW, scale, scaleW) {
	echo("In assembled ",CBscale,CBscaleW,CCBscale,CCBscaleW);
	// scaling for selected palm
	echo("select ",palmSelect, scale, scaleW);

	//%showControlPoints();
	// Four Fingers
	//echo("FINGERS");
	//echo(fingerSpacing);
	translate(knuckleControl) {
		// assemble the fingers
		for (fX = [-1.5:1:1.5]) {
			translate([fX*fingerSpacing*scaleW, 0, 0]) {
				if (fingerSelect==CyborgBeastFingers) {
					echo(str("cyborg beast fingers scale ",str(scale*100),"% scale width ",scaleW*100,"%."));
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
					echo(str("Creo beast fingers scale ",scale*100,"% scale W ",scaleW*100,"%."));
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
	if (palmSelect == 4) {
		//echo("cyborg beast palm no thumb");
		CyborgNTLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font);
		}

	// ADD PALMS HERE

   // For the cyborg beast palm the thumb is here:

	thPhalangeLen = thumbPhalangeLen; // from import

	if (haveThumb) translate([thumbControl[0]*scaleW,thumbControl[1],thumbControl[2]]) rotate(thumbRotate) {
		if (fingerSelect==3) {
			scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgThumbPhalange();
			translate([0,31*CCBscaleW,0]) 
			scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgThumbFinger();
			}
		else if (fingerSelect==1) {		
			scale([CBscaleW,CBscale,CBscale]) CyborgThumbPhalange();
			translate([0,26*CBscaleW,0]) 
			scale([CBscaleW,CBscale,CBscale]) CyborgThumbFinger();
			}
		}

	echo("gauntlet scale ",scaleW);
	if (gauntletSelect==1)
		scale([scaleW*.7,1,1]) translate(gauntletOffset) rotate([0,0,-90]) DavidGauntlet();
	if (gauntletSelect==2) 
		scale([scaleW*.87,1,1]) KarunaGauntlet(measurements, padding);
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

