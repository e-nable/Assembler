/*

Parametric Distal Phalanges v2
By David Orgeman

licensed under the Creative Commons - Attribution - Share Alike license

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

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


// Set the Scale_Factor variable to match the scale factor used with other parts.
// That will ensure that the parts mesh properly.  Set the Tab_Width if the 
// finger tabs are too tight or too loose laterally in their slots.
// Then set the Intermediate_Length value to get a custom length of the intermediate
// phalanges.  Expect the render to take hours for each new fingertip.

//Set Scale_Factor to match the scaling of the other prosthetic parts.
Scale_Factor=1.3;

//Change the commenting to select either the default width or a custom value.
//Tab_Width=(3.2+0.6)*Scale_Factor;
Tab_Width=4.4+0.7;

//Change the commenting to select either the default length or a custom value.
//This is the length of the intermediate phalange.  The distal phalange is always
//the same size - other than scaling factor.
//Intermediate_Length=(17.8+5.5)*Scale_Factor;
Intermediate_Length=26;

//Use_Pins determines whether the knuckle will be a screw of some sort, or a
//push pin.  There are advantages to either.  If true, then this script will
//also make the pin and will make room for the pin head as well as a snap fit.
Use_Pins=true;
Pin_Head_Height=1.4;

//Knuckle_Hole_Size is the hole for the link between distal and proximal phalanges.  Set this
//to a tapping hole size if a grub screw will be used.  Set it to a non-tapping
//size if something like a Chicago screw will be used.  If Use_Pins is true, this
//is the diameter of the pin.  Pins with larger diameter work better.
//Knuckle_Hole_Size=M4T;
Knuckle_Hole_Size=5.0;

//Bungee_Hole_Size is the diameter of the hole for the bungee, but it is not used for much in
//this version.  This is only used to carve a slot so the bungee can be inserted
//without disassembling the finger.  It can probably just be left alone.
Bungee_Hole_Size=3;

//Use_Bungee_Tieoff determines whether there should be a tieoff bar for the bungee, or the
//standard hole through the fingernail.
Use_Bungee_Tieoff=true;

//String_Hole_Size is the diameter of the hole for the drive string.  This can probably be
//left alone, but should be tweaked if required for the drive string to fit.
String_Hole_Size=1.8;

//Knuckle_Base_Radius is the size of the bearing surface of the knuckle joints.
//This value is scaled by the Scale_Factor.  This is currently set to the size of
//the original fingers.  It is exposed as a variable in case the bearing size is
//standardized to some other value at a future time.
Knuckle_Base_Radius=4.8;

//Knuckle_Size_Increase is an addition to the radius of the proximal-intermediate
//joint.  This should match the value of the equivalent joint in the proximal part.
//I have taken to using an increase value of 1mm for each joint from distal through
//to the palm.  Be aware that this addition is before scaling.  A 1mm increase
//is really 1.3mm if the Scale_Factor is 1.3.
Knuckle_Size_Increase=1.0;

//Use_Mink determines whether or not the Minkowski smoothing should be done.  if this
//is false, then a fairly good render can quickly be executed.  That allows testing
//of various options without having to spend hours on each render.  Once the best
//options are determined, Use_Mink can be set to true to render a smoother final
//version.
Use_Mink=false;



//RENDER

//Add any extra portions, like the bungee anchor post
union()
	{
//Remove static sized portions
	difference()
		{

//Scale everything that is not static
		scale([Scale_Factor, Scale_Factor, Scale_Factor])
			{

//Remove parts that need to scale, but that are not rounded by minkowski
			difference()
				{

//Combine different parts to build the finger shape
				union()
					{
					if (Use_Mink)
						{
						minkowski()
							{
							difference()
								{
								union()
									{	
//cylinder for finger tip
									translate([0, 0, 0])
										rotate(a=[0, -60, 0])
											translate([2.1, 0, 0])
												cylinder(h=25, r=Knuckle_Base_Radius+0.1-1.4, $fn=40);

//Rounded base with finger rotation stopper
									difference()
										{
										translate([-1, -4.5+1.4, 1.4])
											cube([10, 9-2*1.4, 4.8-1.4]);
										translate([10, -4.5+1.4-0.01, 1.4-0.01])
											rotate(a=[90, 0, 0])
											rotate(a=[0, 90, 0])
												fillet(r=0.3, h=60);
										translate([10, 4.5-1.4+0.01, 1.4-0.01])
											rotate(a=[180, 0, 0])
											rotate(a=[0, 90, 0])
												fillet(r=0.3, h=60);
										}
									}
//Put some flat sides on the finger
								translate([-20, -20, -10.0+1.4])
									cube([60, 40, 10]);
								translate([-40, 4.5-1.4, -10])
									cube([80, 10, 40]);
								translate([-40, -14.5+1.4, -10])
									cube([80, 10, 40]);
								translate([20, -4.5+1.4-0.01, 1.4-0.01])
									rotate(a=[90, 0, 0])
									rotate(a=[0, 90, 0])
										fillet(r=0.3, h=60);
								translate([20, 4.5-1.4+0.01, 1.4-0.01])
									rotate(a=[180, 0, 0])
									rotate(a=[0, 90, 0])
										fillet(r=0.3, h=60);
								}
							sphere(r=1.4, $fn=28);
							}
						}

					if (!Use_Mink)
						{
						difference()
							{
							union()
								{	
//cylinder for finger tip
								translate([0, 0, 0])
									rotate(a=[0, -60, 0])
										translate([2.1, 0, 0])
											cylinder(h=25, r=Knuckle_Base_Radius+0.1, $fn=40);

//Rounded base with finger rotation stopper
								difference()
									{
									translate([-1, -4.5, 0])
										cube([10, 9, 4.8]);
									translate([10, -4.5-0.01, -0.01])
										rotate(a=[90, 0, 0])
										rotate(a=[0, 90, 0])
											fillet(r=0.3, h=60);
									translate([10, 4.5+0.01, -0.01])
										rotate(a=[180, 0, 0])
										rotate(a=[0, 90, 0])
											fillet(r=0.3, h=60);
									}
								}
//Put some flat sides on the finger
							translate([-20, -20, -10.0])
								cube([60, 40, 10]);
							translate([-40, 4.5, -10])
								cube([80, 10, 40]);
							translate([-40, -14.5, -10])
								cube([80, 10, 40]);
							translate([20, -4.5-0.01, -0.01])
								rotate(a=[90, 0, 0])
								rotate(a=[0, 90, 0])
									fillet(r=0.3, h=60);
							translate([20, 4.5+0.01, -0.01])
								rotate(a=[180, 0, 0])
								rotate(a=[0, 90, 0])
									fillet(r=0.3, h=60);
							}
						}

//cylinder for lower part by the knuckle
					translate([1.4-4, 0, Knuckle_Base_Radius])
						rotate(a=[0, -90, 0])
							cylinder(h=5-4, r=Knuckle_Base_Radius-0.01, $fn=32);

//Rounded finger attachment cylinder
					union()
						{
						translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-Knuckle_Size_Increase-5.5, -4.5+1.7-0.005, Knuckle_Base_Radius+Knuckle_Size_Increase])
							rotate(a=[-90, 0, 0])
								cylinder(h=9-2*1.7+0.01, r=Knuckle_Base_Radius+Knuckle_Size_Increase, $fn=32);
						translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-Knuckle_Size_Increase-5.5, -4.5-0.05, Knuckle_Base_Radius+Knuckle_Size_Increase])
							rotate(a=[-90, 0, 0])
								cylinder(h=9+0.1, r=Knuckle_Base_Radius+Knuckle_Size_Increase-1.7, $2n=28);
						translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-Knuckle_Size_Increase-5.5, 4.5-1.7, Knuckle_Base_Radius+Knuckle_Size_Increase])
							rotate([90, 0, 0])
								rotate_extrude (convexity =2, $fn=32)
									translate([Knuckle_Base_Radius+Knuckle_Size_Increase-1.7,0,0])
										circle (r = 1.7, $fn=32);
						translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-Knuckle_Size_Increase-5.5, -4.5+1.7, Knuckle_Base_Radius+Knuckle_Size_Increase])
							rotate([90, 0, 0])
								rotate_extrude (convexity =2, $fn=32)
									translate([Knuckle_Base_Radius+Knuckle_Size_Increase-1.7,0,0])
										circle (r = 1.7, $fn=32);
						}

//Transition from the square knuckle to round tip
					hull()
						{
						difference()
							{
							translate([1.4-4, 0, Knuckle_Base_Radius])
								rotate(a=[0, 90, 0])
									cylinder(h=1, r=Knuckle_Base_Radius, $fn=32);
							translate([0, 4.5, 0])
								cube([4, 1, 2*Knuckle_Base_Radius]);
							translate([0, -5.5, 0])
								cube([4, 1, 2*Knuckle_Base_Radius]);
							}
						difference()
							{
							hull()
								{
								translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-Knuckle_Size_Increase-5.5, -4.5, 0])
									cube([0.1, 9, 2*Knuckle_Base_Radius+2*Knuckle_Size_Increase]);
								translate([6, -4.5, 0])
									cube([0.1, 9, 2*Knuckle_Base_Radius]);
								}
							translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-Knuckle_Size_Increase-5.5, -4.5-0.01, 2*Knuckle_Base_Radius+2*Knuckle_Size_Increase+0.01])
								rotate(a=[0, -atan((2*Knuckle_Size_Increase)/(Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-Knuckle_Size_Increase-5.5-6)), 0])
								rotate(a=[0, 90, 0])
									fillet(r=1.7, h=2*(Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-Knuckle_Size_Increase-5.5));
							translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-Knuckle_Size_Increase-5.5, 4.5+0.01, 2*Knuckle_Base_Radius+2*Knuckle_Size_Increase+0.01])
								rotate(a=[0, -atan((2*Knuckle_Size_Increase)/(Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-Knuckle_Size_Increase-5.5-6)), 0])
								rotate(a=[-90, 0, 0])
								rotate(a=[0, 90, 0])
									fillet(r=1.7, h=2*(Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-Knuckle_Size_Increase-5.5));
							translate([20, -4.5-0.01, 0-0.01])
								rotate(a=[90, 0, 0])
								rotate(a=[0, 90, 0])
									fillet(r=1.7, h=40);
							translate([20, 4.5+0.01, 0-0.01])
								rotate(a=[180, 0, 0])
								rotate(a=[0, 90, 0])
									fillet(r=1.7, h=40);
							}
						}

//Rounded base with finger rotation stopper
						if (Use_Mink)
							{
							minkowski()
								{
								difference()
									{
									translate([6, -4.5+0.5, 0.5])
										cube([Intermediate_Length/Scale_Factor-4.8-5.5-2.8-0.5, 9-2*0.5, 4.8-0.5]);
									translate([20, -4-0.01, 0.5-0.01])
										rotate(a=[90, 0, 0])
										rotate(a=[0, 90, 0])
											fillet(r=1.2, h=60);
									translate([20, 4+0.01, 0.5-0.01])
										rotate(a=[180, 0, 0])
										rotate(a=[0, 90, 0])
											fillet(r=1.2, h=60);
									}
								sphere(r=0.5, $fn=16);
								}
							}

						if (!Use_Mink)
							{
							difference()
								{
								translate([6, -4.5, 0])
									cube([Intermediate_Length/Scale_Factor-4.8-5.5-2.8, 9, 4.8]);
								translate([20, -5-0.01, -0.01])
									rotate(a=[90, 0, 0])
									rotate(a=[0, 90, 0])
										fillet(r=1.2, h=60);
								translate([20, 5+0.01, -0.01])
									rotate(a=[180, 0, 0])
									rotate(a=[0, 90, 0])
										fillet(r=1.2, h=60);
								}
							}

//Just a rectangle to make the finger surface cleaner
					translate([0, -3, -0.1])
						cube([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-5.5+2.7, 6, 1]);			
					}

//Put some flat sides on the finger
				translate([-20, -20, -10])
					cube([60, 40, 10]);
				translate([-40, 4.5, -10])
					cube([80, 10, 40]);
				translate([-40, -14.5, -10])
					cube([80, 10, 40]);

//Round off the lower segment
				translate([0, -4.5-0.01, 0-0.01])
					rotate(a=[90, 0, 0])
					rotate(a=[0, 90, 0])
						fillet(r=1.7, h=60);
				translate([0, 4.5+0.01, 0-0.01])
					rotate(a=[180, 0, 0])
					rotate(a=[0, 90, 0])
						fillet(r=1.7, h=60);

//Shape the finger tip on the end of the cylinder
				translate([-11.35, 0, 9])
					rotate(a=[0, 30, 0])
						difference()
							{
							translate([-18, -8, -8])
								cube([18, 16, 16]);
							translate([0, 0, 0])
								sphere(r=Knuckle_Base_Radius+0.1, $fn=32);
							translate([0, 0, -10])
								cylinder(h=10, r=Knuckle_Base_Radius+0.1, $fn=28);
							}

//Cut notch for proximal joint to go into
				hull()
					{
					translate([Intermediate_Length/Scale_Factor-4.8-1-5.5, -(Tab_Width/2)/Scale_Factor, 12])
						rotate(a=[-90, 0, 0])
							cylinder(h=Tab_Width/Scale_Factor, r=4.8+1+0.5, $fn=28);
					translate([Intermediate_Length/Scale_Factor-4.8-1-5.5, -(Tab_Width/2)/Scale_Factor, 4.8+1])
						rotate(a=[-90, 0, 0])
							cylinder(h=Tab_Width/Scale_Factor, r=4.8+1+0.5, $fn=28);
					}
				translate([Intermediate_Length/Scale_Factor-4.8-1-5.5, -(Tab_Width/2)/Scale_Factor, -1])
					cube([4.8, Tab_Width/Scale_Factor, 11]);

				}
			}

//Put in the holes that never change size
		if (!Use_Pins)
			{
			translate([Intermediate_Length-(Knuckle_Base_Radius+Knuckle_Size_Increase+5.5)*Scale_Factor, 15, (Knuckle_Base_Radius+Knuckle_Size_Increase)*Scale_Factor])
				rotate(a=[90, 0, 0])
					cylinder(h=30, r=Knuckle_Hole_Size/2, $fn=20);
			}
		if (Use_Pins)
			{
			difference()
				{
				union()
					{
					translate([Intermediate_Length-(Knuckle_Base_Radius+Knuckle_Size_Increase+5.5)*Scale_Factor, 9*Scale_Factor/2, (Knuckle_Base_Radius+Knuckle_Size_Increase)*Scale_Factor])
						rotate(a=[90, 0, 0])
							pinhole(h=9*Scale_Factor, lh=1.7, lt=1.0, r=Knuckle_Hole_Size/2, tight=false);
					translate([Intermediate_Length-(Knuckle_Base_Radius+Knuckle_Size_Increase+5.5)*Scale_Factor, 9*Scale_Factor/2+0.6, (Knuckle_Base_Radius+Knuckle_Size_Increase)*Scale_Factor])
						rotate(a=[90, 0, 0])
							cylinder(h=Pin_Head_Height+1, r=1.5*Knuckle_Hole_Size/2+0.15, $fn=16);
					}
				translate([Intermediate_Length-(Knuckle_Base_Radius+Knuckle_Size_Increase+5.5)*Scale_Factor-5, -10, (Knuckle_Base_Radius+Knuckle_Size_Increase)*Scale_Factor-10-Knuckle_Hole_Size/2+0.375-0.15])
					cube([10, 20, 10]);
				translate([Intermediate_Length-(Knuckle_Base_Radius+Knuckle_Size_Increase+5.5)*Scale_Factor-5, -10, (Knuckle_Base_Radius+Knuckle_Size_Increase)*Scale_Factor+Knuckle_Hole_Size/2-0.375+0.15])
					cube([10, 20, 10]);
				}
			}
		if (Use_Bungee_Tieoff)
			{
			hull()
				{
				translate([Intermediate_Length-21.5*Scale_Factor, (-Tab_Width+Bungee_Hole_Size)/2, 2.8*Scale_Factor])
					rotate(a=[0, 90, 0])
						cylinder(h=30, r=Bungee_Hole_Size/2-0.01, $fn=16);
				translate([Intermediate_Length-21.5*Scale_Factor, (Tab_Width-Bungee_Hole_Size)/2, 2.8*Scale_Factor])
					rotate(a=[0, 90, 0])
						cylinder(h=30, r=Bungee_Hole_Size/2-0.01, $fn=16);
				}
			translate([Intermediate_Length-21.5*Scale_Factor, -Tab_Width/2, -1])
				cube([30, Tab_Width, 2.8*Scale_Factor+1]);
			}
		if (!Use_Bungee_Tieoff)
			{
			translate([-20, 0, 2.8*Scale_Factor])
				rotate(a=[0, 90, 0])
					cylinder(h=80, r=Bungee_Hole_Size/2, $fn=16);
			translate([-24, 0, 2.8*Scale_Factor])
				rotate(a=[0, 90, 0])
					cylinder(h=20, r=Bungee_Hole_Size/2+0.5, $fn=16);
			translate([Intermediate_Length-4.8-5.5-9.7, -Bungee_Hole_Size/2, -1])
				cube([30, Bungee_Hole_Size, 2.8*Scale_Factor+1]);
			}
		translate([-14, 0, 2*Knuckle_Base_Radius*Scale_Factor-String_Hole_Size/2-Knuckle_Base_Radius/4])
			rotate(a=[0, 90, 0])
				cylinder(h=80, r=String_Hole_Size/2-0.01, $fn=16);
		translate([-13, 0, 2*Knuckle_Base_Radius*Scale_Factor-String_Hole_Size/2-Knuckle_Base_Radius/4])
			rotate(a=[0, -60, 0])
				cylinder(h=20, r=String_Hole_Size/2+0.5, $fn=16);
		translate([Intermediate_Length-(13+4.8+5.5)*Scale_Factor, -String_Hole_Size/2, 2*Knuckle_Base_Radius*Scale_Factor-String_Hole_Size/2-Knuckle_Base_Radius/4])
			cube([30, String_Hole_Size, 2.8*Scale_Factor+1]);

		}

//Print a reference cube to see if the intermediate length is correct.				
//	translate([-5.5*Scale_Factor,8,0])
//		cube([26, 2, 2]);	
		
//Add binder post
	if (Use_Bungee_Tieoff)
		{
		translate([Intermediate_Length-18*Scale_Factor, 0, (0.7+0.5)*Scale_Factor])
			rotate(a=[90, 0, 0])
				difference()
					{
					cylinder(h=6*Scale_Factor, r=0.95*Scale_Factor, center=true, $fn=16);
					translate([-2, -4-0.7*Scale_Factor, -3*Scale_Factor-1])
						cube([4, 4, 6*Scale_Factor+2]);
					translate([-2, 0.7*Scale_Factor, -3*Scale_Factor-1])
						cube([4, 4, 6*Scale_Factor+2]);
					}
		}
				
	if (Use_Pins)
		{
		translate([Intermediate_Length+2, 0, 0])
			pin_horizontal(h=9*Scale_Factor, lh=1.7, lt=1.0, r=Knuckle_Hole_Size/2, tight=false);
		translate([Intermediate_Length+2, 9*Scale_Factor/2, (Knuckle_Hole_Size-0.5)/2])
			rotate(a=[90, 0, 0])
				difference()
					{
					cylinder(h=Pin_Head_Height, r=1.5*Knuckle_Hole_Size/2, $fn=16);
					translate([-5, -10-Knuckle_Hole_Size/2+0.375, -5])
						cube([10, 10, 10]);
					translate([-5, Knuckle_Hole_Size/2-0.375, -5])
						cube([10, 10, 10]);
					}
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



//Polyhole module by nophead
//licensed under the Creative Commons - Attribution license
//provided here, as-is, without any warranty of any sort
//original work available at http://www.thingiverse.com/thing:6118
//and also at http://hydraraptor.blogspot.com/2011/02/polyholes.html

module polyhole(d, h) 
	{
	n=max(round(2*d), 3);
	rotate(v=[0, 0, 180])
		cylinder(h=h, r=(d/2)/cos(180/n), center=true, $fn=n);
	}



//OpenSCAD Conic Bezier Curve by donb
//licensed under the Creative Commons - Public Domain license - no rights reserved
//provided here, as-is, without any warranty of any sort
//original work available at http://www.thingiverse.com/thing:8931

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



//"PLA Pin Connectors v2" by whpthomas
//licensed under the Creative Commons - Attribution - Share Alike license
//modified so the module creates a rounder pin at small sizes
//modified to make some primitives overlap so that the stl has fewer errors
//provided as-is, without any warranty of any sort
//original work available at http://www.thingiverse.com/thing:130879

// PLA Pin Connectors
// WHPThomas <me@henri.net>
// Derived to provide a drop in replacement for Tony Buser's pin connectors <tbuser@gmail.com>

//pinhole(h=12, tight=false);
//test();
//pintack(h=20);
//pinpeg(h=24);

module test() {
  tolerance = 0.2;
  radius=7/2;
  
  translate([-12, 16, 0]) pinpeg(h=21, r=radius);
  translate([12, 12, 0]) pintack(h=12, r=radius);
  
  difference() {
    union() {
      translate([0, -12, 2.5]) cube(size = [60, 20, 5], center = true);
      translate([24, -12, 7.5]) cube(size = [12, 20, 15], center = true);
    }
    translate([-24, -12, 0]) pinhole(h=5, r=radius, t=tolerance);
    translate([-12, -12, 0]) pinhole(h=5, r=radius, t=tolerance, tight=false);
    translate([0, -12, 0]) pinhole(h=16, r=radius, t=tolerance);
    translate([12, -12, 0]) pinhole(h=16, r=radius, t=tolerance, tight=false);
    translate([24, -12, 15]) rotate([0, 180, 0]) pinhole(h=12, r=radius, t=tolerance);
  }
}

module pinhole(h=16, r=4, lh=3, lt=1, t=0.3, tight=true) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  // t = tolerance
  // tight = set to false if you want a joint that spins easily
  union() {
    pin_solid(h, r+(t/2), lh, lt);
    if (tight) {
      // make the cylinder slightly longer
      cylinder(h=h+t, r=r, $fn=30);
    }
    else {
      // make the cylinder slightly longer and wider
      cylinder(h=h+t, r=r+(t/2)+t, $fn=30);
    }
    // camfer the entrance hole to make insertion easier
    translate([0, 0, -0.1]) cylinder(h=lh/3, r2=r, r1=r+(t/2)+(lt/2), $fn=30);
  }
}

module pin(h=16, r=4, lh=3, lt=1, side=false) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  // side = set to true if you want it printed horizontally
  hh = h < 2.5*r ? 2.5*r : h;
  if(h < 2.5*r) echo("****** WARNING: pin caped at minimum length ", h, "set to", hh);

  if (side) {
    pin_horizontal(hh, r, lh, lt);
  } else {
    pin_vertical(hh, r, lh, lt);
  }
}

module pintack(h=16, r=4, lh=3, lt=1, bh=3, br=8.75) {
  // bh = base_height
  // br = base_radius
  
  union() {
    cylinder(h=bh, r=br);
    translate([0, 0, bh]) pin(h, r, lh, lt);
  }
}

module pinpeg(h=32, r=4, lh=3, lt=1, t=0.1, tabs=false) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  // t = tolerance
  hh = h < 6*r ? 6*r : h;
  if(h < 6*r) echo("****** WARNING: pinpeg caped at minimum length ", h, "set to", hh);
  union() {
    translate([0, -hh/4+t/2, 0]) pin_horizontal(hh/2+t, r, lh, lt);
    translate([0, hh/4-t/2, 0]) rotate([0, 0, 180]) pin_horizontal(hh/2+t, r, lh, lt);
	if(tabs) {
		translate([0, hh*3/8, 0]) cylinder(h=0.15, r=2*r);
		translate([0, -hh*3/8, 0]) cylinder(h=0.15, r=2*r);
	}
  }
}

// just call pin instead, I made this module because it was easier to do the rotation option this way
// since openscad complains of recursion if I did it all in one module
module pin_vertical(h=16, r=4, lh=3, lt=1) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  cl=r*2.1;
  cz=h-(r*2);
  difference() {
    pin_solid(h, r, lh, lt, false);
    
    // center cut
    translate([-r*0.5/2, -(r*2+lt*2)/2, cz]) cube([r*0.5, r*2+lt*2, cl]);
    translate([0, 0, cz]) 
    scale(v=[1,r/(r+lt)*1.05,1]){
       sphere(r=r*1/2, $fn=20);
       cylinder(h=cl, r1=r*1/2, r2=r*4/5, $fn=20);
    }
    // center curve
    translate([0, 0, cz]) rotate([90, 0, 0]) cylinder(h=cl, r=r/4, center=true, $fn=20);
  
    // side cuts
//    translate([-r*2, -lt-r*1.125, -1]) cube([r*4, lt*2, h+2]);
//    translate([-r*2, -lt+r*1.125, -1]) cube([r*4, lt*2, h+2]);
    translate([-r*2, -lt-r*1.25, -1]) cube([r*4, lt*2, h+2]);
    translate([-r*2, -lt+r*1.25, -1]) cube([r*4, lt*2, h+2]);
  }
}

// call pin with side=true instead of this
module pin_horizontal(h=16, r=4, lh=3, lt=1) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
//  translate([0, h/2, r*1.125-lt]) rotate([90, 0, 0]) pin_vertical(h, r, lh, lt);
  translate([0, h/2, r*1.3-lt]) rotate([90, 0, 0]) pin_vertical(h, r, lh, lt);
}

// this is mainly to make the pinhole module easier
module pin_solid(h=16, r=4, lh=3, lt=1, hole=true) {
  union() {
    // shaft
    cylinder(h=h-(lh/2), r=r, $fn=30);
    // lip
    if(hole) {
      translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+lt, $fn=30);
//      translate([0, 0, h-lh]) cylinder(h=lh*0.25, r=r+lt, $fn=30);
      translate([0, 0, h-lh+lh*0.25-0.01]) cylinder(h=lh*0.25+0.02, r=r+lt, $fn=30);    
      translate([0, 0, h-lh+lh*0.5]) cylinder(h=lh*0.5, r1=r+lt, r2=r, $fn=30);
    }
    else {
      scale(v=[1,r/(r+lt)*1.05,1]) {
        translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt*2/3), $fn=30);
//        translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r=r+(lt*2/3), $fn=30);    
        translate([0, 0, h-lh+lh*0.25-0.01]) cylinder(h=lh*0.25+0.02, r=r+(lt*2/3), $fn=30); 
        translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt*2/3), r2=r-(lt/2), $fn=30);
      }
    }
  }
}


