// Load STL, scale to fit wrist and knuckle control points

/*
This is a wrapper around CyborgLeftPalm.STL, which is responsible for:

module CyborgLeftPalm:
- Placing the part into an assembly by aligning to the provided control point, if assemble=true
- Calls CyborgLeftPalmInner for everything else

module CyborgLeftPalmInner:
- scales part in Y and Z so that the part fits the length between control points (wrist and knuckle)
- Scales part in X (width), so that the interior of the Palm fits around the hand (L/R8 of full hand)
- Adds text label (if provided) to part. inside knuckle block and on left and right side. Defaults to "http://w-nable.me".

Assumptions:
- Scales the part in Y and Z the same (i.e. it gets taller as it gets longer) so that the pin holes (side to side) are round

This program assembles the components from various e-NABLE designs, and scales and arranges them based on measurements.

Refer to each design for appropriate license terms, authorship, etc.

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

// configure for debugging, all should be - for use in assembly
showPercentages = 0; // 1 to show percentages
showGuide = 0;
showPart = 1; // 0 to use in assembly, 1 to render stand-alone for testing
demoHand = 0;
mount=0;	// 1 to put a PVC pipe mount
convexity = 10; // depth of preview rendering
support=0;
thumb=1;

/* parameters for mount */

bracketWall=5;
pvcD=19.5; // Diameter of hole for PVC (including clearance)
pvcR=pvcD/2;
down=-7.8;
pinD = 3; // 0 for no pin, otherwise diameter in mm
mountUp=pvcR+bracketWall/2;//pvcR+bracketWall;//down+pvcR+bracketWall;
//echo("DEBUG ",bracketWall,mount,pvcD,pvcR,down,mountUp);

//echo ("scale ",scale," scalew ",scalew);

// Comment this out to use in assembly
//if (showPart) RRLeftPalm(assemble=true, measurements=[ [1, 66.47, 64.04, 46.95, 35.14, 35.97, 27.27, 31.8, 40.97, 31.06, 147.5, 90, 90],  [0, 62.67, 65.62, 59.14, 48.78, 51.85, 16.4, 0, 72.52, 72.23, 230.6, 90, 90]], padding=5, support=1, thumb=1, mount=1);
if (showPart) RRLeftPalm(assemble=true, measurements=[ [1, 66.47, 64.04, 46.95, 35.14, 35.97, 27.27, 31.8, 40.97, 31.06, 147.5, 90, 90],  [0, 62.67, 65.62, 59.14, 48.78, 51.85, 16.4, 0, 70, 70, 230.6, 90, 90]],wrist=[0,0,0], knuckle=[0, 70, 0], padding=25, support=support, thumb=thumb, mount=mount, demoHand=demoHand, label="http://e-nable.me");

module RRLeftPalm(assemble=false, wrist=[0,0,0], knuckle=[0, 51.85, 0], measurements, label="http://e-nable.me", font="orbitron.dxf", padding=5, support=1, thumb=1, mount=0, demoHand=0) {
    echo(str("Raptor Hand palm, ", support?"Support, ":"No support, ",
             thumb?"Thumb.":"No thumb."));
    if (assemble==false)
        RRLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
                        measurements=measurements, label=label, font=font, padding=padding, support=support, thumb=thumb, mount=mount, demoHand=demoHand);
    if (assemble==true)
        translate(wrist)
        RRLeftPalmInner(assemble=false, wrist=wrist, knuckle=knuckle,
                        measurements=measurements, label=label, font=font, padding=padding, support=support, thumb=thumb, mount=mount, demoHand=demoHand);
}

// Scale length and width by the same amount

function RRScaleLen(targetLen) = targetWidth/55;//targetLen/67.3;
function RRScaleWidth(targetWidth) = targetWidth/55; //70=outside matches target, 55=inside matches target

RRThumbControl = [39.8-3,33.5-.5+13-16.5,-2];
RRThumbRotate = [0,13+10,-90-5];
RRFingerSpacing = 17;

module RRLeftPalmInner(wrist, knuckle, measurements, label, font, padding=5, support=1, thumb=1, mount=0, demoHand=0) {

    hand=measurements[0][0]; // which hand needs the prosthetic
    other=1-hand; // and which hand has full measurements
    echo ("target hand ",hand, " other hand ",other);
    targetWidth = measurements[other][8]+padding; // knuckle of full hand
    targetLen = knuckle[1]-wrist[1]; // difference in Y axis, padding already accounted for

    // draw target width and length to check math
    if (showGuide) %translate([0,targetLen/2,0]) cube([targetWidth, targetLen, 1], center=true);

    scale = RRScaleLen(targetLen);//targetLen/stlLen;
    scaleW = RRScaleWidth(targetWidth); // targetWidth/stlWidth;

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

        echo("Scale ",scale*100,"% Y scale ",scaleW*100,"%");
        difference() {
            union() { // load STL
                // mount for PVC tube
                if (mount) color("blue") translate([0,-7,mountUp+down*scale]) rotate([90,0,0])
                    cylinder(h=25,d=pvcD+bracketWall, center=true);

                scale([scaleW,scale,scale]) {
                    difference() {
                        union() { // import appropriate part(s)
                            if ((support==0) && (thumb==1)) {
                                import("/Users/laird/src/e-NABLE-Assembler/RaptorReloaded/raptor_reloaded_left_palm.stl", convexity=convexity);
                                }

                            else if ((support==1) && (thumb==1)){
                                //%import("../EH2.0/Palm Left [x1].stl", convexity=convexity);
                                import("../RaptorReloaded/raptor_reloaded_left_palm_support.stl", convexity=convexity);
                                import("/Users/laird/src/e-NABLE-Assembler/RaptorReloaded/raptor_reloaded_left_palm.stl", convexity=convexity);

                               }
                            else if ((support==1) && (thumb==0)) {
                                echo("ERROR: Not support yet in this design.");
                                }
                            else if ((support==0)&&(thumb==0))
                                echo("ERROR: Not support yet in this design.");
                            } // end imports
                        // subtract support from around the demo hand grip
                        if (demoHand) {
                            translate([0,35,-7]) {
                                difference() {
                                    scale([.5,1,.5]) rotate([0,90,0])
                                        cylinder(h=55, r=7+1, center=true);
                                    translate([0,0,-5.82]) cube([57,16,10], center=true);
                                }
                            }
                        }
                        }
                    // Following will generate a PVC tube mount for the Raptor
                    if (mount) translate([0,-7/scale,.7]) difference() {
                        cube([61,25/scale,17], center=true);
                    }
                    if (demoHand) {
                        translate([0,35,-7]) {
                            difference() {
                                scale([1,1,.5]) rotate([0,90,0])
                                cylinder(h=55, r=7, center=true);
                                translate([0,0,-5.82]) cube([57,16,10], center=true);
                            }
                        }
                    }
                }
            }

            if (mount) { // not true in this case
                //translate([0,-7,down*scale-5]) cube([65*scaleW,27,10], center=true);

                translate([0,-9,0]) translate([0,0,mountUp+down*scale]) rotate([90,0,0]) {
                    translate([0,0,-10]) cylinder(h=30,d=25*3/4+.4);
                    translate([0,0,-10*scale]) cylinder(h=20*scale,d=(25*3/4-4));
                    rotate([0,90,0]) cylinder(h=70*scale,d=3.8,center=true,$fn=32);
                }
            }

            // Subtract label from everything
            if (len(label)>0) scale([scaleW,scale,scale]) RRlabels(label, font, hand, thumb);

        }
    }
}

module RRlabels(label, font, hand, thumb) {
    echo("Label ", label, "thumb ", thumb);
    translate([0,61,-6]) rotate([5,0,0]) resize([40,2,3])
    RRlabel(label, font, hand);
    translate([-25.8-2,32,5]) rotate([7,0,94]) resize([25,3,6])
    RRlabel(label, font, hand);
    //if (thumb) 
    translate([25.8+1,32,5]) rotate([7,0,-94]) resize([25,3,6]) RRlabel(label, font, hand);
    //translate([26.5,28,-3]) rotate([7,0,-90]) resize([25,3,6])
    //if (thumb) RRlabel(label, font, hand);
}

module RRlabel(label, font, mirror=0) {
    echo("Label ",label," mirror ",mirror);
    render() rotate([90,0,0]) mirror([mirror,0,0]) write(label, center=true, h=6, font=font);
}
