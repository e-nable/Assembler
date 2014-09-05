// Generate tensioner blocks. for e-NABLE Hand 2.0.

// reference a few related objects from the EH2.0 to check fit:

//import("/Users/laird/src/e-NABLE-Assembler/EH2.0/EH2.0_Tensioner [x1].stl");

//%difference() {
//	import("/Users/laird/src/e-NABLE-Assembler/EH2.0/Hexpins_2.6.stl");
//	}

x=4.7;
y=22.2;
z=2.85;
d=2;
o=2.4;
screwD = 2.4;
	
tensioners(2.25);

module tensioners(screwD=2.4) {
	assign(spacing=1.5*x) {
	echo(screwD, spacing);
	for (x2 = [-2*spacing:spacing:2*spacing]) translate([x2,0,0]) tensionerPin(screwD);
	}
}

module tensionerPin(screwD=2.4) {
	difference() {
		translate([0,0,z/2]) cube([x,y,z], center=true);
		translate([0,y/2-o,-1]) cylinder(d=d,h=20, $fn=16);
		translate([0,y/2-2*o,z/2]) rotate([90,0,0]) cylinder(d=screwD,h=20, $fn=16);
	}
	}