// load cyborg beast thumb finger, align to hinge, rotate straight

module CreoCyborgThumbFinger() {
	echo("creo cyborg thumb finger");
	translate([6,19.5,6.3]) rotate([-90,0,180]) scale(24.9) import("/Users/laird/src/e-NABLE-Assembler/Cyborg_Beast/Creo_Cyborg_Beast/thumb.stl");
	}

//CreoCyborgThumbFinger();
