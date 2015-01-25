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
showGuide = 0;
showHand = 0;
thumb=0;

// Comment this out to use in assembly
if (showHand) CyborgLeftPalm(assemble=true, measurements=[ [0, 66.47, 64.04, 46.95, 35.14, 35.97, 27.27, 31.8, 40.97, 31.06, 147.5, 90, 90],  [1, 62.67, 65.62, 59.14, 48.78, 51.85, 16.4, 0, 72.52, 72.23, 230.6, 90, 90]], padding=5, thumb=thumb, label="TEST");

<<<<<<< HEAD
module CyborgLeftPalm(assemble=false, wrist=[0,0,0], knuckle=[0, 51.85, 0], measurements, label="e-NABLE.me", font="Letters.dxf", padding=5, thumb=1) {
        label=""; // hack to block labels for now, fix ASAP
=======
module CyborgLeftPalm(assemble=false, wrist=[0,0,0], knuckle=[0, 51.85, 0], measurements, label="http://eNABLE.us/NCC1701/1", font="Letters.dxf", padding=5, thumb=1) {
        label=""; // force no label for DB for now
        //echo(measurements);
>>>>>>> dev
	//echo("cyborg beast palm");
	if (assemble==false) 
		CyborgLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
			measurements=measurements, label=label, font=font, padding=padding, thumb=thumb);
	if (assemble==true) 
		translate(wrist) 
			CyborgLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
				measurements=measurements, label=label, font=font, padding=padding, thumb=thumb);
	}

function CBScaleLen(targetLen) = targetLen/54; //54=length in STL
function CBScaleWidth(targetWidth) = targetWidth/56; //56=width in STL

CBThumbControl = [39.8,13.5,0]; 
CBThumbRotate = [-30,13,-90];
CBFingerSpacing = 14.5;

//echo("scale for 54 ",CBScaleLen(54));
//echo("scale for 70 ",CBScaleLen(70));

module CyborgLeftPalmInner(wrist, knuckle, measurements, label, font, padding=5, thumb=1) {
        hand = measurements[0][0];
        echo(str("Cyborg Beast Left Palm, ", thumb?"Thumb":"No Thumb", " hand ",hand));
	//echo("wrist",wrist);
	//echo("knuckle",knuckle);
//	CBLPwristOffset = [40,-25,1.5]; // from CB 1.3
	CBLPwristOffset = [6,-5.4,-15.7]; // translate by this to move wrist to [0,0,0]
	//echo("cyborg beast palm inner");s
	hand=measurements[0][0]; // which hand needs the prosthetic
	other=1-hand; // and which hand has full measurements
	echo ("target hand ",hand);
	//targetWidth = measurements[other][8]+padding; // knuckle of full hand
	//targetLen = knuckle[1]-wrist[1]+padding; // difference in Y axis

	// draw target width and length to check math
	///if(showGuide) %translate([0,targetLen/2,-20]) cube([targetWidth, targetLen, 1], center=true);

//	echo("target len ",targetLen);
//	echo("target width ",targetWidth);
//	stlLen = 54; // length measured in STL (i.e. to scale from)
//	stlWidth = 50; // width measured in STL

	//translate([0,targetLen/2,0]) cube([targetWidth,targetLen,1], center=true);
	//sphere(5);
	//scale = CBScaleLen(targetLen);//targetLen/stlLen;
	//scaleW = CBScaleWidth(targetWidth); // targetWidth/stlWidth;

	//echo("in CB scale ",scale," scaleW ",scaleW);

	if (measurements[other][8]<1) {
		echo ("ERROR: Measurement 8, width of knuckles on full hand, is required to scale palm and gauntlet width.");
		%write("Measurement 8 required",h=7);
		}
//	else if (targetLen < 1) {
//		echo ("ERROR: Measurement 9, Distance from wrist to proximal end of 1st phalange on pinky side (Medial) of non-prosthetic hand, is required to scale palm length.");
//		%write("Measurement 9 required",h=7);
//		}
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
	
//            if (showPercentages) {
//                %translate([0,0,40*scale]) rotate([90,0,-90]) 
//                    write(str(floor(scale*100+.5),"%"), center=true, h=10, font=font);
//                %translate([0,0,40*scale+15]) rotate([90,0,0]) 
//                    write(str(floor(scaleW*100+.5),"%"), center=true, h=10, font=font);
//                }
	
            echo(str("Cyborg Beast Palm 2.0, ",
                thumb?" Thumb.":" No Thumb."));
		//scale([scaleW,scale,scale])
                    translate(CBLPwristOffset) {
                        difference(convexity=20) {
/* 1.4 version */
    
            //import("../Cyborg_Beast/STL Files/Cyborg Hand 1.4/CB_1.45 palm (left).stl");
/* */
/* 2.0 version */
                            translate([-8.5-.5,70,33]) rotate([0,0,180]) {
                                if (thumb) {
                                    if (hand) {
                                       echo("/Cyborg_Beast_2/R palm.stl");
                                       import("../Cyborg_Beast_2/R palm.stl");
                                       }
                                    else {
                                        echo("/Cyborg_Beast_2/L palm.stl");
                                        import("../Cyborg_Beast_2/L palm.stl");
                                        }
                                    }
                                if (!thumb) {
                                    if (hand) {
                                    echo("/Cyborg_Beast_2/R no thumb palm.stl");
                                    translate([0,-6.5,0]) 
                                        import("../Cyborg_Beast_2/R no thumb palm.stl");
                                    }
                                    else {
                                    echo("/Cyborg_Beast_2/L no thumb palm.stl");
                                    translate([0,-6.5,0]) 
                                        import("../Cyborg_Beast_2/L no thumb palm.stl");
                                    }
                                }
<<<<<<< HEAD
/* */       
=======
                                }
    
>>>>>>> dev
                            if (len(label)>1) {
                                echo("Label ", label);
                                color("blue") translate([0,54-10.5+(1-thumb)*6.5,0]) translate(-1*CBLPwristOffset) resize([42,1,8])
                                    rotate([90,0,0]) write(label, center=true, h=8, font=font);
                                }
<<<<<<< HEAD
                            }
=======
                            } 
>>>>>>> dev
                        }
            //%cube([1,targetLen,20]); // show length of palm
            }
	}
