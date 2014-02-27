/*

Parametric Robohand Knuckle Block
By David Orgeman

Released under the terms of the GNU GPL v3.0 

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

*/



//PARAMETERS

//Standard holes for tapping threads in plastic
M3T=2.5;
M4T=3.3;
M5T=4.2;

//Standard hole sizes for metric screws
M3=3.3;
M4=4.4;
M5=5.5;

// Set the FScale variable to match the scale factor used with other parts.
// That will ensure that the parts mesh properly.  Set the FWidth if the 
// finger tabs are too tight or too loose laterally in their slots.

//Set FScale to match the scaling of the other Robohand parts.
FScale=1.3;

//Change the commenting to select either the default width or a custom value.
//FWidth=(3.2+0.6)*FScale;
FWidth=4.4+0.6;

//These hole sizes are consistent regardless of the scale factor.  KSize1 is
//the hole for the knuckle grub screw.  KSize2 is the knuckle screw hole size
// on the outside so that it can be tapped.  HSize is the hole for the strings.
//HSize needs to allow for both the bungee and the draw string.
KSize1=M4-0.2;
KSize2=M4-0.2;
HSize=2.7;

//If NutTraps is true, then these parameters control the size of the trap.
//For the nut trap, measure nut width flat to flat and make that NutW.
//NutR is then the conversion to make the needed hole.  NutT is how thick
//the nut is.
NutTraps=true;
NutW=6.85;
NutR=(NutW/cos(30)+0.4)/2;
NutT=2.08+0.2;
//NutT=3.04+0.2;
//NutT=4.90+0.2;

//SlotSep is the space between the slots.  Use either the modified default
//scaled version, or a static number.
SlotAdj=-1.0;
SlotSep=10*FScale+SlotAdj;
//SlotSep=10;


//The Support variable just adds blocks to the knuckle tabs in hopes of
//better printing.  The corners would then need to be sanded off.  I have
//found that there are always corners that need to be removed.  The hope
//is that this will be no worse, but will print the curve better.
Support=true;


//RENDER

//Remove static sized portions 
difference()
	{

//Scale everything that is not static
	scale([FScale, FScale, FScale])
		{

//Build the main block out of separate shapes
		union()
			{
			translate([-(4*SlotSep+4*FWidth)/(2*FScale), -7.62, 0])
				cube([(4*SlotSep+4*FWidth)/FScale, 10.56, 9.47]);
			translate([-(4*SlotSep+4*FWidth)/(2*FScale), -1.37, 8])
				cube([(4*SlotSep+4*FWidth)/FScale, 4.31, 3.81]);
			translate([-(4*SlotSep+4*FWidth)/(2*FScale), 10.56-7.62, 9.4/2])
				rotate(a=[0, 90, 0])
					cylinder(h=(4*SlotSep+4*FWidth)/FScale, r=9.4/2, $fn=32);	
			if (Support)
				{
				translate([-(4*SlotSep+4*FWidth)/(2*FScale), -7, 0])
					cube([(4*SlotSep+4*FWidth)/FScale, 13, 4]);
				}	
			}

		}

//Put in the holes that never change size

//Screw holes to hold the fingers on
	translate([-(3*SlotSep+2*FWidth)/2-1, 2.94*FScale, 4.7*FScale])
		rotate(a=[0, 90, 0])
			cylinder(h=3*SlotSep+2*FWidth+2, r=KSize1/2, $fn=20);
	translate([-(4*SlotSep+4*FWidth)/2-1, 2.94*FScale, 4.7*FScale])
		rotate(a=[0, 90, 0])
			cylinder(h=4*SlotSep+4*FWidth+2, r=KSize2/2, $fn=20);

//Slots to insert the proximal sections
	translate([1.5*SlotSep+FWidth, -4.5*FScale, -1])
		cube([FWidth, 30, 10.5*FScale+1]);
	translate([0.5*SlotSep, -4.5*FScale, -1])
		cube([FWidth, 30, 10.5*FScale+1]);
	translate([-0.5*SlotSep-FWidth, -4.5*FScale, -1])
		cube([FWidth, 30, 10.5*FScale+1]);
	translate([-1.5*SlotSep-2*FWidth, -4.5*FScale, -1])
		cube([FWidth, 30, 10.5*FScale+1]);

//Holes for strings
	translate([1.5*SlotSep+1.5*FWidth, -1.45*FScale, 0])
		rotate(a=[30, 0, 0])
			cylinder(h=30, r=HSize/2, $fn=16);
	translate([0.5*SlotSep+0.5*FWidth, -1.45*FScale, 0])
		rotate(a=[30, 0, 0])
			cylinder(h=30, r=HSize/2, $fn=16);
	translate([-0.5*SlotSep-0.5*FWidth, -1.45*FScale, 0])
		rotate(a=[30, 0, 0])
			cylinder(h=30, r=HSize/2, $fn=16);
	translate([-1.5*SlotSep-1.5*FWidth, -1.45*FScale, 0])
		rotate(a=[30, 0, 0])
			cylinder(h=30, r=HSize/2, $fn=16);

	if (NutTraps)
		{
//		hull()
//			{
			translate([-1.5*SlotSep-2*FWidth-NutT, 2.94*FScale, 4.7*FScale])	
				rotate(a=[0, 90, 0])
					cylinder(h=NutT+1, r=NutR, $fn=6);
//			translate([-SlotSep-FWidth-NutT/2, 2.94*FScale, 20*FScale])
//				rotate(a=[0, 90, 0])
//					cylinder(h=NutT, r=NutR, $fn=6);
//			}
//		hull()
//			{
			translate([1.5*SlotSep+2*FWidth-1, 2.94*FScale, 4.7*FScale])	
				rotate(a=[0, 90, 0])
					cylinder(h=NutT+1, r=NutR, $fn=6);
//			translate([SlotSep+FWidth-NutT/2, 2.94*FScale, 20*FScale])
//				rotate(a=[0, 90, 0])
//					cylinder(h=NutT, r=NutR, $fn=6);
//			}
		}
	}




module fillet(r, h) 
	{
	translate([r/2, r/2, 0])
		difference() 
			{
			cube([r, r, h], center=true);
			translate([r/2, r/2, 0])
				cylinder(h=h+1, r=r, center=true, $fn=40);
			}
	}


module fillet_bez(r, h, a=90) 
	{
	p0=[r, 0];
	p1=[0, 0];
	p2=[r*cos(a), r*sin(a)];
	translate([0, 0, -h/2])
		linear_extrude(height=h) BezConic(p0, p1, p2, 32);
	}


// By nophead
module polyhole(d, h) 
	{
	n=max(round(2*d), 3);
	rotate(v=[0, 0, 180])
		cylinder(h=h, r=(d/2)/cos(180/n), center=true, $fn=n);
	}


/* 
Conic Bezier Curve
also known as Quadratic Bezier Curve
also known as Bezier Curve with 3 control points 

Please see 
http://www.thingiverse.com/thing:8443 by William A Adams
http://en.wikipedia.org/wiki/File:Bezier_2_big.gif by Phil Tregoning
http://en.wikipedia.org/wiki/B%C3%A9zier_curve by Wikipedia editors

By Don B, 2011, released into the Public Domain
*/

module BezConic(p0, p1, p2, steps=5) {

	stepsize1 = (p1-p0)/steps;
	stepsize2 = (p2-p1)/steps;

	for (i=[0 : steps-1]) {
		assign(point1 = p0+stepsize1*i) 
		assign(point2 = p1+stepsize2*i) 
		assign(point3 = p0+stepsize1*(i+1))
		assign(point4 = p1+stepsize2*(i+1))  {
			assign( bpoint1 = point1+(point2-point1)*(i/steps) )
			assign( bpoint2 = point3+(point4-point3)*((i+1)/steps) ) {
				polygon(points=[bpoint1, bpoint2, p1]);
			}
		}
	}
}

