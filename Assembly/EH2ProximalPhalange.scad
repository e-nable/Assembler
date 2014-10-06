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

module EHProximalPhalange(support=0) {
	import("../EH2.0/Proximal_Phalange [x5].stl");
	if (support) color("grey") {
		EHProximalSupports();
		mirror([1,0,0]) EHProximalSupports();
		}
	}

module EHProximalSupports() {
	translate([1.6,-4,-6]) cube([.5,4,3]);
	translate([1.6,23,-6]) cube([.5,4,3]);
	}
	
EHProximalPhalange(support=1);
