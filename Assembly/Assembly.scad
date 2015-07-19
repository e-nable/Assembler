/*
assemble e-NABLE hand prosthetic components into a customized design.

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
- Cyborg Beast http://www.thingiverse.com/thing:261462 by JorgeZuniga, verson 1.4 and 2.0 by Marc Petrykowski
- Creo version of Cyborg Beast http://www.thingiverse.com/thing:340750 by Ryan Dailey
- Parametric Gauntlet from http://www.thingiverse.com/thing:270259 by David Orgeman
- Cyborg Beast Short Gauntlet (Karuna's Gauntlet) http://www.thingiverse.com/thing:270322 by Frankie Flood
- Parametric Finger v2  http://www.thingiverse.com/thing:257544 by David Orgeman

Note that while parameters are commented using Customizer notation, this script won't work in Customizer because it includes STL files.

The following are the includes for each component. Note that STL components are represented by a simple OpenSCAD wrapper.
*/

use <RaptorReloaded.scad>
use <Raptor.scad>
use <CyborgBeast.scad>

include <AssembledMonolithic.scad> // testing

/* Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/CyborgLeftPalm.scad */

echo("Version",version());

include <Cyborg Proximal Phalange.scad>
include <Cyborg Finger.scad>
include <CyborgLeftPalm.scad>
include <CyborgThumbPhalange.scad>
include <CyborgThumbFinger.scad>
include <Cyborg Gauntlet.scad>

/* Creo Cyborg Beast */
include <CreoCyborgLeftPalm.scad>
include <Creo Cyborg Finger.scad>
include <Creo Cyborg Proximal Phalange.scad>
include <CreoCyborgThumbPhalange.scad>
include <CreoCyborgThumbFinger.scad>

/* Raptor */
include <EH2LeftPalm.scad> 		// left palm
include <EH2Gauntlet.scad> 		// gauntlet
include <EH2ProximalPhalange.scad> 	// for all fingers
include <EH2Fingertip.scad>		// all sizes
include <EH2Parts.scad> 		// all other parts

/* David's Finger */
include <../david-Finger/David-FingerProximal.scad>	// Proximal
include <../david-Finger/David-FingerDistal2.scad>	// Distal

/* Other parts */
include <ModelArm.scad>			// uses full measurements to render arm
include <KarunaGauntlet.scad>		// Karuna's Gauntlet
include <../Parametric_Gauntlet/David-Gauntlet.scad>	// David's parametric gauntlet
include <../Cyborg_Beast/OpenSCAD Files/cyborgbeast07e.scad>	// MakerBlock's OpenSCAD Cyborg Beast

/* [Selectors] */

/*
Good view: [ 54.30, 0.00, 341.60 ]

Note that all params are overridden by OpenSCAD's command line parameters.
e.g. 'openscad Assembly.scad -D part=2' would run OpenSCAD and render part 2.
The following assignments serve defaults for stand-alone testing.

Selectors
*/

// Part to render/print
part = 0; //[-1: Exploded, 0:Assembled, 1:Gauntlet, 2:Palm, 3:Finger Proximal, 4:Finger Distal Medium, 5:Thumb Proximal, 6:Thumb Distal, 7:Other Parts, 8:Finger Distal Short, 9:Finger Distal Long, 10:Hinge Caps]
echo("part ",part);

/* flags useful for development/debugging */

showGuide = 0; // Set to 1 to show the target size and location of the palm, to check alignment
showControls = 0; // Set to 1 to show control points (elbow, wrist, etc., joints) in assembly

/* Select design options */

// Which finger design do you like
fingerSelect = 1; //[1:Cyborg Beast with Bumps, 2:David, 3:Creo Cyborg Beast, 4:e-Nable Hand 2.0, 5: Raptor Fingers, no supports, 6:Cyborg Beast, No Bumps, ]
echo("fingerSelect ",fingerSelect);

cyborgFingers = ((fingerSelect==1) || (fingerSelect==6));

// Which palm design do you like?
palmSelect = 1; //[1:Cyborg Beast, 2:Cyborg Beast Parametric, 3:Creo Cyborg Beast, 4:Cyborg Beast with Thumb Cutout, 5:Raptor Hand, 6:Raptor Hand: no supports, 7:Raptor Hand: no thumb, 8:Raptor Hand: no thumb, no support, 9:Raptor for Arm, 10:Demo Raptor Hand]
echo("palmSelect ",palmSelect);
isRaptor = (palmSelect==5 || palmSelect==6 || palmSelect==7 || palmSelect==8 || palmSelect==9 || palmSelect==10);
echo ("is raptor ",isRaptor);
isCB = ((palmSelect==1)||(palmSelect==4));
echo("isCB ",isCB);

gauntletSelect = 7; //[1:Parametric Gauntlet, 2:Karuna Short Gauntlet, 3:Raptor, 4:Raptor no supports, 5:Raptor Flared, 6:Raptor Flared no supports, 7:Cyborg Beast Gauntlet]
echo("gauntletSelect ",gauntletSelect);
isFlared = ((gauntletSelect==5) || (gauntletSelect==6));
echo("is flared ",isFlared);

echo(str("*** part-h",prostheticHand,"-a",palmSelect,"-f",fingerSelect,"-g",gauntletSelect,"-",part,".stl"));

/* [Measurements] */
// See Measurement Guide at:
// https://docs.google.com/a/popk.in/document/d/1LX3tBpio-6IsMMo3aaUdR-mLwWdv1jS4ooeEHb79JYo for details.
// The default values are the ones from the photo in that document.

// Note that only the full hand palm length (L/R9) and full hand knuckle width (L/R8) are
// required and used for scaling static designs. The remaining measurements are available for
// use in more sophisticated parametric designs.

//Length of Elbow Joint (mm)
Left1 = 0;//66.47;
Right1 = 0;//62.67;
//Distance between lateral and medial side of the forearm proximal to the elbow joint
Left2 = 0;//64.04;
Right2 = 0;//65.62;
//Distance between lateral and medial side of the middle forearm
Left3 = 0;//46.35;
Right3 = 0;//59.14;
//Distance between lateral and medial side of the forearm proximal to the wrist
Left4 = 0;//35.14;
Right4 = 0;//48.78;
//Wrist Joint distance from lateral to medial side
Left5 = 0;//35.97;
Right5 = 0;//51.85;
//Distance from wrist to distal end on thumb side (Lateral)
Left6 = 0;//31.05;
Right6 = 0;
//Distance from wrist to distal middle end of effected hand
Left7 = 0;//31.80;
Right7 = 0;
//Distance from Lateral and Medial sides of the distal part of the hand
Left8 = 0;//40.97;
Right8 = 70;// 114;//79.375;
//Distance from wrist to distal end on thumb side (Medial)
Left9 = 0;//31.05;
Right9 = 0;//70; //109.4+40;//88;
//Length of Elbow to wrist joint
Left10 = 0;//147.5;
Right10 = 0;//230.6;
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
echo("pHand ",pHand);

// pack in arrays to pass around more easily.
// e,g, Left4 = measurements[0][4], Right9 = measurements[1][9].
// measurements[0][0] is the prosthetic hand, measurements[1][0] is the other one.

measurements = [[pHand, Left1, Left2, Left3, Left4, Left5, Left6, Left7,
                 Left8, Left9, Left10, LeftFlexion, LeftExtension],
                [1-pHand, Right1, Right2, Right3, Right4, Right5, Right6, Right7,
                 Right8, Right9, Right10, RightFlexion, RightExtension]];

//Comment out except when testing code:


//measurements = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],[1, 0, 0, 0, 0, 55, 0, 0, 55, 71, 0, 0, 0]];

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

label="http://e-nable.me/"; // "http://e-NABLE.me/12345"
font="Letters.dxf";

/* [Hidden] */

// Constants to make code more readable
CyborgBeastFingersBump = 1;
CyborgBeastFingersNoBump = 6;
DavidFingers = 2;
CyborgBeastPalm = 1;
CBParametricPalm = 2;

// Calculations

// true if we should print a thumb, false if not. This logic will
// change as we add more designs

haveThumb = ((palmSelect != 4) && (palmSelect != 7) && (palmSelect != 8));
haveGauntlet = palmSelect != 9;

fullHand = 1-pHand;

// so we can use array references, like measurement[fullHand][0].

//Wrist_Width=55;
//gw = 0+(targetWidth-10)/55;
//echo("gauntlet width scale ",gw," for target ",targetWidth," wrist ", Wrist_Width," or ",(targetWidth-10)/Wrist_Width);

if (showGuide) %translate([0,targetLen/2,0]) cube([targetWidth, targetLen, 5], center=true);

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

// Hacked the following to force palm length scaling to match
// width scaling for Raptor. Figure the rest out later.
//
// This is a horrible hack that I will regret later.

//palmLen = measurements[fullHand][9]+padding;
palmLen = 67/55*measurements[fullHand][8]+padding;

echo("Palm len ", palmLen);
armLen = measurements[pHand][10];
//echo("Arm len ", armLen);
knuckleControl = [0,palmLen,0];
elbowControl = [0,-armLen,0];

//echo("target ",targetLen, "palmLen", palmLen);

//echo("Wrist control ",wristControl);
//echo("Knuckle control ", knuckleControl);
//echo("Elbow control ", elbowControl);

echo("knuckle ",knuckleControl, " wrist ", wristControl," padding ", padding);
targetLen = knuckleControl[1]-wristControl[1];
//echo("In Assembly target len is ",targetLen);
echo(fullHand,measurements[fullHand][8]);
targetWidth = measurements[fullHand][8]+padding;
//echo("In Assembly target width is ",targetWidth);

// note that we have to compute all design's scaling factors so that we can scale both the palm an the fingers
// e,g, scale the cyborg beast palm by CBScale, and scale fingers from the Creo Cyborg Beast at CCBscale.

// XXXscale is the length scale (also used for height)
// YYYscaleW is the width scale

// TODO: make this a function of each design

echo("Target Len ",targetLen," target Width ",targetWidth);
// compute cyborg beast palm scaling
//CBscale = CBScaleLen(targetLen);
CBscaleW = CBScaleWidth(targetWidth);
CBscale = CBscaleW;
// compute creo cyborg beast scaling
//CCBscale = CCBScaleLen(targetLen);
CCBscaleW = CCBScaleWidth(targetWidth);
CCBscale = CCBscaleW;
// compute e-NABLE Hand 2.0 scaling
//EHscale = EHScaleLen(targetLen);
EHscaleW = EHScaleWidth(targetWidth);
EHscale = EHscaleW;

// set scales based on selected palm.
// As there are more models, this expression is going to get ugly

scale = isRaptor? EHscale : ((palmSelect==1)||(palmSelect==4)? CBscale : CCBscale);
scaleW = isRaptor? EHscaleW : (palmSelect==1)||(palmSelect==4)? CBscaleW : CCBscaleW*1.27;

echo(str("in Assembly CB scale ",CBscale,",",CBscaleW," CCB scale ",CCBscale,", ",CCBscaleW," EH scale ",EHscale,", ",EHscaleW," using scale ", scale,", ",scaleW));

// Thumb position and angle for selected palm (defined in palm scad files)

thumbControl = isRaptor? EHThumbControl : (palmSelect==1)||(palmSelect==4)? CBThumbControl : CCBThumbControl;
thumbRotate = isRaptor? EHThumbRotate : (palmSelect==1)||(palmSelect==4)? CBThumbRotate : CCBThumbRotate;

// spacing between fingers for the selected palm design

fingerSpacing = isRaptor? EHFingerSpacing : (palmSelect==1)||(palmSelect==4)? CBFingerSpacing : CCBFingerSpacing; // spacing of fingers for CB and CCB models (before scaling)

// draw what's asked for

scale([1-2*prostheticHand,1,1]) { // mirrors left/right based on input selection

    if (part==-1) assembled(CBscale, CBscaleW, CCBscale, CCBscaleW, EHscale, EHscaleW, scale, scaleW, explode=20, flare=isFlared, demoHand=(palmSelect==10), gauntlet=haveGauntlet); // Complete assembly of all parts, exploded to show assembly.

    if (part==0) assembled(CBscale, CBscaleW, CCBscale, CCBscaleW, EHscale, EHscaleW, scale, scaleW, flare=isFlared, demoHand=(palmSelect==10), gauntlet=haveGauntlet); // Complete assembly of all parts, for preview.

    if ((part==1) && haveGauntlet) { // Gauntlet. Make a sequence of ifs when there are more models. ADD GAUNTLETS HERE

        if (gauntletSelect==1)
            scale([scaleW*.7,scale, scale]) translate(gauntletOffset) rotate([0,0,-90]) DavidGauntlet();
        if (gauntletSelect==2)
            scale([scaleW*.87,scale, scale]) KarunaGauntlet(measurements, padding);
        if (gauntletSelect==3)
            scale([scaleW,scale,scale]) EH2Gauntlet(measurements, padding, support=1, flare=0);
        if (gauntletSelect==4)
            scale([scaleW,scale, scale]) EH2Gauntlet(measurements, padding, support=0, flare=0);
        if (gauntletSelect==5)
            scale([scaleW,scale,scale]) EH2Gauntlet(measurements, padding, support=1, flare=1);
        if (gauntletSelect==6)
            scale([scaleW,scale, scale]) EH2Gauntlet(measurements, padding, support=0, flare=1);
        if (gauntletSelect==7)
            scale([scaleW,scale, scale]) CyborgGauntlet(thumb=(palmSelect==1));
    }

    if (part==2) { // Palms
        echo("*** PALM ***");
        if (isCB) {
            echo("cyborg beast palm len scale ",CBscale*100,"% width scale ",CBscaleW*100,"% label",label);
            scale([CBscaleW,CBscale,CBscale]) CyborgLeftPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, thumb=haveThumb);
        }
        if (palmSelect == CBParametricPalm) {
            CyborgBeastParametricPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font);
        }
        if (palmSelect == 3) {
            CreoCyborgLeftPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font);
        }
        if (palmSelect == 4) {
            echo("cyborg beast No Thumb palm len scale "+scale*100+"% width scale "+scaleW*100+"%.");
            scale([CBscaleW,CBscale,CBscale]) CyborgLeftPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, thumb=0);
        }
        if (palmSelect == 5)
            EHLeftPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=1);
        if (palmSelect == 6)
            EHLeftPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=0);
        if (palmSelect == 7)
            EHLeftPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=1, thumb=0);
        if (palmSelect == 8)
            EHLeftPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=0, thumb=0);
        if (palmSelect == 9)
            EHLeftPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=1, thumb=1, mount=1);
        if (palmSelect == 10)
            EHLeftPalm(assemble=false, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=1, thumb=1, mount=0, demoHand=1);
        // ADD PALMS HERE
    }

    if (part==3) { // Finger Proximals
        if (cyborgFingers)
            scale([CBscaleW,CBscale,CBscale]) CyborgProximalPhalange();
        if (fingerSelect==DavidFingers) DavidFingerProximal();
        if (fingerSelect==3)
            scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgProximalPhalange();
        if (fingerSelect==4) {
            echo("EHProximale scale ",[EHscaleW,EHscale,EHscale]);
            scale([EHscaleW,EHscale,EHscale]) EHProximalPhalange(support=1);
        }
        if (fingerSelect==5) {
            echo("EHProximale scale ",[EHscaleW,EHscale,EHscale]);
            scale([EHscaleW,EHscale,EHscale]) EHProximalPhalange(support=0);
        }
    }
    if (part==4) { // Finger Distals
        if (fingerSelect==CyborgBeastFingersNoBump)
            rotate([0,180,0]) scale([CBscaleW,CBscale,CBscale]) CyborgFinger(bump=0);
        if (fingerSelect==CyborgBeastFingersBump)
            rotate([0,180,0]) scale([CBscaleW,CBscale,CBscale]) CyborgFinger(bump=1);
        if (fingerSelect==DavidFingers) DavidFingerDistal();
        if (fingerSelect==3)
            rotate([0,180,0]) scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgFinger();
        if (fingerSelect==4)
            rotate([0,180,0]) scale([EHscaleW,EHscale,EHscale])
            EHFingertip(2, support=1);
        if (fingerSelect==5)
            rotate([0,180,0]) scale([EHscaleW,EHscale,EHscale])
            EHFingertip(2, support=0);
        // ADD FINGER DISTALS HERE
    }
// Thumb proximal
    if (part==5) {
        if (haveThumb) {
            if (cyborgFingers) scale([CBscaleW,CBscale,CBscale]) CyborgThumbPhalange();
            if (fingerSelect==3) scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgThumbPhalange();
            if (fingerSelect==4) {
                echo("EHProximal thumb scale ",[EHscale,EHscaleW,EHscaleW]);
                scale([EHscale,EHscaleW,EHscaleW]) EHProximalPhalange(support=1);
                }
            if (fingerSelect==5) {
                echo("EHProximal thumb scale ",[EHscale,EHscaleW,EHscaleW]);
                scale([EHscale,EHscaleW,EHscaleW]) EHProximalPhalange(support=0);
                }
            }
            else fail("This design does not have Thumb proximal.");
        }
// Thumb distal
    if (part==6) {
        if (haveThumb) {
            //scale([scaleW,scale,scale]) rotate([0,180,0]) {
            if (cyborgFingers) rotate([0,180,0]) scale([CBscaleW,CBscale,CBscale])
                CyborgThumbFinger(bump=(fingerSelect==CyborgBeastFingersBump));
            if (fingerSelect==3) scale([CCBscaleW,CCBscale,CCBscale])
                CreoCyborgThumbFinger();
            if (fingerSelect==4)
                rotate([0,180,0]) scale([EHscale,EHscaleW,EHscaleW])
                EHFingertip(2, support=1);
            if (fingerSelect==5)
                rotate([0,180,0]) scale([EHscale,EHscaleW,EHscaleW])
                EHFingertip(2, support=0);
            }
            else fail("This design does not have Thumb Distal.");
        }
// Other parts (pins, etc.)
    if (part==7) {
        if (isRaptor) {
            EH2OtherParts(scaleL=EHscale, scaleW=EHscaleW, thumb=haveThumb,
                          gauntlet=haveGauntlet);
        }
        else fail("This design does not have other parts.");
    }
// Finger short distals (EH2.0)
    if (part==8) { // Finger Short Distals (for pinkie)
        if (isRaptor) {
            if (fingerSelect==4)
                rotate([0,180,0]) scale([EHscaleW,EHscale,EHscale]) EHFingertip(1, support=1);
            if (fingerSelect==5)
                rotate([0,180,0]) scale([EHscaleW,EHscale,EHscale]) EHFingertip(1, support=0);
        }
        else fail("This design does not contain short fingertips.");
    }
// Finger long distals (for middle finger, EH only)
    if (part==9) { // Finger Long Distals
        if (isRaptor) {
            if (fingerSelect==4)
                rotate([0,180,0]) scale([EHscaleW,EHscale,EHscale]) EHFingertip(3, support=1);
            if (fingerSelect==5)
                rotate([0,180,0]) scale([EHscaleW,EHscale,EHscale]) EHFingertip(3, support=0);
        }
        else fail("This design does not contain long fingertips.");
    }
    if (part==10) {
        if (isRaptor && haveGauntlet) {
            EHhingeCaps(scaleL=EHscale, scaleW=EHscaleW);
        }
        else fail("This design does not contain hinge caps");
    }
}

// Draw all of the parts. Like above but translating to appropriate positions.



module showControlPoints() {
    translate(wristControl) color("yellow") sphere(5);
    translate(knuckleControl) color("blue") sphere(15);
    translate(elbowControl) color("green") sphere(5);
    translate(thumbControl) color("red") sphere(5);
}


// return this if there's an error
module fail(msg) {
    echo(str("ERROR: ",msg));
    rotate([90,0,-45]) {
        color("black") {
            translate([0,0,.5]) write("No part.", center=true);
            translate([0,-25,0]) write(msg, center=true);
            }
        color("white") cylinder(r=15,h=.5);
        }
    }
