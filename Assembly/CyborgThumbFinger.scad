// load cyborg beast thumb finger, align to hinge, rotate straight

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



module CyborgThumbFinger() {
	echo("cyborg thumb finger 1.34");
	rotate([0,180,0]) rotate([0,0,-1.5]) translate([3,14,.5]) import("../Cyborg_Beast/STL Files/Cyborg Hand 1.4/CB_1.45 Thumb Finger (no bumps).stl");
	//sphere(1);
	}

//CyborgThumbFinger();
