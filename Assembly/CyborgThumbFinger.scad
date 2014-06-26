// load cyborg beast thumb finger, align to hinge, rotate straight

module CyborgThumbFinger() {
	echo("cyborg thumb finger 1.34");
	rotate([0,180,0]) rotate([0,0,-1.5]) translate([3,14,.5]) import("../Cyborg_Beast/STL Files/Cyborg Hand 1.4/CB_1.45 Thumb Finger (no bumps).stl");
	//sphere(1);
	}

//CyborgThumbFinger();
