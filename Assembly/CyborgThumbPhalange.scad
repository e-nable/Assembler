// load cyborg beast thumb phalange, align to hinge, rotate straight

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

thumbPhalangeLen = 22.7;

module CyborgThumbPhalange() {
    echo("cyborg thumb phalange 1.34");
    //%rotate([0,0,180]) translate([0,-thumbPhalangeLen,0]) rotate([0,0,0]) translate([-39.7,-60,-17.5]) import("../Cyborg_Beast/STL Files/Cyborg Hand 1.4/CB Thumb Phalange 1.4.stl");
    translate([0,10.3,1.2]) import("../Cyborg_Beast_2/Thingiverse_Thumb_Phal.stl");

    }

//CyborgThumbPhalange();
