/*

Parametric Mechen - Second Degree - Fingers Portion
By David Orgeman

licensed under the Creative Commons - Attribution - Share Alike license

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Seek appropriate medical attention prior to using this device, and
use entirely at your own risk.

*/

include <Include-HelperModules.scad>;
include <Include-HandParameters.scad>;

//PARAMETERS

//If you have measured the proximal lengths and saved them in the HandParameters file,
//then you can set which fingers to print below.  You can also do a single finger where
//the length is not in the HandParameter file.  To do that, set Print_Custom_Proximal to true,
//and then set the Custom_Proximal_Length value to the size you want.
Print_Custom_Proximal=false;
Custom_Proximal_Length=54;
Print_Index_Proximal=true;
Print_Middle_Proximal=false;
Print_Ring_Proximal=false;
Print_Pinky_Proximal=false;

//If you have measured the intermediate lengths and saved them in the HandParameters file,
//then you can set which fingers to print below.  You can also do a single finger where
//the length is not in the HandParameter file.  To do that, set Print_Custom_Distal to true,
//and then set the Custom_Distal_Length value to the size you want.
Print_Custom_Distal=false;
Custom_Distal_Length=26;
Print_Index_Distal=true;
Print_Middle_Distal=false;
Print_Ring_Distal=false;
Print_Pinky_Distal=false;


//Print_Extra_Pins makes the script draw more pins than are needed for the hand.  Then, if
//one breaks or gets lost, there will be extras.  If extra pins are all that is needed just
//set all other Print parameters to false.
Print_Extra_Pins=true;

//Use_Minkowski determines whether or not the Minkowski smoothing should be done.  if this
//is false, then a fairly good render can quickly be executed.  That allows testing
//of various options without having to spend hours on each render.  Once the best
//options are determined, Use_Minkowski can be set to true to render a smoother final
//version.
Use_Minkowski=false;



//CALCULATED VALUES

//Proximal_Support_Height is just the height of the support blocks used to make printing
//a little cleaner.  It should not need to be changed.
Proximal_Support_Height=1.8+Finger_String_Hole_Size/(2*Scale_Factor)+0.0;

//Distal_Tab_Width makes the slot in the intermediate phalanx slightly larger than the
//tab on the proximal phalanx.  This allows them to fit together and move smoothly.  If
//too much is added, then the joint will wobble side-to-side.  If too little is added,
//then it will be too tight and won't move well.  If the finger does not work as desired,
//this value could be tweaked.
Distal_Tab_Width=Tab_Width+0.4;



//RENDER

if (Print_Custom_Proximal)
	translate([-60,-30 , 0])
		Proximal(Custom_Proximal_Length);
if (Print_Index_Proximal)
	translate([-36, -30, 0])
		Proximal(Index_Proximal);
if (Print_Middle_Proximal)
	translate([-12, -30, 0])
		Proximal(Middle_Proximal);
if (Print_Ring_Proximal)
	translate([12, -30, 0])
		Proximal(Ring_Proximal);
if (Print_Pinky_Proximal)
	translate([36, -30, 0])
		Proximal(Pinky_Proximal);
if (Print_Custom_Distal)
	translate([-60, 51, 0])
		Distal(Custom_Distal_Length);
if (Print_Index_Distal)
	translate([-36, 48, 0])
		Distal(Index_Intermediate);
if (Print_Middle_Distal)
	translate([-12, 53, 0])
		Distal(Middle_Intermediate);
if (Print_Ring_Distal)
	translate([12, 50, 0])
		Distal(Ring_Intermediate);
if (Print_Pinky_Distal)
	translate([36, 40, 0])
		Distal(Pinky_Intermediate);
if (Print_Extra_Pins) translate([0,5,0]) 
	{
	translate([42, 4, 0])
		rotate(a=[0, 0, -90])
			custom_pin();
	translate([21, 4, 0])
		rotate(a=[0, 0, -90])
			custom_pin();
	translate([0, 4, 0])
		rotate(a=[0, 0, -90])
			custom_pin();
	translate([-21, 4, 0])
		rotate(a=[0, 0, 90])
			custom_pin();
	translate([-42, 4, 0])
		rotate(a=[0, 0, 90])
			custom_pin();
	}

	

module Proximal(Proximal_Length)
	{
	
	difference()
		{
		scale([Scale_Factor, Scale_Factor, Scale_Factor])
			{
			union()
				{

//Main part of the finger segment
				difference()
					{
					union()
						{
						hull()
							{
							translate([0, (Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase), Knuckle_Base_Radius+PIJ_Size_Increase])
								rotate(a=[0, 90, 0])
									cylinder(h=Tab_Width/Scale_Factor, r=Knuckle_Base_Radius+PIJ_Size_Increase, center=true, $fn=40);
							translate([0, -(Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-MCPJ_Size_Increase), Knuckle_Base_Radius+MCPJ_Size_Increase])
								rotate(a=[0, 90, 0])
									cylinder(h=Tab_Width/Scale_Factor, r=Knuckle_Base_Radius+MCPJ_Size_Increase, center=true, $fn=40);
							}
						if (Use_Support)
							{
							translate([-Tab_Width/(2*Scale_Factor), (Proximal_Length/(2*Scale_Factor)-(Knuckle_Base_Radius+PIJ_Size_Increase)), 0])
								cube([Tab_Width/Scale_Factor, sqrt((Knuckle_Base_Radius+PIJ_Size_Increase)*(Knuckle_Base_Radius+PIJ_Size_Increase)-((Knuckle_Base_Radius+PIJ_Size_Increase)-Proximal_Support_Height)*((Knuckle_Base_Radius+PIJ_Size_Increase)-Proximal_Support_Height)), Proximal_Support_Height]);
							translate([-Tab_Width/(2*Scale_Factor), -(Proximal_Length/(2*Scale_Factor)-(Knuckle_Base_Radius+MCPJ_Size_Increase))-sqrt((Knuckle_Base_Radius+MCPJ_Size_Increase)*(Knuckle_Base_Radius+MCPJ_Size_Increase)-((Knuckle_Base_Radius+MCPJ_Size_Increase)-Proximal_Support_Height)*((Knuckle_Base_Radius+MCPJ_Size_Increase)-Proximal_Support_Height)), 0])
								cube([Tab_Width/Scale_Factor, sqrt((Knuckle_Base_Radius+MCPJ_Size_Increase)*(Knuckle_Base_Radius+MCPJ_Size_Increase)-((Knuckle_Base_Radius+MCPJ_Size_Increase)-Proximal_Support_Height)*((Knuckle_Base_Radius+MCPJ_Size_Increase)-Proximal_Support_Height)), Proximal_Support_Height]);
							}
						}
					translate([-Finger_String_Hole_Size/(2*Scale_Factor), -30, -4])
						cube([Finger_String_Hole_Size/Scale_Factor, 60, 5.8]);
					}

				difference()
					{
	
//Create a smoothed version of the main block based on Use_Minkowski option
					if (Use_Minkowski)
						{
						minkowski()
							{
							union()
								{
								difference()
									{

//Create the central part of the block
									hull()
										{
										translate([-4, -(Proximal_Length/Scale_Factor-((Knuckle_Base_Radius+PIJ_Size_Increase)+(Knuckle_Base_Radius+MCPJ_Size_Increase)))/2, 0.5])
											cube([8, 0.1, 2*Knuckle_Base_Radius-1+2*MCPJ_Size_Increase]);
										translate([-4, -(Proximal_Length/Scale_Factor-((Knuckle_Base_Radius+PIJ_Size_Increase)+(Knuckle_Base_Radius+MCPJ_Size_Increase)))/2+Proximal_Length/Scale_Factor-((Knuckle_Base_Radius+PIJ_Size_Increase)+(Knuckle_Base_Radius+MCPJ_Size_Increase)), 0.5])
											cube([8, 0.1, 2*Knuckle_Base_Radius-1+2*PIJ_Size_Increase]);
										}

//Remove cutouts for the distal portion to rotate									
									hull()
										{
										translate([0, (Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase), Knuckle_Base_Radius+PIJ_Size_Increase])
											rotate(a=[0, 90, 0])
												cylinder(h=40, r=Knuckle_Base_Radius+PIJ_Size_Increase+0.8, center=true, $fn=40);
										translate([0, (Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase), -2*Knuckle_Base_Radius])
											rotate(a=[0, 90, 0])
												cylinder(h=40, r=Knuckle_Base_Radius+PIJ_Size_Increase+0.8, center=true, $fn=40);
										}
									hull()
										{
										translate([0, -(Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-MCPJ_Size_Increase), Knuckle_Base_Radius+MCPJ_Size_Increase])
											rotate(a=[0, 90, 0])
												cylinder(h=40, r=Knuckle_Base_Radius+MCPJ_Size_Increase+0.8, center=true, $fn=40);
										translate([0, -(Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-MCPJ_Size_Increase), -2*Knuckle_Base_Radius])
											rotate(a=[0, 90, 0])
												cylinder(h=40, r=Knuckle_Base_Radius+MCPJ_Size_Increase+0.8, center=true, $fn=40);
										}
		
//Round horizontal edges
									translate([4+0.01, Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase, 2*Knuckle_Base_Radius-0.5+2*PIJ_Size_Increase+0.01])
										rotate(a=[-atan(2*(MCPJ_Size_Increase-PIJ_Size_Increase)/((Proximal_Length/Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase-Knuckle_Base_Radius-MCPJ_Size_Increase)), 0, 0])
										rotate(a=[0, 180, 0])
										rotate(a=[90, 0, 0])
											fillet(r=1.5, h=3*Proximal_Length);
									translate([-4-0.01, Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase, 2*Knuckle_Base_Radius-0.5+2*PIJ_Size_Increase+0.01])
										rotate(a=[-atan(2*(MCPJ_Size_Increase-PIJ_Size_Increase)/((Proximal_Length/Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase-Knuckle_Base_Radius-MCPJ_Size_Increase)), 0, 0])
										rotate(a=[0, 90, 0])
										rotate(a=[90, 0, 0])
											fillet(r=1.5, h=3*Proximal_Length);
									translate([4+0.01, 0, 0.5-0.01])
										rotate(a=[0, -90, 0])
										rotate(a=[90, 0, 0])
											fillet(r=1.5, h=60);
									translate([-4-0.01, 0, 0.5-0.01])
										rotate(a=[0, 0, 0])
										rotate(a=[90, 0, 0])
											fillet(r=1.5, h=60);	
									}
	
//Create the block as the knuckle stop
								union()
									{
									translate([(-Tab_Width/2)/Scale_Factor+0.5, -Proximal_Length/(2*Scale_Factor)+Knuckle_Base_Radius+MCPJ_Size_Increase-3, 2*Knuckle_Base_Radius-1.6+2*MCPJ_Size_Increase])
										cube([Tab_Width/Scale_Factor-1, 5, 3.5]);
									translate([(-Tab_Width/2)/Scale_Factor+0.5, -Proximal_Length/(2*Scale_Factor)+Knuckle_Base_Radius+MCPJ_Size_Increase-3+5, 2*Knuckle_Base_Radius+2*MCPJ_Size_Increase-1.9])
										rotate(a=[0, 90, 0])
											cylinder(h=Tab_Width/Scale_Factor-1, r=3.8, $fn=40);
									}
								}

//Minkowski the central block with small sphere
							sphere(r=0.5, $fn=20);
							}
						}

//Create a version of the main block without Minkowski based on Use_Minkowski
					if (!Use_Minkowski)
						{
						union()
							{
							difference()
								{
	
//Create the central part of the block
								hull()
									{
									translate([-4, -(Proximal_Length/Scale_Factor-((Knuckle_Base_Radius+PIJ_Size_Increase)+(Knuckle_Base_Radius+MCPJ_Size_Increase)))/2, 0])
										cube([8, 0.1, 2*Knuckle_Base_Radius+2*MCPJ_Size_Increase]);
									translate([-4, -(Proximal_Length/Scale_Factor-((Knuckle_Base_Radius+PIJ_Size_Increase)+(Knuckle_Base_Radius+MCPJ_Size_Increase)))/2+Proximal_Length/Scale_Factor-((Knuckle_Base_Radius+PIJ_Size_Increase)+(Knuckle_Base_Radius+MCPJ_Size_Increase)), 0])
										cube([8, 0.1, 2*Knuckle_Base_Radius+2*PIJ_Size_Increase]);
									}

//Remove cutouts for the distal portion to rotate									
								hull()
									{
									translate([0, (Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase), Knuckle_Base_Radius+PIJ_Size_Increase])
										rotate(a=[0, 90, 0])
											cylinder(h=40, r=Knuckle_Base_Radius+PIJ_Size_Increase+0.8, center=true, $fn=40);
									translate([0, (Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase), -2*Knuckle_Base_Radius])
										rotate(a=[0, 90, 0])
											cylinder(h=40, r=Knuckle_Base_Radius+PIJ_Size_Increase+0.8, center=true, $fn=40);
									}
								hull()
									{
									translate([0, -(Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-MCPJ_Size_Increase), Knuckle_Base_Radius+MCPJ_Size_Increase])
										rotate(a=[0, 90, 0])
											cylinder(h=40, r=Knuckle_Base_Radius+MCPJ_Size_Increase+0.8, center=true, $fn=40);
									translate([0, -(Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-MCPJ_Size_Increase), -2*Knuckle_Base_Radius])
										rotate(a=[0, 90, 0])
											cylinder(h=40, r=Knuckle_Base_Radius+MCPJ_Size_Increase+0.8, center=true, $fn=40);
									}
						
//Round horizontal edges
								translate([4+0.01, Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase, 2*Knuckle_Base_Radius+2*PIJ_Size_Increase+0.01])
									rotate(a=[-atan(2*(MCPJ_Size_Increase-PIJ_Size_Increase)/((Proximal_Length/Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase-Knuckle_Base_Radius-MCPJ_Size_Increase)), 0, 0])
									rotate(a=[0, 180, 0])
									rotate(a=[90, 0, 0])
										fillet(r=1.5, h=3*Proximal_Length);
								translate([-4-0.01, Proximal_Length/(2*Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase, 2*Knuckle_Base_Radius+2*PIJ_Size_Increase+0.01])
									rotate(a=[-atan(2*(MCPJ_Size_Increase-PIJ_Size_Increase)/((Proximal_Length/Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase-Knuckle_Base_Radius-MCPJ_Size_Increase)), 0, 0])
									rotate(a=[0, 90, 0])
									rotate(a=[90, 0, 0])
										fillet(r=1.5, h=3*Proximal_Length);
								translate([4+0.01, 0, -0.01])
									rotate(a=[0, -90, 0])
									rotate(a=[90, 0, 0])
										fillet(r=1.5, h=60);
								translate([-4-0.01, 0, -0.01])
									rotate(a=[0, 0, 0])
									rotate(a=[90, 0, 0])
										fillet(r=1.5, h=60);	
								}
	
//Create the block as the knuckle stop
							union()
								{
								translate([(-Tab_Width/2)/Scale_Factor+0.005, -Proximal_Length/(2*Scale_Factor)+Knuckle_Base_Radius+MCPJ_Size_Increase-3, 2*Knuckle_Base_Radius-1.6+2*MCPJ_Size_Increase])
									cube([Tab_Width/Scale_Factor-0.01, 5, 4]);
								translate([(-Tab_Width/2)/Scale_Factor+0.005, -Proximal_Length/(2*Scale_Factor)+Knuckle_Base_Radius+MCPJ_Size_Increase-3+5, 2*Knuckle_Base_Radius+2*MCPJ_Size_Increase-1.9])
									rotate(a=[0, 90, 0])
										cylinder(h=Tab_Width/Scale_Factor-0.01, r=4.3, $fn=40);
								}
							}
						}

//Clip off the end of the knuckle stop
					translate([-10, (-Proximal_Length/Scale_Factor)/2-10, 0])
						cube([20, 10+Knuckle_Base_Radius+MCPJ_Size_Increase, 20]);
					}
				}
			}

//Put in the holes that never change size
		if (Use_MCPJ_Bearings)
			{
			if (Tab_Width-MCPJ_Bearing_Thickness >= 1.0)
				{
				translate([-15, -Proximal_Length/2+(Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor, (Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor])
					rotate(a=[0, 90, 0])
						cylinder(h=30, r=MCPJ_Bearing_Diameter/2-1, $fn=20);				
				translate([-MCPJ_Bearing_Thickness/2, -Proximal_Length/2+(Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor, (Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor])
					rotate(a=[0, 90, 0])
						cylinder(h=30, r=MCPJ_Bearing_Diameter/2, $fn=20);
				}
			else
				{
				translate([-15, -Proximal_Length/2+(Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor, (Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor])
					rotate(a=[0, 90, 0])
						cylinder(h=30, r=MCPJ_Bearing_Diameter/2, $fn=20);
				}
			}
		else
			{
			translate([-15, -Proximal_Length/2+(Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor, (Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor])
				rotate(a=[0, 90, 0])
					cylinder(h=30, r=MCPJ_Hole_Size/2, $fn=20);
			}
			
		if (Use_PIJ_Pins)
			{
			translate([9*Scale_Factor/2, Proximal_Length/2-(Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor, (Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor])
				rotate(a=[0, -90, 0])
					pinhole(h=9*Scale_Factor, lh=1.7, lt=0.7, r=PIJ_Hole_Size_P/2, tight=false);		
			}
		else
			{
			if (Use_PIJ_Bearings)
				{
				if (Tab_Width-PIJ_Bearing_Thickness >= 1.0)
					{
					translate([-15, Proximal_Length/2-(Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor, (Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor])
						rotate(a=[0, 90, 0])
							cylinder(h=30, r=PIJ_Bearing_Diameter/2-1, $fn=20);						
					translate([-PIJ_Bearing_Thickness/2, Proximal_Length/2-(Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor, (Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor])
						rotate(a=[0, 90, 0])
							cylinder(h=30, r=PIJ_Bearing_Diameter/2, $fn=20);
						}
				else
					{
					translate([-15, Proximal_Length/2-(Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor, (Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor])
						rotate(a=[0, 90, 0])
							cylinder(h=30, r=PIJ_Bearing_Diameter/2, $fn=20);				
					}
				}
			else
				{
				translate([-15, Proximal_Length/2-(Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor, (Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor])
					rotate(a=[0, 90, 0])
						cylinder(h=30, r=PIJ_Hole_Size_P/2, $fn=20);
				}
			}
			
			
			
		translate([0, Proximal_Length/2-Knuckle_Base_Radius-PIJ_Size_Increase, (2*Knuckle_Base_Radius+2*PIJ_Size_Increase-0)*Scale_Factor-Finger_Bungee_Hole_Size/2-1.0])
			rotate(a=[-atan(2*(MCPJ_Size_Increase-PIJ_Size_Increase)/((Proximal_Length/Scale_Factor)-Knuckle_Base_Radius-PIJ_Size_Increase-Knuckle_Base_Radius-MCPJ_Size_Increase)), 0, 0])
			rotate(a=[90, 0, 0])
				cylinder(h=3*Proximal_Length-Knuckle_Base_Radius-PIJ_Size_Increase-Knuckle_Base_Radius-MCPJ_Size_Increase, r=Finger_Bungee_Hole_Size/2, center=true, $fn=16);
		translate([0, 40, 1.6*Scale_Factor])
			rotate(a=[90, 0, 0])
				cylinder(h=80, r=Finger_String_Hole_Size/2+0.01, $fn=16);
		}
	
	}
	

	
module Distal(Intermediate_Length)
	{
	
	rotate(a=[0, 0, -90])
	
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
						if (Use_Minkowski)
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

						if (!Use_Minkowski)
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
							translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-PIJ_Size_Increase-5.5, -4.5+1.7-0.005, Knuckle_Base_Radius+PIJ_Size_Increase])
								rotate(a=[-90, 0, 0])
									cylinder(h=9-2*1.7+0.01, r=Knuckle_Base_Radius+PIJ_Size_Increase, $fn=32);
							translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-PIJ_Size_Increase-5.5, -4.5-0.05, Knuckle_Base_Radius+PIJ_Size_Increase])
								rotate(a=[-90, 0, 0])
									cylinder(h=9+0.1, r=Knuckle_Base_Radius+PIJ_Size_Increase-1.7, $2n=28);
							translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-PIJ_Size_Increase-5.5, 4.5-1.7, Knuckle_Base_Radius+PIJ_Size_Increase])
								rotate([90, 0, 0])
									rotate_extrude (convexity =2, $fn=32)
										translate([Knuckle_Base_Radius+PIJ_Size_Increase-1.7,0,0])
											circle (r = 1.7, $fn=32);
							translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-PIJ_Size_Increase-5.5, -4.5+1.7, Knuckle_Base_Radius+PIJ_Size_Increase])
								rotate([90, 0, 0])
									rotate_extrude (convexity =2, $fn=32)
										translate([Knuckle_Base_Radius+PIJ_Size_Increase-1.7,0,0])
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
									translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-PIJ_Size_Increase-5.5, -4.5, 0])
										cube([0.1, 9, 2*Knuckle_Base_Radius+2*PIJ_Size_Increase]);
									translate([6, -4.5, 0])
										cube([0.1, 9, 2*Knuckle_Base_Radius]);
									}
								translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-PIJ_Size_Increase-5.5, -4.5-0.01, 2*Knuckle_Base_Radius+2*PIJ_Size_Increase+0.01])
									rotate(a=[0, -atan((2*PIJ_Size_Increase)/(Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-PIJ_Size_Increase-5.5-6)), 0])
									rotate(a=[0, 90, 0])
										fillet(r=1.7, h=2*(Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-PIJ_Size_Increase-5.5));
								translate([Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-PIJ_Size_Increase-5.5, 4.5+0.01, 2*Knuckle_Base_Radius+2*PIJ_Size_Increase+0.01])
									rotate(a=[0, -atan((2*PIJ_Size_Increase)/(Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-PIJ_Size_Increase-5.5-6)), 0])
									rotate(a=[-90, 0, 0])
									rotate(a=[0, 90, 0])
										fillet(r=1.7, h=2*(Intermediate_Length/Scale_Factor-Knuckle_Base_Radius-PIJ_Size_Increase-5.5));
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
							if (Use_Minkowski)
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

							if (!Use_Minkowski)
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
						translate([Intermediate_Length/Scale_Factor-4.8-1-5.5, -(Distal_Tab_Width/2)/Scale_Factor, 12])
							rotate(a=[-90, 0, 0])
								cylinder(h=Distal_Tab_Width/Scale_Factor, r=4.8+1+0.5, $fn=28);
						translate([Intermediate_Length/Scale_Factor-4.8-1-5.5, -(Distal_Tab_Width/2)/Scale_Factor, 4.8+1])
							rotate(a=[-90, 0, 0])
								cylinder(h=Distal_Tab_Width/Scale_Factor, r=4.8+1+0.5, $fn=28);
						}
					translate([Intermediate_Length/Scale_Factor-4.8-1-5.5, -(Distal_Tab_Width/2)/Scale_Factor, -1])
						cube([4.8, Distal_Tab_Width/Scale_Factor, 11]);

					}
				}

//Put in the holes that never change size
			if (Use_PIJ_Pins)
				{
				difference()
					{
					union()
						{
						translate([Intermediate_Length-(Knuckle_Base_Radius+PIJ_Size_Increase+5.5)*Scale_Factor, 9*Scale_Factor/2, (Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor])
							rotate(a=[90, 0, 0])
								pinhole(h=9*Scale_Factor, lh=1.7, lt=1.0, r=PIJ_Hole_Size_I/2, tight=false);
						translate([Intermediate_Length-(Knuckle_Base_Radius+PIJ_Size_Increase+5.5)*Scale_Factor, 9*Scale_Factor/2+0.6, (Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor])
							rotate(a=[90, 0, 0])
								cylinder(h=PIJ_Pin_Head_Height+1, r=1.5*PIJ_Hole_Size_I/2+0.15, $fn=16);
						}
					translate([Intermediate_Length-(Knuckle_Base_Radius+PIJ_Size_Increase+5.5)*Scale_Factor-5, -10, (Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor-10-PIJ_Hole_Size_I/2+0.375-0.15])
						cube([10, 20, 10]);
					translate([Intermediate_Length-(Knuckle_Base_Radius+PIJ_Size_Increase+5.5)*Scale_Factor-5, -10, (Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor+PIJ_Hole_Size_I/2-0.375+0.15])
						cube([10, 20, 10]);
					}
				}
			else
				{
				if (Use_PIJ_Bearings)
					{
					translate([Intermediate_Length-(Knuckle_Base_Radius+PIJ_Size_Increase+5.5)*Scale_Factor, 15, (Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor])
						rotate(a=[90, 0, 0])
							cylinder(h=30, r=PIJ_Bearing_Pin_Size/2, $fn=20);					
					if (Inset_PIJ_Rivets)
						{
						translate([Intermediate_Length-(Knuckle_Base_Radius+PIJ_Size_Increase+5.5)*Scale_Factor, -4.5*Scale_Factor+PIJ_Rivet_Depth, (Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor])
							rotate(a=[90, 0, 0])
								cylinder(h=30, r=PIJ_Rivet_Diameter/2, $fn=20);						
						translate([Intermediate_Length-(Knuckle_Base_Radius+PIJ_Size_Increase+5.5)*Scale_Factor, 30+4.5*Scale_Factor-PIJ_Rivet_Depth, (Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor])
							rotate(a=[90, 0, 0])
								cylinder(h=30, r=PIJ_Rivet_Diameter/2, $fn=20);						
						}
					}
				else
					{
					translate([Intermediate_Length-(Knuckle_Base_Radius+PIJ_Size_Increase+5.5)*Scale_Factor, 15, (Knuckle_Base_Radius+PIJ_Size_Increase)*Scale_Factor])
						rotate(a=[90, 0, 0])
							cylinder(h=30, r=PIJ_Hole_Size_I/2, $fn=20);					
					}
				}	
			if (Use_Finger_Bungee_Tieoff)
				{
				hull()
					{
					translate([Intermediate_Length-21.5*Scale_Factor, (-Distal_Tab_Width+Finger_Bungee_Hole_Size)/2, 2.8*Scale_Factor])
						rotate(a=[0, 90, 0])
							cylinder(h=30, r=Finger_Bungee_Hole_Size/2-0.01, $fn=16);
					translate([Intermediate_Length-21.5*Scale_Factor, (Distal_Tab_Width-Finger_Bungee_Hole_Size)/2, 2.8*Scale_Factor])
						rotate(a=[0, 90, 0])
							cylinder(h=30, r=Finger_Bungee_Hole_Size/2-0.01, $fn=16);
					}
				translate([Intermediate_Length-21.5*Scale_Factor, -Distal_Tab_Width/2, -1])
					cube([30, Distal_Tab_Width, 2.8*Scale_Factor+1]);
				}
			if (!Use_Finger_Bungee_Tieoff)
				{
				translate([-20, 0, 2.8*Scale_Factor])
					rotate(a=[0, 90, 0])
						cylinder(h=80, r=Finger_Bungee_Hole_Size/2, $fn=16);
				translate([-24, 0, 2.8*Scale_Factor])
					rotate(a=[0, 90, 0])
						cylinder(h=20, r=Finger_Bungee_Hole_Size/2+0.5, $fn=16);
				translate([Intermediate_Length-4.8-5.5-9.7, -Finger_Bungee_Hole_Size/2, -1])
					cube([30, Finger_Bungee_Hole_Size, 2.8*Scale_Factor+1]);
				}
			translate([-14, 0, 2*Knuckle_Base_Radius*Scale_Factor-Finger_String_Hole_Size/2-Knuckle_Base_Radius/4])
				rotate(a=[0, 90, 0])
					cylinder(h=80, r=Finger_String_Hole_Size/2-0.01, $fn=16);
			translate([-13, 0, 2*Knuckle_Base_Radius*Scale_Factor-Finger_String_Hole_Size/2-Knuckle_Base_Radius/4])
				rotate(a=[0, -60, 0])
					cylinder(h=20, r=Finger_String_Hole_Size/2+0.5, $fn=16);
			translate([Intermediate_Length-(13+4.8+5.5)*Scale_Factor, -Finger_String_Hole_Size/2, 2*Knuckle_Base_Radius*Scale_Factor-Finger_String_Hole_Size/2-Knuckle_Base_Radius/4])
				cube([30, Finger_String_Hole_Size, 2.8*Scale_Factor+1]);

			}

//Print a reference cube to see if the intermediate length is correct.				
//		translate([-5.5*Scale_Factor,8,0])
//			cube([26, 2, 2]);	
		
//Add binder post
		if (Use_Finger_Bungee_Tieoff)
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
				
		if (Use_PIJ6)
			{
			translate([Intermediate_Length+2, 0, 0])
				pin_horizontal(h=9*Scale_Factor, lh=1.7, lt=1.0, r=PIJ_Hole_Size_I/2, tight=false);
			translate([Intermediate_Length+2, 9*Scale_Factor/2, (PIJ_Hole_Size_I-0.5)/2])
				rotate(a=[90, 0, 0])
					difference()
						{
						cylinder(h=PIJ_Pin_Head_Height, r=1.5*PIJ_Hole_Size_I/2, $fn=16);
						translate([-5, -10-PIJ_Hole_Size_I/2+0.375, -5])
							cube([10, 10, 10]);
						translate([-5, PIJ_Hole_Size_I/2-0.375, -5])
							cube([10, 10, 10]);
						}
			}	
		}
	
	}
	
	
	
module custom_pin()
	{
	pin_horizontal(h=9*Scale_Factor, lh=1.7, lt=1.0, r=PIJ_Hole_Size_P/2, tight=false);
	translate([0, 9*Scale_Factor/2, (PIJ_Hole_Size_P-0.5)/2])
		rotate(a=[90, 0, 0])
			difference()
				{
				cylinder(h=PIJ_Pin_Head_Height, r=1.5*PIJ_Hole_Size_P/2, $fn=16);
				translate([-5, -10-PIJ_Hole_Size_P/2+0.375, -5])
					cube([10, 10, 10]);
				translate([-5, PIJ_Hole_Size_P/2-0.375, -5])
					cube([10, 10, 10]);
				}
	}
	
