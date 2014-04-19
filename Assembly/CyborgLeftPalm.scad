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

//use <write/write.scad>

module CyborgLeftPalm(assemble=false, wrist=[0,0,0], knuckle=[0, 51.85, 0], measurements, label="AB123-1") {
	//echo("cyborg beast palm");
	if (assemble==false) 
		CyborgLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
			measurements=measurements);
	if (assemble==true) 
		translate(wrist) 
			CyborgLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
				measurements=measurements);
	}

module CyborgLeftPalmInner(wrist, knuckle, measurements, label) {
	//echo("wrist",wrist);
	//echo("knuckle",knuckle);
	CBLPwristOffset = [37,-25,1.5]; // translate by this to move wrist to [0,0,0]
	CBLKnuckle = [0,30,0];
	//echo("cyborg beast palm inner");
	targetLen = knuckle[1]-wrist[1];
	//echo("target len ",targetLen);
	stlLen = 54;
	scale = targetLen/stlLen;
	echo("Cyborg Beast Palm, scale ",scale*100,"%");
	scale([1,scale,scale])
		translate(CBLPwristOffset) {

//			import("../Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Left Palm 1.0.stl");
			import("../Cyborg_Beast/STL Files/STL Files_ Marc Petrykowski_4-16-2014/Cyborg Left Palm 1.15.stl");
			import("Cyborg Left Palm 1.0.stl");
			write(label);
			}
	//%cube([1,targetLen,20]); // show length of palm
	}

//CyborgLeftPalm(assemble=true);
