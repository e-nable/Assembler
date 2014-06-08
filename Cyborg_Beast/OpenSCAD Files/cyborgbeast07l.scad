// Cyborg Beast parametric design by Maker Block
// Integrated into e-NABLE Assembler by Laird Popkin
//
// This library renders all of the Cyborg Beast Parametric design, either the whole thing or single parts.

//	To Do
//	- Add in support structures
//	- Optimize for scaling 105% to 150%

include <parts/cyborgpalm001.scad>
include <parts/cyborgfingertip002.scad>
include <parts/cyborgfingermid002.scad>

knuckleR = 4.85;
wristH = 10;
palmH = 20;
palmW = 64;
th = 3;
fn = 32; // facets in circle
sp = 14.4; // knuckle spacing

// uncomment to test
//CyborgBeastParametric(part=0);

// called by assembler, passing in all measurements

// part = [0:Assembled, 1:Gauntlet, 2:Palm, 3:Finger Proximal, 4:Finger Distal, 5:Thumb Proximal, 6:Thumb Distal]
// label is a text label to superimpose on the part for serializing
// font is the font to use

module CyborgBeastParametric(assemble=false, wrist=[0,0,0], knuckle=[0, 60/*51.85*/, 0], measurements, label, font="Letters.dxf", part=0) {
	palmLen = knuckle[1]-wrist[1];
	//color("blue") translate([0,0,-10]) cube([5,palmLen,5]);
	echo("Cyborg Beast Parametric version 07i, palm length ",palmLen);
	//echo("cyborg beast palm");
	if (assemble==false) 
		translate([0,palmLen-30,-5]) CyborgBeastParametricInner(palmLen=palmLen, part=part);
	if (assemble==true) 
		translate(wrist) 
			translate([0,palmLen-30,-5]) CyborgBeastParametricInner(palmLen=palmLen, part=part);
	}

module CyborgBeastParametricInner(palmLen=54, part=0) {
	echo("inner, palmLen ",palmLen," part ",part);

	//	Scaling from 105% up to 150%

	translate([0,0,0.02/2]) cube(0.02, center=true);

	//	translate([30,0,0]) fingertipexamples(1);
	
	if ((part==0) || (part==3) || (part==4) || (part==5) || (part==6))
		handlayout(sp, palmLen=palmLen, part=part);
	if (part==2) 
		cyborgbeastpalm(palmLen);
	}

// render palm and fingers with palm spacing (sp)

module handlayout(sp = 14.4, part=0, palmLen)
	{
	echo("sp ",sp);
	if ((part==0) || (part==2)) cyborgbeastpalm(palmLen);
	if ((part==0) || (part==3) || (part==4)) translate([22,31,10]) rotate([0,180,0]) 
		{
		translate([0,10,0]) render() fingerlayout(length=0, part=part);		//	Index finger
		translate([sp,12.5,0]) render() fingerlayout(length=7, part=part);	//	Middle finger
		translate([sp*2,12,0]) render() fingerlayout(length=5, part=part);	//	Ring finger
		translate([sp*3,7.5,0]) render() fingerlayout(length=-7.5, part=part);	//	Little finger
		}
	if ((part==0) || (part==5) || (part==6)) translate([41,-9.5,-4]) rotate([50,-20,90]) 
		{
		if ((part==0) || (part==5)) thumbmid();	//	Thumb mid
		if ((part==0) || (part==6)) translate([0,-18,5]) rotate([30,180,180]) thumbtip();	//	Thumb tip
		}
	}

module fingerlayout(size=1, length=0, part=0)
	{
	if ((part==0) || (part==4)) translate([0,23+length*2/3,1.5]) rotate([10,0,0]) fingertip(s=size, grip=1, len=length);
	if ((part==0) || (part==3)) mirror([0,0,1]) mirror([0,1,0]) translate([0,0,-10]) fingermid(s=size, len=length);
	}

*	translate([30,0,0]) fingermid(len=10);
*	translate([50,0,0]) fingermid(len=0);
*	translate([70,0,0]) fingermid(len=30);

module thumbmid()
	{ fingermid(len=-12); }

module thumbtip()
	{
	//	difference() {
	fingertip(len=-5, grip=1);
	//	translate([20/2,0,0]) cube([20,70,50], center=true); }
	}