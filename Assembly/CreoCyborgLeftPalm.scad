// Load STL, scale to fit wrist and knuckle control points

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

This is a wrapper around CreoCyborgLeftPalm.STL, which is responsible for:

module CreoCyborgLeftPalm:
- Placing the part into an assembly by aligning to the provided control point, if assemble=true
- Calls CyborgLeftPalmInner for everything else

module CreoCyborgLeftPalmInner:
- move the rear control point to 0,0,0 so that positioning is consistent, scaling is predictable, etc.
- scales part in Y and Z so that the part fits the length between control points
- Does not scale part in X (width), so that connection widths are not changed.
- Add text label to part. inside knuckle block

Assumptions:
- Control points are linear (elbow, wrist, knuckles). IF that's not true, the math gets a little harder.
- Scale the part in Y and Z the same (i.e. it gets taller as it gets longer).
- Scale X to match gauntlet
- add padding to width of palm

*/

use <write/Write.scad>

// Comment this out to use in assembly
//CreoCyborgLeftPalm(assemble=true, measurements=[ [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, 90], [1, 0, 0, 0, 0, 55, 0, 0, 55, 71, 0, 90, 90]], padding=5);

//measurements=[ [0, 66.47, 64.04, 46.95, 35.14, 35.97, 27.27, 31.8, 40.97, 31.06, 147.5, 90, 90],  [1, 62.67, 65.62, 59.14, 48.78, 51.85, 16.4, 0, 72.52, 72.23, 230.6, 90, 90]], 

CreoThumbControl = [40,18+.5,2-3];
CreoThumbRotate = [0,13,-90];
CCBFingerSpacing = 17.5;

module CreoCyborgLeftPalm(assemble=false, wrist=[0,0,0], knuckle=[0, 51.85, 0], measurements, label="http://eNABLE.us/NCC1701/1", font="Letters.dxf", padding=5) {
	//echo("cyborg beast palm");
	if (assemble==false) 
		CreoCyborgLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
			measurements=measurements, label=label, font=font, padding=padding);
	if (assemble==true) 
		translate(wrist) 
			CreoCyborgLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
				measurements=measurements, label=label, font=font, padding=padding);
	}

function CCBScaleLen(targetLen) = targetLen/67; //67=length in STL
function CCBScaleWidth(targetWidth) = targetWidth/70; //62=width in STL

module CreoCyborgLeftPalmInner(wrist, knuckle, measurements, label, font, padding=5) {
	//echo("wrist",wrist);
	//echo("knuckle",knuckle);
	CBLPwristOffset = [0,71.75,31.5]; // translate by this to move wrist to [0,0,0]
	//echo("cyborg beast palm inner");
	//echo(measurements);
	hand=measurements[0][0]; // which hand needs the prosthetic
	other=1-hand; // and which hand has full measurements
	//echo ("target hand ",hand);
	targetWidth = measurements[other][8]+padding; // knuckle of full hand
	//echo("target width ",targetWidth);
	targetLen = knuckle[1]-wrist[1]+padding; // subtract y dimension

	// draw target width and length to check math
	//%translate([0,targetLen/2,-20]) cube([targetWidth, targetLen, 1], center=true);

	stlLen = 67; // length measured in STL (i.e. to scale from)
	//stlWidth = 62; // width measured in STL
	scale = CCBScaleLen(targetLen);
	scaleW = CCBScaleWidth(targetWidth);

	if (measurements[other][8]<1) {
		echo ("ERROR: Measurement 8, width of knuckles on full hand, is required to scale palm and gauntlet width.");
		%write("Measurement 8 required",h=7);
		}
	else if (targetLen < 1) {
		echo ("ERROR: Measurement 9, Distance from wrist to proximal end of 1st phalange on pinky side (Medial) of non-prosthetic hand, is required to scale palm length.");
		%write("Measurement 9 required",h=7);
		}
	else {
		//echo("target len ",targetLen);
		//echo("Palm inside target width ",targetWidth);
		//cube([targetWidth,1,5], center=true);
		//%translate([-targetWidth/2,0,0]) cube([targetWidth,targetLen,5]);
		//echo("target ",targetWidth,targetLen);

		%translate([0,0,40*scale]) rotate([90,0,-90]) 
			write(str(floor(scale*100+.5),"%"), center=true, h=10, font=font);
		%translate([0,0,40*scale+15]) rotate([90,0,0]) 
			write(str(floor(scaleW*100+.5),"%"), center=true, h=10, font=font);
	
		echo("Creo Cyborg Beast Palm, X scale ",scale*100,"% Y scale ",scaleW*100,"%");
		scale([scaleW,scale,scale])
			translate(CBLPwristOffset) union() {
				rotate([-90+1,0,0]) scale(24.9) import("../Cyborg_Beast/Creo_Cyborg_Beast/palm_lefthand.stl");
				echo("Label ", label);
				color("blue") translate([0,stlLen-17,0]) translate(-1*CBLPwristOffset) resize([42,1,8])
					rotate([90,0,0]) write(label, center=true, h=8, font=font);
				}
		//%cube([1,targetLen,20]); // show length of palm
		}
	}

