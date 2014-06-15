// load cyborg beast thumb phalange, align to hinge, rotate straight

thumbPhalangeLen = 22.7;

module CreoCyborgThumbPhalange() {
	echo("creo cyborg thumb phalange 1.34");
	translate([0,13,-6]) rotate([90,0,0]) scale(24.9)import("/Users/laird/src/e-NABLE-Assembler/Cyborg_Beast/Creo_Cyborg_Beast/thumb_mid_joint.stl");
	}

//CreoCyborgThumbPhalange();
