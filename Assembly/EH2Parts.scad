// render the "other" parts of the Enable Hand 2.0.

/*

This program assembles the components from various e-NABLE designs, and scales and arranges them based on measurements.

    Copyright (C) 2014, Laird Popkin

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

// render other pats
//
// scale by 'scale' along hand length, and 'scaleW' for hand width
//
// Plated module aligns the parts to a build plate.

// Uncomment one of the lines below to test:

//EH2OtherParts(scaleL=1.5601, scaleW=1.2053);
//EH2OtherParts(scaleW=1.5601, scaleL=1.2053);

module EH2OtherParts(scaleL=1, scaleW=1, assemble=0) {
	if (!assemble)
		EH2OtherPartsPlated(scaleL, scaleW);
}

module EH2OtherPartsPlated(scaleL, scaleW) {
	s = max(scaleL, scaleW);
	
	echo("Enable Hand 2.0 other parts scaleL ",scaleL, " scaleW ",scaleW, " s ",s);
	translate([0,0,2.25*scaleW]) {
		translate([0,12*s]) EHthumbPin(scaleL, scaleW);
		translate([0,-15*s,-.07]) EHknucklePins(scaleL, scaleW);
		for (x=[-20:10:20]) translate([x,58*s,0]) rotate([0,0,90]) 
			EHfingerPin(scaleL, scaleW);
	}
	translate([0,45*s]) EHtensioner(scaleL, scaleW);
	translate([0,-25*s]) EHhingeCaps(scaleL, scaleW);
	translate([0,-37*s]) EHhingePins(scaleL, scaleW);
	translate([0,27*s,0]) EHhexPins(scaleL, scaleW);
	translate([0,0*s,0]) EHdovetail(scaleL, scaleW);
	}

module EHtensioner(scaleL=1, scaleW=1) scale([scaleW,scaleL,scaleL]) 
		import("../EH2.0/Tensioner [x1].stl");

module EHhingeCaps(scaleL=1, scaleW=1) render() scale([scaleL, scaleL, scaleW]) 
		import("../EH2.0/HingeCaps-MM2 [x1].stl");

module EHhingePins(scaleL=1, scaleW=1) scale([scaleW,scaleL,scaleL]) 
		import("../EH2.0/HingePins [x1].stl");

module EHhexPins(scaleL=1, scaleW=1) scale([scaleW,scaleL,scaleL]) 
		import("../EH2.0/Hexpins [x1].stl");

module EHdovetail(scaleL=1, scaleW=1) scale([scaleW,scaleL,scaleL]) 
		import("../EH2.0/DovetailCap_(Option 2) [x1].stl");;

module EHfingerPin(scaleL=1, scaleW=1) scale([scaleW,scaleL,scaleL])
		import("../EH2.0/Finger_Snap_Pin [x5]_fixed.stl");

module EHknucklePins(scaleL=1, scaleW=1) scale([scaleW,scaleL,scaleL])
			import("../EH2.0/Knuckle_Pins [x1]_fixed.stl");

module EHthumbPin(scaleL=1, scaleW=1) scale([scaleW,scaleL,scaleL])
			import("../EH2.0/ThumbPin [x1].stl");

