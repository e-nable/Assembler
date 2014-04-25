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

// Comment this out to use in assembly
CyborgLeftPalm(assemble=true);

module CyborgLeftPalm(assemble=false, wrist=[0,0,0], knuckle=[0, 51.85, 0], measurements, label="http://eNABLE.us/NCC1701/1", font="Letters.dxf") {
	//echo("cyborg beast palm");
	if (assemble==false) 
		CyborgLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
			measurements=measurements, label=label, font=font);
	if (assemble==true) 
		translate(wrist) 
			CyborgLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
				measurements=measurements, label=label, font=font);
	}

module CyborgLeftPalmInner(wrist, knuckle, measurements, label, font) {
	//echo("wrist",wrist);
	//echo("knuckle",knuckle);
	CBLPwristOffset = [40,-25,1.5]; // translate by this to move wrist to [0,0,0]
	//echo("cyborg beast palm inner");
	targetLen = knuckle[1]-wrist[1];
	//echo("target len ",targetLen);
	stlLen = 54; // length measured in STL (i.e. to scale from)
	scale = targetLen/stlLen;
	echo("Cyborg Beast Palm, scale ",scale*100,"% translate ",CBLPwristOffset);
	scale([1,scale,scale])
		translate(CBLPwristOffset) union() {
/* 1.0 version
			import("../Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Left Palm 1.0 repaired.stl");
			import("Cyborg Left Palm 1.0.stl");
/* */
/* 1.1 version */
			import("../Cyborg_Beast/STL Files/STL Files_ Marc Petrykowski_4-16-2014/Cyborg Left Palm 1.15.stl");
			import("Cyborg Left Palm 1.15.stl");
/* */
/* 1.1 fixed version 
			import("../Cyborg_Beast/STL Files/STL Files_ Marc Petrykowski_4-16-2014/Cyborg Left Palm 1.15_fixed.stl");
			import("Cyborg Left Palm 1.15_fixed.stl");
/* */
			echo("Label ", label);
			color("blue") translate([0,stlLen-10.5,0]) translate(-1*CBLPwristOffset) resize([42,1,8])
				rotate([90,0,0]) write(label, center=true, h=8, font=font);
			}
	//%cube([1,targetLen,20]); // show length of palm
	}

