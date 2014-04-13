// Load STL, scale to fit wrist and knuckle control points

module CyborgLeftPalm(assemble=false, wrist=[0,0,0], knuckle=[0,45,0]) {
	echo("cyborg beast palm");
	if (assemble==false) CyborgLeftPalmInner(assemble=false, wrist=[0,0,0], knuckle=[0,45,0]);
	if (assemble==true) 
		translate(wrist) CyborgLeftPalmInner(assemble=false, wrist=[0,0,0], knuckle=[0,45,0]);
	}

module CyborgLeftPalmInner(wrist=[0,0,0], knuckle=[0,45,0]) {
	CBLPwristOffset = [20,0,13]; // translate by this to move wrist to [0,0,0]
	CBLKnuckle = [0,30,0];
	echo("cyborg beast palm inner");

	targetLen = knuckle[1]-wrist[1];
	stlLen = 54;
	scale = targetLen/stlLen;
	scale(scale)
		translate(CBLPwristOffset) {

			import("Cyborg_Beast/STL Files/STL Files (Marc Petrykowsk)/Cyborg Left Palm 1.0.stl");
			import("Cyborg Left Palm 1.0.stl");
			}
	//%cube([1,targetLen,20]);
	}

CyborgLeftPalm(assemble=true);
