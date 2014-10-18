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

/* Raptor Hand fingertip

   size = 1 for short, 2 for medium, 3 for long.
   
*/

module EHFingertip(size=2, support=0) {
	if (size==1) import("../EH2.0/Finger_tip_short [x1].stl");
	if (size==2) import("../EH2.0/Finger_tip_medium [x3].stl");
	if (size==3) import("../EH2.0/Finger_tip_long [x1].stl");
	if (support) color("grey") {
		EHFingerSupports(size);
		mirror([1,0,0]) EHFingerLongSupports(size);
		}
	}

module EHFingerSupports(size) {
	translate([0,25-7.5+2.5*size,-3.75]) cube([.5,17,11]);
	}

	
//EHFingertip(size=3, support=1);
