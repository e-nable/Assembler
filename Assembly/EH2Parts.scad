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
//
// Note that the Hinge Caps must be rendered by themselves. I don't know why.
// So call EH2OtherParts for all but the hinge caps, or call EHhingeCaps by itself.

// Uncomment one of the lines below to test:

//EH2OtherParts(scaleL=2.57, scaleW=1.2053, thumb=0);
//EH2OtherParts(scaleW=2.57, scaleL=1.2053, thumb=1);
//EH2OtherParts(scaleL=1.5601, scaleW=1.2053, thumb=1);
//EH2OtherParts(scaleW=1.5601, scaleL=1.2053);
//EH2OtherParts(scaleW=1.7, scaleL=2.29421, flare=1);
//EH2OtherParts(scaleW=1, scaleL=2);

//translate([0,-25*1.5601]) EHhingeCaps(scaleL=1.5601, scaleW=1.2053);


module EH2OtherParts(scaleL=1, scaleW=1, assemble=0, thumb=1, flare=0) {
	if (!assemble)
		EH2OtherPartsPlated(scaleL, scaleW, thumb=thumb, flare=flare);
}

module EH2OtherPartsPlated(scaleL, scaleW, thumb=1, flare=0) {
	s = max(scaleL, scaleW);
	
	echo("Enable Hand 2.0 other parts scaleL ",scaleL, " scaleW ",scaleW, " s ",s);
	if (thumb) translate([0,12*s,0]) EHthumbPin(scaleL, scaleW);
	translate([0,-15*s,0]) EHknucklePins(scaleL, scaleW);
	translate([0,0,0]) {
		for (x=[-20:10:(thumb>0?20:10)]) translate([x*scaleL*.7,58*s,0]) rotate([0,0,90]) 
			EHfingerPin(scaleL, scaleW);
	}
	translate([0,45*s]) EHtensioner(scaleL, scaleW, thumb=thumb);
//	translate([0,-25*s]) EHhingeCaps(scaleL, scaleW);
	translate([0,-27*s]) EHhingePins(scaleL, scaleW);
	translate([0,27*s,0]) EHhexPins(scaleL, scaleW);
	translate([0,0*s,0]) EHdovetail(scaleL, scaleW, flare=flare);
	}

module EHtensioner(scaleL=1, scaleW=1, thumb=1) scale([scaleW,scaleL,scaleL]) {
	if (thumb) {
		import("../EH2.0/Tensioner [x1].stl");
		echo("Raptor Hand Tensioner [x1].stl");
		}
	//if (!thumb) import("../EH2.0/Tensioner_4
	if (!thumb) {
		import("/Users/laird/src/e-NABLE-Assembler/EH2.0/tensioner_4pin.stl");
		echo("Raptor Hand Tensioner_4pin.stl");
		}
	}

module EHhingeCaps(scaleL=1, scaleW=1) render() scale([scaleL, scaleL, scaleW]) 
	import("../EH2.0/HingeCaps-MM2 [x1].stl");

module EHhingePins(scaleL=1, scaleW=1) scale([scaleW,scaleL,scaleL]) 
	import("../EH2.0/HingePins [x1].stl");

module EHhexPins(scaleL=1, scaleW=1) scale([scaleW,scaleL,scaleL]) 
	import("../EH2.0/Hexpins [x1].stl");

module EHdovetail(scaleL=1, scaleW=1, flare=0) scale([scaleW,scaleL,scaleL]) {
	if (!flare)
		import("../EH2.0/DovetailCap_(Option 2) [x1].stl");
	if (flare)
		import("../EH2.0/GauntletCap_Flared(w_support).stl");
	}

module EHfingerPin(scaleL=1, scaleW=1) scale([scaleW,scaleL,scaleL])
	translate([0,0,1.7]) {
		import("../EH2.0/Finger_Snap_Pin [x5]_fixed.stl");
		//sphere(2);
	}

module EHknucklePins(scaleL=1, scaleW=1) scale([scaleW,scaleL,scaleL])
	translate([0,0,1.65]) {
		import("../EH2.0/Knuckle_Pins [x1]_fixed.stl");
	}

module EHthumbPin(scaleL=1, scaleW=1) scale([scaleL,scaleW,scaleW])
	translate([0,0,0]) {
		translate([0,0,1.7]) import("../EH2.0/ThumbPin [x1].stl");
	}

//EHdovetail();