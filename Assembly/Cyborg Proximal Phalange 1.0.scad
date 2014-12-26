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
    echo("Cyborg Beast 2.0 Phalance");
    //translate([-20.5,-37.3,-22]) import("../Cyborg_Beast/STL Files/Cyborg Hand 1.4/CB Phalange 1.4.stl");
    
    translate([0,22.5,0]) rotate([0,0,180]) translate([-4.6,11.8,18.1]) import("../Cyborg_Beast_2/FromMarc/finger phal.stl");
    //sphere(1);
    }

//CyborgProximalPhalange();
