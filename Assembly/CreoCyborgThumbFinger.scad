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

module CreoCyborgThumbFinger() {
	echo("creo cyborg thumb finger");
	translate([6,19.5,6.3]) rotate([-90,0,180]) scale(24.9) import("../Cyborg_Beast/Creo_Cyborg_Beast/thumb.stl");
	}

//CreoCyborgThumbFinger();
