/*
assemble e-NABLE hand prosthetic components into a customized design.

This program assembles the components from various e-NABLE designs, 
and scales and arranges them based on measurements.

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
- Cyborg Beast http://www.thingiverse.com/thing:261462 by JorgeZuniga, 
	verson 1.4 and 2.0 by Marc Petrykowski
- Creo version of Cyborg Beast http://www.thingiverse.com/thing:340750 by Ryan Dailey
- Parametric Gauntlet from http://www.thingiverse.com/thing:270259 by David Orgeman
- Cyborg Beast Short Gauntlet (Karuna's Gauntlet) 
	http://www.thingiverse.com/thing:270322 by Frankie Flood
- Parametric Finger v2  http://www.thingiverse.com/thing:257544 by David Orgeman

Note that while parameters are commented using Customizer notation, 
this script won't work in Customizer because it includes STL files.

Refactoring done by Les Hall starting Tue Jan 27, 2014.
*/

echo("Version", version() );




/*  ~<{ Includes }>~  */

/* The following are the includes for each component. 
Note that STL components are represented by a simple OpenSCAD wrapper.
*/

/* Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/CyborgLeftPalm.scad */
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
include <EH2LeftPalm.scad>  // left palm
include <EH2Gauntlet.scad>  // gauntlet
include <EH2ProximalPhalange.scad>  // for all fingers
include <EH2Fingertip.scad>  // all sizes
include <EH2Parts.scad>  // all other parts

/* David's Finger */
include <../david-Finger/David-FingerProximal.scad>	// Proximal
include <../david-Finger/David-FingerDistal2.scad>	  // Distal

/* Other parts */
include <ModelArm.scad>  // uses full measurements to render arm
include <KarunaGauntlet.scad>  // Karuna's Gauntlet
include <../Parametric_Gauntlet/David-Gauntlet.scad>  // David's parametric gauntlet
include <../Cyborg_Beast/OpenSCAD Files/cyborgbeast07e.scad>  // MakerBlock's OpenSCAD Cyborg Beast




/*  ~<{ Selectors }>~  */

/* [Selectors] */
/*
Good view: [ 54.30, 0.00, 341.60 ]

Note that all params are overridden by OpenSCAD's command line parameters.
e.g. 'openscad Assembly.scad -D part=2' would run OpenSCAD and render part 2.
The following assignments serve defaults for stand-alone testing.
*/

// Part to render/print
part = 0;  //[-1: Exploded, 0:Assembled, 1:Gauntlet, 2:Palm, 3:Finger Proximal, 4:Finger Distal Medium, 5:Thumb Proximal, 6:Thumb Distal, 7:Other Parts, 8:Finger Distal Short, 9:Finger Distal Long, 10:Hinge Caps, 11:EHtensioner, 12:EHhingePins, 13:EHhexPins, 14:EHdovetail, 15:knuckle pins, 16:thumb pin, 17:finger pins,  18:RRGauntlet+Support, 19:RRWrist Pin 20:RRWrist Pin Cap, 21:RRRetention Clip, 22:RRTensioner, 23:RRTensioner Pin, 24:RRPalm+Support, 25:RRKnucklePin, 26:RRThumbPin, 27:RRProximal, 28:RRFinger Pin, 29:RRFingertip]
echo("part ",part);

/* flags useful for development/debugging */
showGuide = 0;  // Set to 1 to show the target size and location of the palm, to check alignment
showControls = 0;  // Set to 1 to show control points (elbow, wrist, etc., joints) in assembly

/* Select design options */
// Which finger design do you like?
fingerSelect = 5;  //[1:Cyborg Beast with Bumps, 2:David, 3:Creo Cyborg Beast, 4:e-Nable Hand 2.0, 5: Raptor Fingers, no supports, 6:Cyborg Beast, No Bumps, ]
echo("fingerSelect ",fingerSelect);
// set cyborgFingers to one if the finger selected is a cyborg finger
cyborgFingers = ((fingerSelect==1) || (fingerSelect==6));

// Which palm design do you like?
palmSelect = 5; //[1:Cyborg Beast, 2:Cyborg Beast Parametric, 3:Creo Cyborg Beast, 4:Cyborg Beast with Thumb Cutout, 5:Raptor Hand, 6:Raptor Hand: no supports, 7:Raptor Hand: no thumb, 8:Raptor Hand: no thumb, no support, 9:Raptor for Arm, 10:Demo Raptor Hand, 11:Raptor Reloaded]
echo("palmSelect ",palmSelect);

// set to true if selected palm is one of the Raptor options
isRaptor = (palmSelect==5 || palmSelect==6 || palmSelect==7 || palmSelect==8 || palmSelect==9 || palmSelect==10);
echo ("is raptor ",isRaptor);
// set to true if palm select is one of the Raptor options
isCB = ((palmSelect==1)||(palmSelect==4));
echo("isCB ",isCB);

gauntletSelect = 4; //[1:Parametric Gauntlet, 2:Karuna Short Gauntlet, 3:Raptor, 4:Raptor no supports, 5:Raptor Flared, 6:Raptor Flared no supports, 7:Cyborg Beast Gauntlet]
echo("gauntletSelect ",gauntletSelect);
isFlared = ((gauntletSelect==5) || (gauntletSelect==6));
echo("is flared ",isFlared);
echo(str("*** part-h",prostheticHand,"-a",palmSelect,"-f",fingerSelect,"-g",gauntletSelect,"-",part,".stl"));

// Which hand is the prosthetic for?
prostheticHand=1; // [0:Left, 1:Right for mirroring hand]
echo("prosthetic hand ",prostheticHand);
pHand = prostheticHand;
echo("pHand ",pHand);

// which parts have support or not?
gauntletSupport = 0;
palmSupport = 0;

/*  ~<{ Measurements }>~  */

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
Left8 = 70;//40.97;
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




/*  ~<{ Fixtures }>~  */

/* [Fixtures] */

// MM diameter of wrist bolt. M5=5.5, M3=3.3, etc.
WristBolt = 5.5;
// MM diameter of knuckle bolt. M5=5.5, M3=3.3, etc.
KnuckleBolt = 3.3;
// MM diameter of finger joint bolt. M5=5.5, M3=3.3, etc.
JointBolt = 3.3;
// MM diameter of thumb bolt. M5=5.5, M3=3.3, etc.
ThumbBolt = 3.3;





/*  ~<{ Label }>~  */
/* [Label] */
label="http://e-nable.me/"; // "http://e-NABLE.me/12345"
font="Letters.dxf";

/* [Hidden] */

/*  ~<{ Constants for selecting default and optional parts }>~  */
// hand
HandCyborgBeast = 1;
HandRaptor = 2;
HandRaptorReloaded = 3;

// part selections
CBParametricPalm = 2;
CyborgBeastGauntlet = 101;
CyborgBeastGauntletThumbless = 102;
CyborgBeastGauntletParametric = 103;
CyborgBeastGauntletKaruna = 104;
CyborgBeastCap = 105;
CyborgBeastWristPin = 106;
CyborgBeastPalm = 107;
CyborgBeastPalmThumbless = 108;
CyborgBeastThumbPin = 109;
CyborgBeastKnucklePin = 110;
CyborgBeastPhlange = 111;
CyborgBeastFingerPin = 112;
CyborgBeastFingerTip = 113;
CyborgBeastFingerTipBump = 114;
CyborgBeastFingerTipDavid = 115;
RaptorGauntlet = 201;
RaptorGauntletNoSupports = 202;
RaptorGauntletFlared = 203;
RaptorGauntletFlaredNoSupports = 204;
RaptorHingePin = 205;
RaptorHingeCap = 206;
RaptorDoveTail = 207;
RaptorTensioner = 208;
RaptorHexPins = 209;
RaptorPalm = 210;
RaptorKnucklePin = 211;
RaptorThumbPin = 212;
RaptorProximal = 213;
RaptorFingerPin = 214;
RaptorFingerTip = 215;
RaptorReloadedGauntlet = 301;
RaptorReloadedGauntletNoSupports = 302;
RaptorReloadedGauntletFlared = 303;
RaptorReloadedGauntletFlaredNoSupports = 304;
RaptorReloadedHingePin = 305;
RaptorReloadedHingeCap = 306;
RaptorReloadedDoveTail = 307;
RaptorReloadedTensioner = 308;
RaptorReloadedHexPins = 309;
RaptorReloadedPalm = 310;
RaptorReloadedKnucklePin = 311;
RaptorReloadedThumbPin = 312;
RaptorReloadedProximal = 313;
RaptorReloadedFingerPin = 314;
RaptorReloadedFingerTip = 315;

/*  ~<{ Variables for selecting optional parts }>~  */
handType = 
    isCB ? HandCyborgBeast : 
    isRaptor ? HandRaptor : 
    HandRaptorReloaded;
echo("handType", handType);
cyborgBeastGauntletType = 
    gauntletSelect == 1 ? CyborgBeastGauntletParametric :
    gauntletSelect == 2 ? CyborgBeastGauntletKaruna :
    gauntletSelect == 7 ? (palmSelect==1 ? CyborgBeastGauntlet : 
                          palmSelect==4 ? CyborgBeastGauntletThumbless : 0) : 0;
cyborgBeastFingerType = 
    fingerSelect == 1 ? CyborgBeastFingerTipBump : 
    fingerSelect == 2 ? CyborgBeastFingerTipDavid : 
    fingerSelect == 3 ? CyborgBeastFingerTip : 
    fingerSelect == 4 ? RaptorFingerTip : 
    fingerSelect == 5 ? RaptorFingerTip : 
    fingerSelect == 6 ? CyborgBeastFingerTip : 0;
raptorGauntletType = 
    gauntletSelect == 3 ? RaptorGauntlet :
    gauntletSelect == 4 ? RaptorGauntletNoSupports :
    gauntletSelect == 5 ? RaptorGauntletFlared :
    gauntletSelect == 6 ? RaptorGauntletFlaredNoSupports : 0;
explode = part == -1;

/*  ~<{ Calculations }>~  */

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



/*  ~<{ Parametric Gauntlet }>~  */

/* [Parametric Gauntlet] */

// Parametric Gauntlet parameters
Print_Tuners=false;//default value true
gauntletOffset = [0, -8, -4];
Pivot_Screw_Size=M4;




/*  ~<{ Offsets }>~  */

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




/*  ~<{ Measurements }>~  */

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
// YYY is the width scale

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




/*  ~<{ Draw Hand }>~  */

// draw what's asked for
doEverything(prostheticHand);

/* -- this doesn't work because mirroring inverts normals. so we hack around it.
if (prostheticHand<.5) {
    doEverything();
    }
else {
    mirror([1,0,0]) doEverything();
    }
*/

//mirror([1,0,0]) 
//scale([1-2*prostheticHand,1,1]) 

module doEverything(prostheticHand)
    { // mirrors left/right based on input selection
    // true means to use the new refactored assembly code, false means old assembly code
    useRefactored = (handType == HandRaptorReloaded);
    
    if (part==-1) 
        // TODO: add 'explode' offets into refactored assembly
        if (useRefactored) refactored(handType, CBscale, CBscaleW, CCBscale, CCBscaleW, EHscale, EHscaleW, scale, scaleW, explode=20, flare=isFlared, demoHand=(palmSelect==10), gauntlet=haveGauntlet);
        else assembled(CBscale, CBscaleW, CCBscale, CCBscaleW, EHscale, EHscaleW, scale, scaleW, explode=20, flare=isFlared, demoHand=(palmSelect==10), gauntlet=haveGauntlet); 
            // Complete assembly of all parts, exploded to show assembly.

    if (part==0) 
        if (useRefactored) refactored(CBscale, CBscaleW, CCBscale, CCBscaleW, 
            EHscale, EHscaleW, scale, scaleW, 
            flare=isFlared, demoHand=(palmSelect==10), 
            gauntlet=haveGauntlet);  
    else assembled(CBscale, CBscaleW, CCBscale, CCBscaleW, 
            EHscale, EHscaleW, scale, scaleW, 
            flare=isFlared, demoHand=(palmSelect==10), 
            gauntlet=haveGauntlet); 
    // Complete assembly of all parts, for preview.

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
        echo("*** PALM ***", palmSelect, isCB);
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
    if (part==11) {
        if (isRaptor && haveGauntlet) {
            EHtensioner(scaleL, scaleW, thumb);
        }
        else fail("This design does not contain ****");
    }
    if (part==12) {
        if (isRaptor && haveGauntlet) {
            EHhingePins(scaleL, scaleW);
        }
        else fail("This design does not contain ****");
    }
    if (part==13) {
        if (isRaptor && haveGauntlet) {
            EHhexPins(scaleL, scaleW);
        }
        else fail("This design does not contain ****");
    }
    if (part==14) {
        if (isRaptor && haveGauntlet) {
            EHdovetail(scaleL, scaleW, flare=flare);
        }
        else fail("This design does not contain ****");
    }
    if (part==15) {
        if (isRaptor && haveGauntlet) {
            EHthumbPin(ss(scaleL), ss(scaleW));
        }
        else fail("This design does not contain ****");
    }
    if (part==16) {
        if (isRaptor && haveGauntlet) {
            EHknucklePins(scaleL, scaleW);
        }
        else fail("This design does not contain ****");
    }
    if (part==17) {
        if (isRaptor && haveGauntlet) {
            EHfingerPin(scaleL, scaleW);
        }
        else fail("This design does not contain ****");
    }
   if (part==18)
    {
        if (handType==HandRaptorReloaded)
        {
            import("../RaptorReloaded/raptor_reloaded_gauntlet.stl");
            if (gauntletSupport)
                import("../RaptorReloaded/raptor_reloaded_gauntlet_support.stl");
        }
        else
        { 
            fail("this design does not contain Raptor Reloaded Gauntlet");
            if (gauntletSupport)
                fail("this design does not contain Raptor Reloaded Gauntlet Support");
        }
    }
    if (part==19)
    {
        if (handType==HandRaptorReloaded)
        {
            import("../RaptorReloaded/raptor_reloaded_wrist_pin.stl");
        }
        else fail("this design does not contain Raptor Reloaded Wrist Pin");
    }
    if (part==20)
    {
        if (handType==HandRaptorReloaded)
        {
            import("../RaptorReloaded/raptor_reloaded_wrist_pin_cap.stl");
        }
        else fail("this design does not contain Raptor Reloaded Wrist Pin Cap");
    }
    if (part==21)
    {
        if (handType==HandRaptorReloaded)
        {
            import("../RaptorReloaded/raptor_reloaded_retention_clip.stl");
        }
        else fail("this design does not contain Raptor Reloaded Retention Clip");
    }
    if (part==22)
    {
        if (handType==HandRaptorReloaded)
        {
            import("../RaptorReloaded/raptor_reloaded_tensioner.stl");
        }
        else fail("this design does not contain Raptor Reloaded Tensioner");
    }
    if (part==23)
    {
        if (handType==HandRaptorReloaded)
        {
            import("../RaptorReloaded/raptor_reloaded_tensioner_pin.stl");
        }
        else fail("this design does not contain Raptor Reloaded Tensioner Pin");
    }
    if (part==24)
    {
        if (handType==HandRaptorReloaded)
        {
            import("../RaptorReloaded/raptor_reloaded_left_palm.stl");
            if (palmSupport)
                import("../RaptorReloaded/raptor_reloaded_left_palm_support.stl");
        }
        else
        {
            fail("this design does not contain Raptor Reloaded Palm");
            if (palmSupport)
                fail("this design does not contain Raptor Reloaded Palm Support");
        }
    }
    if (part==25)
    {
        if (handType==HandRaptorReloaded)
        {
            import("../RaptorReloaded/raptor_reloaded_knuckle_pin.stl");
        }
        else fail("this design does not contain Raptor Reloaded Knucke Pin");
    }
    if (part==26)
    {
        if (handType==HandRaptorReloaded)
        {
            import("../RaptorReloaded/raptor_reloaded_thumb_pin.stl");
        }
        else fail("this design does not contain Raptor Reloaded Thumb Pin");
    }
    if (part==27)
    {
        if (handType==HandRaptorReloaded)
        {
            import("../RaptorReloaded/raptor_2.0_proximal.stl");
        }
        else fail("this design does not contain Raptor Reloaded Proximal");
    }
    if (part==28)
    {
        if (handType==HandRaptorReloaded)
        {
            import("../RaptorReloaded/raptor_2.0_finger_pin.stl");
        }
        else fail("this design does not contain Raptor Reloaded Finger Pin");
    }
    if (part==29)
    {
        if (handType==HandRaptorReloaded)
        {
            import("../RaptorReloaded/raptor_2.0_fingertip.stl");
        }
        else fail("this design does not contain Raptor Reloaded Fingertip");
    }
}





// Draw all of the parts. Like above but translating to appropriate positions.

EHproxLen = 19;

// refactored assembled()
// LAP notes:
// - added parameters back, so they can be passed explicitly
//      rather than implicitly as globals

module refactored(ChandType, Bscale, CBscaleW, CCBscale, CCBscaleW, EHscale, EHscaleW, scale, scaleW, explode=0, flare=0, mount=0, gauntlet=1) {
    if (handType == HandCyborgBeast) {
        assembled(CBscale, CBscaleW, CCBscale, CCBscaleW, 
            EHscale, EHscaleW, scale, scaleW, 
            explode=0, flare=isFlared, 
            demoHand=(palmSelect==10), gauntlet=haveGauntlet);
        //DrawHandCyborgBeast();
        }
    else if (handType == HandRaptor)
        DrawHandRaptor();
    else if (handType == HandRaptorReloaded)
        DrawHandRaptorReloaded();
}

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//
//      Cyborg Beast
//
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

module DrawHandCyborgBeast() {
    if (cyborgBeastGauntletType == CyborgBeastGauntlet)
        DrawCyborgBeastGauntlet();
    else if (cyborgBeastGauntletType == CyborgBeastGauntletThumbless)
        DrawCyborgBeastGauntletThumbless();
    else if (cyborgBeastGauntletType == CyborgBeastGauntletParametric)
        DrawCyborgBeastGauntletKaruna();
    else if (cyborgBeastGauntletType == CyborgBeastGauntletKaruna)
        DrawCyborgBeastGauntletKaruna();

}

module DrawCyborgBeastGauntlet() {
    mirror([prostheticHand,0,0])
    color("blue")
    scale([scaleW,scale, scale])
    CyborgGauntlet(thumb=1);
    
    for (i=[0:1]) {
        DrawCyborgBeastCap(i);
        DrawCyborgBeastWristPin(i);
    }
    DrawCyborgBeastPalm();
}

module DrawCyborgBeastGauntletThumbless() {
    mirror([prostheticHand,0,0])
    color("blue")
    scale([scaleW,scale, scale])
    CyborgGauntlet(thumb=0);
    
    DrawCyborgBeastCap(0);
    DrawCyborgBeastWristPin(0);
    DrawCyborgBeastPalm();
}

module DrawCyborgBeastGauntletKaruna() {
    mirror([prostheticHand,0,0])
    color("blue")
    translate([0,-explode,0])
    scale([scaleW*.7,scale, scale])
    KarunaGauntlet(measurements, padding);

    for (i=[0:1]) {
        DrawCyborgBeastCap(i);
        DrawCyborgBeastWristPin(i);
    }
    DrawCyborgBeastPalmThumbless();
}

module DrawCyborgBeastGauntletParametric() {
    scale([scaleW*.7,scale, scale]) 
    translate(gauntletOffset) 
    rotate([0,0,-90]) 
    color("blue")
    DavidGauntlet();
    
    for (i=[0:1]) {
        DrawCyborgBeastCap(i);
        DrawCyborgBeastWristPin(i);
    }
    DrawCyborgBeastPalm();
}
    
module DrawCyborgBeastCap(i=0) {
    color("green") 
    translate(wristControl) 
    translate([-32*scaleW-0.5*explode,0,-7*scaleW]) 
    rotate([0,-90,0])
    EHhingeCaps(EHscale, EHscaleW);
}

module DrawCyborgBeastWristPin(i=0) {
    color("green") 
    translate(wristControl) 
    translate([-21*scaleW+explode,0,-3*scaleW])
    EHhingePins(EHscale, EHscaleW);
}

module DrawCyborgBeastTensioner() {    
    color("red") 
    translate([0,-56*scale-4*explode, 25*scale]) 
    rotate([-90,0,0])
    EHtensioner(EHscale, EHscaleW);
}

module DrawCyborgBeastDovetail() {    
    color("orange") 
    translate([0,-68*scale-4.5*explode,23.2*EHscale]) 
    rotate([180,0,0])
    EHdovetail(EHscale, EHscaleW, flare=flare);
}

module DrawCyborgBeastHexPins() {    
    color("green")
    translate([0,-40*EHscaleW+1.5*explode,24*EHscale])
    EHhexPins(EHscale, EHscaleW);
}

module DrawCyborgBeastPalm() {
    DrawCyborgBeastThumbPin();
    for(i=[0:1])
        DrawCyborgBeastKnucklePin(i);
    for(i=[0:4])
        DrawCyborgBeastPhlange(i);
}

module DrawCyborgBeastPalmThumbless() {
    for(i=[0:3])
        DrawCyborgBeastPhlange(i);
}

module DrawCyborgBeastThumbPin() {
}

module DrawCyborgBeastKnucklePin(i=0) {
}

module DrawCyborgBeastPhlange(i=0) {
    color("yellow")
    translate([0,-14*scale,0])
    scale([CBscaleW,CBscale,CBscale])
    CyborgProximalPhalange();

    DrawCyborgBeastFingerPin();
    if (cyborgBeastFingerType == CyborgBeastFinger)
        DrawCyborgBeastFinger();
    else if (cyborgBeastFingerType == CyborgBeastFingerBump() )
        DrawCyborgBeastFingerBump();
    else if (cyborgBeastFingerType == CyborgBeastFingerDavid() )
        DrawCyborgBeastFingerDavid();
}

module DrawCyborgBeastFingerPin() {
}

module DrawCyborgBeastFinger() {
    echo(str("Creo beast fingers scale ",scale*100,"% scale W ",scaleW*100,"%."));
    translate([0,29*CCBscale+explode,0])
    scale([CCBscaleW,CCBscale,CCBscale])
    CreoCyborgFinger();
}

module DrawCyborgBeastFingerBump() {
    color("orange")
    translate([0,9*scale+explode,0])
    scale([CBscaleW,CBscale,CBscale])
    CyborgFinger(bump=(fingerSelect==CyborgBeastFingersBump));
}

module DrawCyborgBeastFingerDavid() {
    echo("david fingers");
    translate(davidFingerProximalOffset)
    scale([scaleW,scale,scale]) DavidFingerProximal();
    translate(davidFingerDistalOffset) translate([0,+explode,0])
    scale([scaleW,scale,scale]) rotate([0,180,90]) DavidFingerDistal();
}

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//
//      Raptor
//
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

module DrawHandRaptor() {
    echo("DrawHandRaptor()");
    echo("raptorGauntletType", raptorGauntletType);

    mirror([prostheticHand, 0, 0])
    translate([0, -explode, 0]) {
        if (raptorGauntletType == RaptorGauntlet)
            DrawRaptorGauntlet();
        else if (raptorGauntletType == RaptorGauntletNoSupports)
            DrawRaptorGauntletNoSupports();
        else if (raptorGauntletType == RaptorGauntletFlared)
            DrawRaptorGauntletFlared();
        else if (raptorGauntletType == RaptorGauntletFlaredNoSupports)
            DrawRaptorGauntletFlaredNoSupports();
    }
}

module DrawRaptorGauntlet() {
    echo("DrawRaptorGauntlet()");

    color("blue")
    scale([scaleW, scale, scale])
    EH2Gauntlet(measurements, padding, support=1, flare=0);

    for(i=[0:1]) {
        DrawRaptorHingePin(i);
        DrawRaptorHingeCap(i);
    }
    DrawRaptorDoveTail();
    DrawRaptorTensioner();
    DrawRaptorPalm();
}

module DrawRaptorGauntletNoSupports() {
    echo("DrawRaptorGauntletNoSupports()");

    color("blue")
    scale([scaleW, scale, scale])
    EH2Gauntlet(measurements, padding, support=0, flare=0);

    for(i=[0:1]) {
        DrawRaptorHingePin(i);
        DrawRaptorHingeCap(i);
    }
    DrawRaptorDoveTail();
    DrawRaptorTensioner();
    DrawRaptorPalm();
}

module DrawRaptorGauntletFlared() {
    echo("DrawRaptorGauntletFlared()");

    color("blue")
    scale([scaleW, scale, scale])
    EH2Gauntlet(measurements, padding, support=1, flare=1);

    for(i=[0:1]) {
        DrawRaptorHingePin(i);
        DrawRaptorHingeCap(i);
    }
    DrawRaptorDoveTail();
    DrawRaptorTensioner();
    DrawRaptorPalm();
}

module DrawRaptorGauntletFlaredNoSupports() {
    echo("DrawRaptorGauntletFlaredNoSupports()");

    color("blue")
    scale([scaleW, scale, scale])
    EH2Gauntlet(measurements, padding, support=0, flare=1);

    for(i=[0:1]) {
        DrawRaptorHingePin(i);
        DrawRaptorHingeCap(i);
    }
    DrawRaptorDoveTail();
    DrawRaptorTensioner();
    DrawRaptorPalm();
}

module DrawRaptorHingePin(i=0) {
    color("white") 
    translate(wristControl) 
    translate([(-19*scaleW)*(i-0.5)*2, 0, -3*scaleW])
    rotate(180-180*i, [0, 0, 1])
    difference()
    {
        EHhingePins(EHscale, EHscaleW);
        
        translate([11, 0, 3])
        cube([20, 10, 10], center=true);
    }
}

module DrawRaptorHingeCap(i=0) {
    color("white") 
    translate(wristControl)
    translate([-28*scaleW*(i-0.5)*2, 0, -8*scaleW]) 
    rotate(180-180*i, [0, 0, 1])
    rotate([0,-90, 0])
    difference()
    {
        EHhingeCaps(EHscale, EHscaleW);
        
        translate([-10, 0, 2.5])
        cube([20, 20, 10], center=true);
    }
}

module DrawRaptorDoveTail() {
    color("red") 
    translate([0,-68*scale, 23.2*EHscale]) 
    rotate([180,0,0])
    EHdovetail(EHscale, EHscaleW, flare=flare);
}

module DrawRaptorTensioner() {
    color("red") 
    translate([0,-56*scale, 25*scale]) 
    rotate([-90,0,0])
    EHtensioner(EHscale, EHscaleW);
    
    for(i=[0:4])
        DrawRaptorHexPin(i);
}

module DrawRaptorHexPin(i=0) {
    color("white")
    translate([0,-40*EHscaleW,25*EHscale])
    EHhexPins(EHscale, EHscaleW);
}

module DrawRaptorPalm() {
    palmColor = "blue";
    
    if (palmSelect == 5)
        color(palmColor)
        EHLeftPalm(assemble=true,  wrist=wristControl, 
            knuckle=knuckleControl, measurements=measurements,
            label=label, font=font, support=1);
    if (palmSelect == 6)
        color(palmColor)
        EHLeftPalm(assemble=true, wrist=wristControl, 
            knuckle=knuckleControl, measurements=measurements,
            label=label, font=font, support=0);
    if (palmSelect == 7)
        color(palmColor)
        EHLeftPalm(assemble=true, wrist=wristControl, 
            knuckle=knuckleControl, measurements=measurements, 
            label=label, font=font, support=1, thumb=0);
    if (palmSelect == 8)
        color(palmColor)
        EHLeftPalm(assemble=true, wrist=wristControl, 
            knuckle=knuckleControl, measurements=measurements, 
            label=label, font=font, support=0, thumb=0);
    if (palmSelect == 9)
        color(palmColor)
        EHLeftPalm(assemble=true, wrist=wristControl, 
            knuckle=knuckleControl, measurements=measurements, 
            label=label, font=font, support=1, thumb=1, mount=1);
    if (palmSelect == 10)
        color(palmColor)
        EHLeftPalm(assemble=true, wrist=wristControl, 
            knuckle=knuckleControl, measurements=measurements, 
            label=label, font=font, support=1, thumb=1, mount=0, 
            demoHand=1);
    
    DrawRaptorKnucklePin();
    DrawRaptorThumbPin();
    echo("EHProximale scale ",[EHscaleW,EHscale,EHscale]);
    for(i=[0:4])
        if (i<4)
            translate(knuckleControl) 
            translate([-fingerSpacing*scaleW*(i-1.55), 0, -2*scale])
            scale([EHscaleW,EHscale,EHscale])
            DrawRaptorProximal(i);
        else
            mirror([prostheticHand,0,0])
            translate([thumbControl[0]*scaleW, 
                thumbControl[1]*scale, 
                thumbControl[2]*scale]) 
            rotate(thumbRotate)     
            scale([EHscaleW,EHscale,EHscale])
            DrawRaptorProximal(i);
}

module DrawRaptorKnucklePin() {
    color("white")
    translate(knuckleControl) 
    translate([0,0,-2*scale]) 
    EHknucklePins(EHscale, EHscaleW);
}

module DrawRaptorThumbPin() {
    mirror([prostheticHand,0,0]) 
    translate([thumbControl[0]*scaleW, 
        thumbControl[1]*scale, 
        thumbControl[2]*scale]) 
    rotate(thumbRotate)
    translate([0, 0, -2.3*scale])
    rotate([0, 0, 180]) 
    color("white") 
    EHthumbPin(EHscale,EHscaleW);
}

module DrawRaptorProximal(i=0) {
    echo("EH fingers spacing ",fingerSpacing, scaleW);
    
    color("white")
    EHProximalPhalange();
    
    DrawRaptorFingerPin();
    DrawRaptorFingerTip();
}

module DrawRaptorFingerPin() {
    translate([0, EHproxLen*scale, -1])
    rotate([0, 0, 180])
    color("white")
    EHfingerPin(EHscale, EHscaleW);
}

module DrawRaptorFingerTip() {
    translate([0, EHproxLen*scale, 0])
    scale([scaleW, scale, scale])
    color("red")
    EHFingertip();
}

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//
//      Raptor Reloaded
//
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
// 
// unused STL files
// 
// raptor_reloaded_right_palm.stl
// raptor_reloaded_right_palm_support.stl
//
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

module DrawHandRaptorReloaded() {
    echo("DrawHandRaptor()");
    echo("raptorGauntletType", raptorGauntletType);

    mirror([prostheticHand, 0, 0])
        DrawRaptorReloadedGauntlet();
}

module DrawRaptorReloadedGauntlet() {
    echo("DrawRaptorGauntlet()");

    color("blue")
    scale([scaleW, scale, scale])
    union()
    {
        import("../RaptorReloaded/raptor_reloaded_gauntlet.stl");
        if (gauntletSupport)
            import("../RaptorReloaded/raptor_reloaded_gauntlet_support.stl");
    }
    
    for(i=[0:1]) {
        DrawRaptorReloadedHingePin(i);
        DrawRaptorReloadedHingeCap(i);
    }
    DrawRaptorReloadedRetentionClip();
    DrawRaptorReloadedTensioner();
    DrawRaptorReloadedPalm();
}

module DrawRaptorReloadedHingePin(i=0) {
    translate(wristControl) 
    scale([scaleW, scale, scale])
    rotate(180*i, [0, 0, 1])
    color("white") 
    import("../RaptorReloaded/raptor_reloaded_wrist_pin.stl");
}

module DrawRaptorReloadedHingeCap(i=0) {
    translate(wristControl)
    scale([scaleW, scale, scale])
    rotate(180*i, [0, 0, 1])
    color("white") 
    import("../RaptorReloaded/raptor_reloaded_wrist_pin_cap.stl");
}

module DrawRaptorReloadedRetentionClip() {
    color("red")
    scale([scaleW, scale, scale])
    import("../RaptorReloaded/raptor_reloaded_retention_clip.stl");
}

module DrawRaptorReloadedTensioner() {
    color("red") 
    scale([scaleW, scale, scale])
    import("../RaptorReloaded/raptor_reloaded_tensioner.stl");
    
    for(i=[0:4])
        DrawRaptorReloadedTensionerPin(i);
}

module DrawRaptorReloadedTensionerPin(i=0) {
    translate([-i*6*scaleW, 10, 0])
    scale([scaleW, scale, scale])
    color("white")
    import("../RaptorReloaded/raptor_reloaded_tensioner_pin.stl");
}

module DrawRaptorReloadedPalm() {
    mirror([prostheticHand,0,0])
    scale([scaleW, scale, scale])
    color("blue")
    union()
    {
        import("../RaptorReloaded/raptor_reloaded_left_palm.stl");
        if (palmSupport)
            import("../RaptorReloaded/raptor_reloaded_left_palm_support.stl");
    }
    
    for (i=[0:1])
        DrawRaptorReloadedKnucklePin(i);
    DrawRaptorReloadedThumbPin();

    scale([scaleW, scale, scale])
    for(i=[0:4])
        if (i<4)
            translate(knuckleControl) 
            translate([-fingerSpacing*scaleW*(i-1.55)*0.6, -19*scale, -2*scale])
            DrawRaptorReloadedProximal(i);
        else
            mirror([prostheticHand,0,0])
            translate([30*scaleW, 30*scale, 0*scale]) 
            rotate(thumbRotate)
            DrawRaptorReloadedProximal(i);
}

module DrawRaptorReloadedKnucklePin(i=0) {
    translate(knuckleControl) 
    translate([-i*0*scaleW, 62*i+84*(i-1)*scale, 0*scale]) 
    scale([scaleW, scale, scale])
    rotate(180*i, [0, 0, 1])
    color("white")
    import("../RaptorReloaded/raptor_reloaded_knuckle_pin.stl");
}

module DrawRaptorReloadedThumbPin() {
    mirror([prostheticHand, 0, 0]) 
    scale([scaleW, scale, scale])
    rotate(-13, [0, 1, 0])
    rotate(90, [0, 0, 1])
    rotate(thumbRotate)
    color("white") 
    import("../RaptorReloaded/raptor_reloaded_thumb_pin.stl");
}

module DrawRaptorReloadedProximal(i=0) {
    color("white")
    import("../RaptorReloaded/raptor_2.0_proximal.stl");
    
    DrawRaptorReloadedFingerPin();
    DrawRaptorReloadedFingerTip();
}

module DrawRaptorReloadedFingerPin() {
    translate([0, 22.5, -1.5])
    rotate(90, [0, 0, 1])
    color("white")
    import("../RaptorReloaded/raptor_2.0_finger_pin.stl");
}

module DrawRaptorReloadedFingerTip() {
    translate([0, 22.5, 0])
    rotate(180, [0, 1, 0])
    color("red")
    import("../RaptorReloaded/raptor_2.0_fingertip.stl");
}










// debug values
//fingerSelect = 4;
//palmSelect = 6;
//gauntletSelect = 4;
//prostheticHand = 1;

module assembled(CBscale, CBscaleW, CCBscale, CCBscaleW, EHscale, EHscaleW, scale, scaleW, explode=0, flare=0, mount=0, gauntlet=1) {
    echo(str("Rendering ", explode?"exploded":"assembled", " view."));
    echo(str("CB scale [",CBscale,CBscaleW,"]"));
    echo(str("CCB scale [",CCBscale,CCBscaleW,"]"));
    echo(str("EH scale [",EHscale,EHscaleW,"]"));
    echo(str("scale [",scale,scaleW,"]"));
    // scaling for selected palm

    if (showControls) %showControlPoints();
    
    if (isRaptor) {
        echo("*** assembling Raptor pins");
        echo("wrist ",wristControl);
        echo("knuckle ",knuckleControl);
        if (gauntlet) {
            color("green") 
            translate(wristControl) 
            translate([-21*scaleW+explode,0,-3*scaleW])
            EHhingePins(EHscale, EHscaleW);
            
            color("green") 
            translate(wristControl) 
            translate([-32*scaleW-0.5*explode,0,-7*scaleW]) 
            rotate([0,-90,0])
            EHhingeCaps(EHscale, EHscaleW);
            
            color("red") 
            translate([0,-56*scale-4*explode, 25*scale]) 
            rotate([-90,0,0])
            EHtensioner(EHscale, EHscaleW);
            
            color("orange") 
            translate([0,-68*scale-4.5*explode,23.2*EHscale]) 
            rotate([180,0,0])
            EHdovetail(EHscale, EHscaleW, flare=flare);
            
            color("green")
            translate([0,-40*EHscaleW+1.5*explode,24*EHscale])
            EHhexPins(EHscale, EHscaleW);
        }
        
        color("green")
        translate(knuckleControl) 
        translate([-1-1.8*explode*EHscaleW,0,-4*scale]) 
        EHknucklePins(EHscale, EHscaleW);
        
        if (haveThumb) 
            mirror([prostheticHand,0,0]) 
            translate([thumbControl[0]*scaleW,thumbControl[1]*scale,thumbControl[2]*scale]) 
            rotate(thumbRotate)
            color("green") 
            translate([-1.5*explode,0,-1.25*scale])
            rotate([0,0,180]) 
            EHthumbPin(EHscale,EHscaleW);
    }
    // Four Fingers
    //echo("FINGERS");
    //echo(fingerSpacing);
    translate(knuckleControl) {
        // assemble the fingers
        if (isRaptor) { // e-NABLE Hand 2.0 uses distinct fingers
            echo("EH fingers spacing ",fingerSpacing, scaleW);
            translate([-1.5*fingerSpacing*scaleW,0+explode,-2*scale]) {
                echo("EHProximale scale ",[EHscaleW,EHscale,EHscale]);
                color("yellow") scale([EHscaleW,EHscale,EHscale]) EHProximalPhalange();
                color("green") translate([0,EHproxLen*scale+explode,-1]) rotate([0,0,180]) EHfingerPin(EHscale, EHscaleW);
                color("orange") translate([0,EHproxLen*scale+2*explode,0]) scale([scaleW,scale,scale]) EHFingertip(1);
            }
            translate([-.5*fingerSpacing*scaleW,0+explode,-2*scale]) {
                color("yellow") scale([EHscaleW,EHscale,EHscale])  EHProximalPhalange();
                color("green") translate([0,EHproxLen*scale+explode,-1]) rotate([0,0,180]) EHfingerPin(EHscale, EHscaleW);
                color("orange") translate([0,EHproxLen*scale+2*explode,0]) scale([scaleW,scale,scale]) EHFingertip(2);
            }
            translate([.5*fingerSpacing*scaleW,0+explode,-2*scale]) {
                color("yellow") scale([EHscaleW,EHscale,EHscale])  EHProximalPhalange();
                color("green") translate([0,EHproxLen*scale+explode,-1]) rotate([0,0,180]) EHfingerPin(EHscale, EHscaleW);
                color("orange") translate([0,EHproxLen*scale+2*explode,0]) scale([scaleW,scale,scale]) EHFingertip(3);
            }
            translate([1.5*fingerSpacing*scaleW,0+explode,-2*scale]) {
                color("yellow") scale([EHscaleW,EHscale,EHscale])  EHProximalPhalange();
                color("green") translate([0,EHproxLen*scale+explode,-1]) rotate([0,0,180]) EHfingerPin(EHscale, EHscaleW);
                color("orange") translate([0,EHproxLen*scale+2*explode,0]) scale([scaleW,scale,scale]) EHFingertip(2);
            }
        }
        else { // Other hands use the same finger four times
            for (fX = [-1.5:1:1.5]) {
                translate([fX*fingerSpacing*scaleW, explode, 0]) {
                    if (cyborgFingers) {
                        echo(str("cyborg beast fingers scale ",str(scale*100),"% scale width ",scaleW*100,"%."));
                        //sphere(10);
                        //translate(phalangeOffset)
                        if (palmSelect==1) { // Cyborg Beast
                            color("yellow") translate([0,-14*scale,0])
                            scale([CBscaleW,CBscale,CBscale])
                            CyborgProximalPhalange();
                            color("orange") translate([0,9*scale+explode,0])
                            scale([CBscaleW,CBscale,CBscale])
                            CyborgFinger(bump=(fingerSelect==CyborgBeastFingersBump));
                        }
                        if (palmSelect==4) { // Cyborg Beast No Thumb
                            color("yellow") translate([0,-7*scale,0])
                            scale([CBscaleW,CBscale,CBscale])
                            CyborgProximalPhalange();
                            color("orange") translate([0,17*scale+explode,0])
                            scale([CBscaleW,CBscale,CBscale])
                            CyborgFinger(bump=(fingerSelect==CyborgBeastFingersBump));
                        }
                        //color("yellow") translate([0,-14*scale,0]) scale([CBscaleW,CBscale,CBscale]) CyborgProximalPhalange();
                        //translate(fingerOffset)
                        //color("orange") translate([0,17*scale+explode,0])
                        //rotate([0,180,0])
                        //    scale([CBscaleW,CBscale,CBscale]) CyborgFinger(bump=(fingerSelect==CyborgBeastFingersBump));
                    }
                    if (fingerSelect==DavidFingers) {
                        echo("david fingers");
                        translate(davidFingerProximalOffset)
                        scale([scaleW,scale,scale]) DavidFingerProximal();
                        translate(davidFingerDistalOffset) translate([0,+explode,0])
                        scale([scaleW,scale,scale]) rotate([0,180,90]) DavidFingerDistal();
                    }
                    if (fingerSelect==3) {
                        echo(str("Creo beast fingers scale ",scale*100,"% scale W ",scaleW*100,"%."));
                        scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgProximalPhalange();
                        translate([0,29*CCBscale+explode,0]) scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgFinger();
                    }
                    // ADD FINGERS HERE
                }
            }
        }
    }

    // palm
    
    color("orange") {
        if (isCB) {
            echo("SCALE PALM ",CBscaleW,CBscale);
            rotate([1,0,0]) scale([CBscaleW,CBscale,CBscale])
            CyborgLeftPalm(assemble=true, wrist=wristControl,
                           knuckle=knuckleControl, measurements=measurements,
                           label=label, font=font, thumb=haveThumb);
        }

        if (palmSelect == CBParametricPalm) {
            echo("cyborg beast parametric palm");
            CyborgBeastParametricPalm(assemble=true, wrist=wristControl,
                                      knuckle=knuckleControl, measurements=measurements,
                                      label=label, font=font);
        }
        if (palmSelect == 3)
            CreoCyborgLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements,
                               label=label, font=font);
        if (palmSelect == 5)
            EHLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements,
                       label=label, font=font, support=1);
        if (palmSelect == 6)
            EHLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements,
                       label=label, font=font, support=0);
        if (palmSelect == 7)
            EHLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=1, thumb=0);
        if (palmSelect == 8)
            EHLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=0, thumb=0);
        if (palmSelect == 9)
            EHLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=1, thumb=1, mount=1);
        if (palmSelect == 10)
            EHLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=1, thumb=1, mount=0, demoHand=1);

        // ADD PALMS HERE
    }

    // For the cyborg beast palm the thumb is here:

    thPhalangeLen = thumbPhalangeLen; // from import

    // Draw thumb. Mirror if rendering right hand. Use only for preview, not for compiled parts.
    if (haveThumb) mirror([prostheticHand,0,0]) translate([thumbControl[0]*scaleW+explode,thumbControl[1]*scale,thumbControl[2]*scale]) rotate(thumbRotate) {
        if (fingerSelect==3) {
            color("yellow") scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgThumbPhalange();
            color("orange") translate([0,31*CCBscaleW+2*explode,0])
            scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgThumbFinger();
        }
        else if (fingerSelect==1) translate([0,1,0]) {
            color("yellow") scale([CBscaleW,CBscale,CBscale]) CyborgThumbPhalange();
            color("orange") translate([0,22*CBscaleW+2*explode,0])
            scale([CBscaleW,CBscale,CBscale]) CyborgThumbFinger();
        }
        else if (fingerSelect==4) {
            color("yellow") scale([EHscale,EHscaleW,EHscaleW]) EHProximalPhalange();
            color("orange") translate([0,EHproxLen*EHscaleW+explode,0])  scale([EHscale,EHscaleW,EHscaleW]) EHFingertip(2);
        }
        else if (fingerSelect==5) {
            color("yellow") scale([EHscale,EHscaleW,EHscaleW]) EHProximalPhalange();
            color("orange") translate([0,EHproxLen*EHscaleW+explode,0])  scale([EHscale,EHscaleW,EHscaleW]) EHFingertip(2);
        }
    }
    /***/
    echo("gauntlet scale ",scaleW);
    if (haveGauntlet) 
        mirror([prostheticHand,0,0])
        color("yellow")
        translate([0,-explode,0]) {
        
        if (gauntletSelect==1)
            scale([scaleW*.7,scale, scale]) translate(gauntletOffset) rotate([0,0,-90]) DavidGauntlet();
        if (gauntletSelect==2)
            scale([scaleW*.7,scale, scale]) KarunaGauntlet(measurements, padding);
        if (gauntletSelect==3)
            scale([scaleW,scale, scale]) EH2Gauntlet(measurements, padding, support=1);
        if (gauntletSelect==4)
            scale([scaleW,scale, scale]) EH2Gauntlet(measurements, padding, support=0);
        if (gauntletSelect==5)
            scale([scaleW,scale, scale]) EH2Gauntlet(measurements, padding, support=1, flare=1);
        if (gauntletSelect==6)
            scale([scaleW,scale, scale]) EH2Gauntlet(measurements, padding, support=0, flare=1);
        if (gauntletSelect==7)
            scale([scaleW,scale, scale]) CyborgGauntlet(thumb=(palmSelect==1));
        // ADD GAUNTLETS HERE
    }

    //%ModelArm(measurements);
    //showControlPoints();
}



/*  ~<{ Control Points }>~  */

module showControlPoints() {
    translate(wristControl) color("yellow") sphere(5);
    translate(knuckleControl) color("blue") sphere(15);
    translate(elbowControl) color("green") sphere(5);
    translate(thumbControl) color("red") sphere(5);
}




/*  ~<{ Error Routine }>~  */

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



