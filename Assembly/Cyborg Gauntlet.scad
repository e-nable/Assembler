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

use <write/Write.scad>

// Uncomment for testing this component, comment for use in assembly

//CyborgGauntlet(thumb=1, hand=0, label="NCC1701");

module CyborgGauntlet(thumb=1, hand=1, 
            label="http://eNABLE.us/NCC1701/1", font="Letters.dxf") {
//%	import("../Cyborg_Beast/STL Files/Cyborg_gauntlet_1.2__Ivan_.stl");
//%	import("../Cyborg_Beast/STL Files/hex_sleeve_solo.stl");
        echo(str("Cyborg Gauntlet 2.0, ",thumb?" Full":"No Thumb"));
        difference() {
            rotate([0,0,180]) translate([2.25,-63.5,15]) {
                if (thumb) {
                    if (hand) {
                        mirror([1,0,0]) import("../Cyborg_Beast_2/normal gauntlet.stl");
                        echo("Cyborg_Beast_2/normal gauntlet.stl");
                        }
                    else {
                        import("../Cyborg_Beast_2/normal gauntlet.stl");
                        echo("Cyborg_Beast_2/normal gauntlet.stl");
                        }
                    }
                if (!thumb) 
                    if (hand) { // right hand prosthetic
                        echo("Cyborg_Beast_2/R one hinge gauntlet.stl");
                        mirror([1,0,0]) translate([0,-7.7,2]) import("../Cyborg_Beast_2/R one hinge gauntlet (repaired).stl");
                        }
                    else {
                        translate([0,-7.7,2]) import("../Cyborg_Beast_2/L one hinge gauntlet (repaired).stl");
                        echo("Cyborg_Beast_2/L one hinge gauntlet.stl");
                    }
                }
            
            // add label
            if (len(label)>1) {
                if (thumb) {
                    echo("Label ", label);
                    color("blue") translate([-19-.6-hand*4.6,-20-18,-3]) rotate([10,0,94]) resize([35,2,6])
                        rotate([90,0,0]) //write(label, center=true, h=8, font=font);
                            linear_extrude(1) text(label);
                    }
                else {
                    echo("Label ", label);
                    color("blue") translate([-25-hand*4.6,-55,-3]) rotate([19,0,88]) resize([25,2,6])
                        rotate([90,0,0]) //write(label, center=true, h=8, font=font);
                            linear_extrude(1) text(label);
                }
                }
            }

	}


