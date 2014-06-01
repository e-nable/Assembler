// load cyborg beast thumb finger, align to hinge, rotate straight

module CyborgThumbFinger() {
	echo("cyborg thumb finger 1.34");
	rotate([0,180,0]) rotate([0,0,-1.5]) translate([-22.7,-.5,-5]) import("../Cyborg_Beast/STL Files/Cyborg Hand 1.3/Cyborg Thumb Finger 1.34.stl");
	}

//CyborgThumbFinger();
