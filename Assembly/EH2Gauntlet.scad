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

// render e-NABLE Hand 2.0 gauntlet

module EH2Gauntlet(measurements, padding, support=1, flare=0) {
	echo("Enable Hand 2.0 Gauntlet");
	//import("../EH2.0/Gauntlet_2.6.stl");
	if (support && !flare) 
		import("../EH2.0/Gauntlet [x1].stl");
	if (!support && !flare)
		import("../EH2.0/Gauntlet (No Supports) [x1].stl");
	if (support && flare) 
		import("../EH2.0/Gauntlet_Flared(w_support).stl");
	if (!support && flare)
		import("../EH2.0/Gauntlet_Flared(no support).stl");

	}
	
	
//	-rw-r--r--  1 laird  505   551134 Sep 17 09:20 GauntletCap_Flared(no support).stl
//-rw-r--r--  1 laird  505   552334 Sep 17 09:20 GauntletCap_Flared(w_support).stl
//-rw-r--r--  1 laird  505  1851984 Sep 17 09:20 Gauntlet_Flared(no support).stl
//-rw-r--r--  1 laird  505  1877684 Sep 17 09:20 Gauntlet_Flared(w_support).stl
//
//

EH2Gauntlet(support=1, flare=0);
