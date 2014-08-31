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

module EH2OtherParts(scaleL=1, scalwW=1) {
	s = max(scaleL, scaleW);
	echo("Enable Hand 2.0 other parts scaleL ",scaleL, " scaleW ",scaleW, " s ",s);
	translate([0,45*s]) scale([scaleW,scaleL,scaleL]) import("../EH2.0/Tensioner_2.6.stl");
	translate([0,25*s,0]) scale([scaleW,scaleL,scaleL]) import("/Users/laird/src/e-NABLE-Assembler/EH2.0/Hexpins_2.6.stl");
	scale([scaleW,scaleL,scaleL]) import("/Users/laird/src/e-NABLE-Assembler/EH2.0/DovetailCap_2.6.stl");
	translate([0,-20*s]) scale([scaleL, scaleL, scaleW]) import("/Users/laird/src/e-NABLE-Assembler/EH2.0/Hingecap_2.6.stl");
	translate([0,-40*s]) scale([scaleW,scaleL,scaleL]) import("/Users/laird/src/e-NABLE-Assembler/EH2.0/Hingepin_2.6.stl");
}

//EH2OtherParts(scaleL=1,scaleW=1);