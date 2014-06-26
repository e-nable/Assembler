// load cyborg beast thumb phalange, align to hinge, rotate straight

thumbPhalangeLen = 22.7;

module CyborgThumbPhalange() {
	echo("cyborg thumb phalange 1.34");
	rotate([0,0,180]) translate([0,-thumbPhalangeLen,0]) rotate([0,0,0]) translate([-39.7,-60,-17.5]) import("../Cyborg_Beast/STL Files/Cyborg Hand 1.4/CB Thumb Phalange 1.4.stl");
	}

//CyborgThumbPhalange();
