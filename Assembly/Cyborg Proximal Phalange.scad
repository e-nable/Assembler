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

module CyborgProximalPhalange() {
	//%translate([-20.5,-37.3,-22]) import("../Cyborg_Beast/STL Files/Cyborg Hand 1.4/CB Phalange 1.4.stl");
        translate([4.5,11,18]) 
            rotate([0,0,180]) import("../Cyborg_Beast_2/finger phal.stl");

	//sphere(1);
	}

//CyborgProximalPhalange();
