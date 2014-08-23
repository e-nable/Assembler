module KarunaGauntlet(measurements=[ [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, 90], [1, 0, 0, 0, 0, 55, 0, 0, 55, 71, 0, 90, 90]],
	//[0, 66.47, 64.04, 46.35, 35.14, 35.97, 31.05, 31.8, 40.97, 0, 147.5, 90, 90],  [0, 66.47, 64.04, 46.35, 35.14, 35.97, 31.05, 31.8, 40.97, 0, 72.5, 72.2, 230.6]], 
	padding=5) {
	
	echo("Karuna's Short Gauntlet");
	echo("measurements",measurements);
	echo("padding",padding);
	hand=measurements[0][0];
	targetWidth = 56;
	stlWidth = 50;
	scale = targetWidth/stlWidth;
	echo("target gauntlet outer width ",targetWidth);
	//%cube([targetWidth,5,5], center=true);
	scale(scale) rotate([0,0,180]) translate([6.4,-35,-6]) import("../Cyborg_Beast/STL Files/Karunas_Short_Gauntlet.stl");
}

//KarunaGauntlet();