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

module EH2OtherParts(scaleL=1, scaleW=1) {
	s = max(scaleL, scaleW);
	
	echo("Enable Hand 2.0 other parts scaleL ",scaleL, " scaleW ",scaleW, " s ",s);
	translate([0,0,1.67]) {
		translate([0,8*s]) scale([scaleW,scaleL,scaleL])
			import("../EH2.0/ThumbPin [x1].stl");
		translate([0,-11*s])  scale([scaleW,scaleL,scaleL])
			import("../EH2.0/Knuckle_Pins [x1].stl");
		for (x=[-20:10:20]) translate([x,60*s,0]) rotate([0,0,90]) 
			scale([scaleW,scaleL,scaleL])
			import("../EH2.0/Finger_Snap_Pin [x5].stl");
	}
	translate([0,45*s]) scale([scaleW,scaleL,scaleL]) 
		import("../EH2.0/Tensioner [x1].stl");
	translate([0,-22*s]) scale([scaleL, scaleL, scaleW]) 
		import("../EH2.0/HingeCaps [x1].stl");
	translate([0,-35*s]) scale([scaleW,scaleL,scaleL]) 
		import("../EH2.0/HingePins [x1].stl");
	translate([0,27*s,0]) scale([scaleW,scaleL,scaleL]) 
		import("../EH2.0/Hexpins [x1].stl");
	translate([0,4*s,0]) scale([scaleW,scaleL,scaleL]) 
		import("../EH2.0/DovetailCap_(Option 2) [x1].stl");
}

//EH2OtherParts(scaleL=1,scaleW=1);