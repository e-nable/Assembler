// Load STL, scale to fit wrist and knuckle control points

/*
This is a wrapper around CyborgLeftPalm.STL, which is responsible for:

module CyborgLeftPalm:
- Placing the part into an assembly by aligning to the provided control point, if assemble=true
- Calls CyborgLeftPalmInner for everything else

module CyborgLeftPalmInner:
- move the rear control point to 0,0,0 so that positioning is consistent, scaling is predictable, etc.
- scales part in Y and Z so that the part fits the length between control points
- Does not scale part in X (width), so that connection widths are not changed.
- Add text label to part. inside knuckle block

Assumptions:
- Control points are linear (elbow, wrist, knuckles). IF that's not true, the math gets a little harder.
- Scale the part in Y and Z the same (i.e. it gets taller as it gets longer).
- Don't scale X (width)

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

showPercentages = 0; // 1 to show percentages

//echo ("scale ",scale," scalew ",scalew);

// Comment this out to use in assembly
//EHLeftPalm(assemble=true, measurements=[ [1, 66.47, 64.04, 46.95, 35.14, 35.97, 27.27, 31.8, 40.97, 31.06, 147.5, 90, 90],  [0, 62.67, 65.62, 59.14, 48.78, 51.85, 16.4, 0, 72.52, 72.23, 230.6, 90, 90]], padding=5);

module EHLeftPalm(assemble=false, wrist=[0,0,0], knuckle=[0, 51.85, 0], measurements, label="http://eNABLE.us/NCC1701/1", font="Letters.dxf", padding=5) {
	//echo("cyborg beast palm");
	if (assemble==false) 
		EHLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
			measurements=measurements, label=label, font=font, padding=padding);
	if (assemble==true) 
		translate(wrist) 
			EHLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
				measurements=measurements, label=label, font=font, padding=padding);
	}


	function EHScaleLen(targetLen) = targetLen/67.5; //54=length in STL
	
function EHScaleWidth(targetWidth) = targetWidth/70; //50=width in STL

//echo("scale for 54 ",CBScaleLen(54));
//echo("scale for 70 ",CBScaleLen(70));

module EHLeftPalmInner(wrist, knuckle, measurements, label, font, padding=5) {
	//echo("wrist",wrist);
	//echo("knuckle",knuckle);
	//echo("cyborg beast palm inner");s
	hand=measurements[0][0]; // which hand needs the prosthetic
	other=1-hand; // and which hand has full measurements
	echo ("target hand ",hand);
	targetWidth = measurements[other][8]+padding; // knuckle of full hand
	targetLen = knuckle[1]-wrist[1]+padding; // difference in Y axis

	// draw target width and length to check math
	//%translate([0,targetLen/2,-20]) cube([targetWidth, targetLen, 1], center=true);

//	echo("target len ",targetLen);
//	echo("target width ",targetWidth);
//	stlLen = 54; // length measured in STL (i.e. to scale from)
//	stlWidth = 50; // width measured in STL

	//translate([0,targetLen/2,0]) cube([targetWidth,targetLen,1], center=true);
	//sphere(5);
	scale = EHScaleLen(targetLen);//targetLen/stlLen;
	scaleW = EHScaleWidth(targetWidth); // targetWidth/stlWidth;

	//echo("in CB scale ",scale," scaleW ",scaleW);

	if (measurements[other][8]<1) {
		echo ("ERROR: Measurement 8, width of knuckles on full hand, is required to scale palm and gauntlet width.");
		%write("Measurement 8 required",h=7);
		}
	else if (targetLen < 1) {
		echo ("ERROR: Measurement 9, Distance from wrist to proximal end of 1st phalange on pinky side (Medial) of non-prosthetic hand, is required to scale palm length.");
		%write("Measurement 9 required",h=7);
		}
	else {

//	if (measurements[hand][5]<1) {
//		echo ("ERROR: Measurement 5, Wrist Joint distance from lateral to medial side of prosthetic hand, is required to scale palm and gauntlet width.");
//		%write("Measurement 5 required",h=7);
//		}
//	else if (targetLen < 1) {
//		echo ("ERROR: Measurement 9, Distance from wrist to proximal end of 1st phalange on pinky side (Medial) of non-prosthetic hand, is required to scale palm length.");
//		%write("Measurement 9 required",h=7);
//		}
//	else {
	
		if (showPercentages) {
			%translate([0,0,40*scale]) rotate([90,0,-90]) 
				write(str(floor(scale*100+.5),"%"), center=true, h=10, font=font);
			%translate([0,0,40*scale+15]) rotate([90,0,0]) 
				write(str(floor(scaleW*100+.5),"%"), center=true, h=10, font=font);
			}
	
		echo("Cyborg Beast Palm 1.4, X scale ",scale*100,"% Y scale ",scaleW*100,"%");
		scale([scaleW,scale,scale])
			union() {
	import("../EH2.0/EH2.0_Palm_Left [x1].stl");

/* HERE */
				//echo("Label ", label);
				//color("blue") translate([0,stlLen-10.5,0]) resize([42,1,8])
				//	rotate([90,0,0]) write(label, center=true, h=8, font=font);
				}
		//%cube([1,targetLen,20]); // show length of palm
		}
	}
