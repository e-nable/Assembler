// Load STL, scale to fit wrist and knuckle control points

/*
This is a wrapper around CyborgLeftPalm.STL, which is responsible for:

module CyborgLeftPalm:
- Placing the part into an assembly by aligning to the provided control point, if assemble=true
- Calls CyborgLeftPalmInner for everything else

module CyborgLeftPalmInner:
- move the rear control point to 0,0,0 so that positioning is consistent, scaling is predictable, etc.
- scales part in Y and Z so that the part fits the length between control points
- Does not scale part in X (width), so that connection widths are not changed.
- Add text label to part. inside knuckle block

Assumptions:
- Control points are linear (elbow, wrist, knuckles). IF that's not true, the math gets a little harder.
- Scale the part in Y and Z the same (i.e. it gets taller as it gets longer).
- Don't scale X (width)

*/

use <write/Write.scad>

//echo ("scale ",scale," scalew ",scalew);

// Comment this out to use in assembly
//CyborgNTLeftPalm(assemble=true, measurements=[ [0, 66.47, 64.04, 46.95, 35.14, 35.97, 27.27, 31.8, 40.97, 31.06, 147.5, 90, 90],  [1, 62.67, 65.62, 59.14, 48.78, 51.85, 16.4, 0, 72.52, 72.23, 230.6, 90, 90]], padding=5);

module CyborgNTLeftPalm(assemble=false, wrist=[0,0,0], knuckle=[0, 51.85, 0], measurements, label="http://eNABLE.us/NCC1701/1", font="Letters.dxf", padding=5) {
	//echo("cyborg beast palm");
	if (assemble==false) 
		CyborgNTLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
			measurements=measurements, label=label, font=font, padding=padding);
	if (assemble==true) 
		translate(wrist) 
			CyborgNTLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
				measurements=measurements, label=label, font=font, padding=padding);
	}

function CBScaleLen(targetLen) = targetLen/61; //54=length in STL
function CBScaleWidth(targetWidth) = targetWidth/50; //50=width in STL

//echo("scale for 54 ",CBScaleLen(54));
//echo("scale for 70 ",CBScaleLen(70));

module CyborgNTLeftPalmInner(wrist, knuckle, measurements, label, font, padding=5) {
	//echo("wrist",wrist);
	//echo("knuckle",knuckle);
//	CBLPwristOffset = [40,-25,1.5]; // from CB 1.3
//	CBLPwristOffset = [6,-5.4,-15.7]; // from CB 1.4
	CBLPwristOffset = [-.8,23.5,21.2]; // translate by this to move wrist to [0,0,0]
	//echo("cyborg beast palm inner");s
	hand=measurements[0][0]; // which hand needs the prosthetic
	other=1-hand; // and which hand has full measurements
	//echo ("target hand ",hand);
	targetWidth = measurements[hand][5]+2*padding+10; // inside of wrist
	targetLen = knuckle[1]-wrist[1]; // difference in Y axis
//	echo("target len ",targetLen);
//	echo("target width ",targetWidth);
//	stlLen = 54; // length measured in STL (i.e. to scale from)
//	stlWidth = 50; // width measured in STL

	//translate([0,targetLen/2,0]) cube([targetWidth,targetLen,1], center=true);
	//sphere(5);
	scale = CBScaleLen(targetLen);//targetLen/stlLen;
	scaleW = CBScaleWidth(targetWidth); // targetWidth/stlWidth;

	//echo("in CB scale ",scale," scaleW ",scaleW);

	if (measurements[hand][5]<1) {
		echo ("ERROR: Measurement 5, Wrist Joint distance from lateral to medial side of prosthetic hand, is required to scale palm and gauntlet width.");
		%write("Measurement 5 required",h=7);
		}
	else if (targetLen < 1) {
		echo ("ERROR: Measurement 9, Distance from wrist to proximal end of 1st phalange on pinky side (Medial) of non-prosthetic hand, is required to scale palm length.");
		%write("Measurement 9 required",h=7);
		}
	else {

		%translate([0,0,40*scale]) rotate([90,0,-90]) 
			write(str(floor(scale*100+.5),"%"), center=true, h=10, font=font);
		%translate([0,0,40*scale+15]) rotate([90,0,0]) 
			write(str(floor(scaleW*100+.5),"%"), center=true, h=10, font=font);
	
		echo("Cyborg Beast Palm 1.45 with thumb cutout, X scale ",scale*100,"% Y scale ",scaleW*100,"%");
		scale([scaleW,scale,scale])
			translate(CBLPwristOffset) union() {

/* 1.0 version
				import("../Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Left Palm 1.0 repaired.stl");
				import("Cyborg Left Palm 1.0.stl");
/**/
/* 1.3 version
				import("../Cyborg_Beast/STL Files/STL Files_ Marc Petrykowski_4-16-2014/Cyborg Left Palm 1.15.stl");
				import("Cyborg Left Palm 1.15.stl");
/* */
/* 1.1 fixed version 
				import("../Cyborg_Beast/STL Files/STL Files_ Marc Petrykowski_4-16-2014/Cyborg Left Palm 1.15_fixed.stl");
				import("Cyborg Left Palm 1.15_fixed.stl");
/* */
/* 1.4 version 
		import("../Cyborg_Beast/STL Files/Cyborg Hand 1.4/CB_1.45 palm (left).stl");
/* */
/* 1.45 version with thumb cutout */
		import("../Cyborg_Beast/STL Files/Cyborg Hand 1.45 No Thumb/Left Palm (Thumb Cut Out) 1.45.stl");
/* */

				//echo("Label ", label);
				//color("blue") translate([0,stlLen-10.5,0]) translate(-1*CBLPwristOffset) resize([42,1,8])
				//	rotate([90,0,0]) write(label, center=true, h=8, font=font);
				}
		//%cube([1,targetLen,20]); // show length of palm
		}
	}
