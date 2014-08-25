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

module KarunaGauntlet(
measurements=[[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],[1, 0, 0, 0, 0, 55, 0, 0, 55, 71, 0, 0, 0]], 
//	measurements=[ [0, 66.47, 64.04, 46.35, 35.14, 35.97, 31.05, 31.8, 40.97, 0, 147.5, 90, 90],  [0, 66.47, 64.04, 46.35, 35.14, 35.97, 31.05, 31.8, 40.97, 0, 72.5, 72.2, 230.6]],
	padding=5) {
	
	echo("Karuna's Short Gauntlet");
	echo("measurements",measurements);
	echo("padding",padding);
	hand=measurements[0][0];
	other=1-hand;
	targetWidth = measurements[other][8];
	echo("Karuna target width ",targetWidth);
	stlWidth = 50;
	scale = targetWidth/stlWidth;
	echo("target gauntlet outer width ",targetWidth);
	//%cube([targetWidth,5,5], center=true);
	scale(scale) rotate([0,0,180]) translate([6.4,-35,-6]) import("../Cyborg_Beast/STL Files/Karunas_Short_Gauntlet.stl");
}

//KarunaGauntlet();

