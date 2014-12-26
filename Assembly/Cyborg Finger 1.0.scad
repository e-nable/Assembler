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

module CyborgFinger(bump=1) {
    echo(str("Cyborg Beast 2.0 Finger", (bump==1)?" with bumps":" no bumps", "."));
    //%translate([-54.5,14,-4.6]) import("../Cyborg_Beast/STL Files/Cyborg Hand 1.4/CB Finger 1.41 (no bumps).stl");
    rotate([0,180,0]) 
        rotate([180,0,0]) translate([-4.9,11.9,18.1]) {
            if (bump==1) import("../Cyborg_Beast_2/FromMarc/finger w bumps.stl");
            if (bump==0) import("../Cyborg_Beast_2/FromMarc/finger wo bumps.stl");
        }

    }

//CyborgFinger(bump=1);
