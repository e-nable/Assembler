/*

Parametric Mechen - Second Degree - Hand Portion
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

Print_Knuckle_Block=true;
Print_Main_Cuff=true;
Print_Gimbal_Cuff=true;
Print_Pinky_Side_Mount=true;
Print_Thumb_Side_Mount=true;



//CALCULATED VALUES

//The following values are used in constructing the hand.  It should not, generally, be
//necessary to modify any of these values.  They are here, however, in case some change
//is needed.

//Knuckle_Tab_Width controls how tightly the finger tabs fit within the knuckle slots.
//This value is slightly larger than the tabs themselves so that there is room to move.
//If you add too much to the width, then the finger will wobble side-to-side.  If you
//add too little, then the finger will be too tight and won't move nicely.
Knuckle_Tab_Width=Tab_Width+0.4;

//Tab_Slot_Separation is how far apart the slots are on the knuckle block.  It should
//not be necessary to change this directly.  It can be changed by modifying the
//Knuckle_Slot_Adjustment parameter in the HandParameters file.
Tab_Slot_Separation=10*Scale_Factor+Knuckle_Slot_Adjustment;

//Bungee_Cutout_Width is the width of the cut outs towards the hand to make the tie-off
//rods more accessible.
Bungee_Cutout_Width=8*Scale_Factor;

//MCPJ_Hole_Size2 is the size of the knuckle hole on the outermost portions of the block.
//Generally, this will match the MCPJ_Hole_Size - the hole will be consistent all the way
//through.  It is possible, if nut traps are not used, to tap the outer portions to get
//the same result as the nut traps.  In that case, MCPJ_Hole_Size2 would be set to a value
//like M4T.
MCPJ_Hole_Size2=MCPJ_Hole_Size;

//Knuckle_Block_Width is used by the Cuff module to simplify it a bit.
Knuckle_Block_Width=(4*Tab_Slot_Separation+4*Knuckle_Tab_Width)/Scale_Factor+2*0.8;

//Gimbal_Height is the calculated distance from the wrist pivot to the underside
//of the gimbal.
Gimbal_Height=Wrist_Thickness/2+(3+4)*Scale_Factor;

//Gimbal_Hand_Width provides for a little bit of flare in the gimbal as
//it goes towards the fingers.  There are generally fleshy palm portions
//that make the hand flare out quite a bit from the wrist measure.  This
//is a hard thing to measure.  A good first approximation is about eight
//mm more than the Wrist_Width value.
Gimbal_Hand_Width=Wrist_Width+8;

//Wrist_Outside_Radius is a calculated value used to make a rounded section for
//the wrist side of the gimbal cuff.
Wrist_Outside_Radius=Wrist_Width/(2*Scale_Factor)+2-12;

//Hand_Outside_Radius is a calculated value used to make a rounded section for
//the hand side of the gimbal cuff.
Hand_Outside_Radius=Gimbal_Hand_Width/(2*Scale_Factor)+2-12;

//Gimbal_String_Block_Width is a calculated value for how wide the integrated cable
//block needs to be.  This block also holds an inset nylock nut and fender washer
//for the gimbal pivot joint.
Gimbal_String_Block_Width=String_Count*String_Hole_Diameter+(String_Count+2)*Gimbal_String_Spacing+9;



//RENDER

if (Print_Knuckle_Block)
	KnuckleBlock();

if (Print_Main_Cuff)
	{
	if (Left_Hand)
		{
		translate([-12*Scale_Factor, -4*Scale_Factor, Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase+3)*Scale_Factor])
			rotate(a=[0, 0, 90])
				rotate(a=[180, 0, 0])
					Cuff();
		translate([-18*Scale_Factor, -16*Scale_Factor, -Cuff_Height-(Knuckle_Base_Radius+MCPJ_Size_Increase+3)*Scale_Factor])
			rotate(a=[0, 0, 0])
				Cuff_Guide();
		}

	if (!Left_Hand)
		mirror([1, 0, 0])
		{
		translate([-12*Scale_Factor, -4*Scale_Factor, Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase+3)*Scale_Factor])
			rotate(a=[0, 0, 90])
				rotate(a=[180, 0, 0])
					Cuff();
		translate([-18*Scale_Factor, -16*Scale_Factor, -Cuff_Height-(Knuckle_Base_Radius+MCPJ_Size_Increase+3)*Scale_Factor])
			rotate(a=[0, 0, 0])
				Cuff_Guide();
		}
	}
	
if (Print_Gimbal_Cuff)
	{
	if (Left_Hand)
		translate([12*Scale_Factor, -14*Scale_Factor, 0])
			rotate(a=[0, 0, -90])
				CuffGimbal();
	
	if (!Left_Hand)
		mirror([1, 0, 0])
			translate([12*Scale_Factor, -14*Scale_Factor, 0])
				rotate(a=[0, 0, -90])
					CuffGimbal();
	}

if (Print_Pinky_Side_Mount)
	{
	if (Left_Hand)
		translate([-16*Scale_Factor, -33*Scale_Factor, 0])
			rotate(a=[0, 0, 90])
				PinkySideMount();
	
	if (!Left_Hand)
		mirror([1, 0, 0])
			translate([-16*Scale_Factor, -33*Scale_Factor, 0])
				rotate(a=[0, 0, 90])
					PinkySideMount();
	}

if (Print_Thumb_Side_Mount)
	{
	if (Left_Hand)
		translate([-18*Scale_Factor, 14*Scale_Factor, 0])
			rotate(a=[0, 0, 90])
				{
				ThumbSideKnuckle();
				translate([-24*Scale_Factor, -18*Scale_Factor, 0])
					ThumbSideArm();
				}

	if (!Left_Hand)
		mirror([1, 0, 0])
			translate([-18*Scale_Factor, 14*Scale_Factor, 0])
				rotate(a=[0, 0, 90])
					{
					ThumbSideKnuckle();
					translate([-24*Scale_Factor, -18*Scale_Factor, 0])
						ThumbSideArm();
					}		
	}
	
	
	
module KnuckleBlock()
	{

//Add in static parts after removal of others
	union()
		{
	
//Remove static sized portions 
		difference()
			{

//Scale everything that is not static
			scale([Scale_Factor, Scale_Factor, Scale_Factor])
				{

//Build the main block out of separate shapes
				union()
					{
					translate([-(4*Tab_Slot_Separation+4*Knuckle_Tab_Width)/(2*Scale_Factor)-1, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase), 0])
						cube([(4*Tab_Slot_Separation+4*Knuckle_Tab_Width)/Scale_Factor+2, 4.0+Knuckle_Base_Radius+MCPJ_Size_Increase, 2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2.8]);
					translate([-(4*Tab_Slot_Separation+4*Knuckle_Tab_Width)/(2*Scale_Factor)-1, 0, Knuckle_Base_Radius+MCPJ_Size_Increase])
						rotate(a=[0, 90, 0])
							cylinder(h=(4*Tab_Slot_Separation+4*Knuckle_Tab_Width)/Scale_Factor+2, r=Knuckle_Base_Radius+MCPJ_Size_Increase, $fn=32);	
					if (Use_Support)
						{
						translate([-(4*Tab_Slot_Separation+4*Knuckle_Tab_Width)/(2*Scale_Factor)-1, -(Knuckle_Base_Radius+MCPJ_Size_Increase)/2, 0])
							cube([(4*Tab_Slot_Separation+4*Knuckle_Tab_Width)/Scale_Factor+2, 1.1*(Knuckle_Base_Radius+MCPJ_Size_Increase), 6]);						
						}
					}
				}

//Put in the holes that never change size

//Cut outs on the end that allow the mount pieces to sit further forward.
//This is important for the hole side so that the angle part does not hit
//the webbing of the thumb.
			translate([(4*Tab_Slot_Separation+4*Knuckle_Tab_Width)/2-0.8*Scale_Factor, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor-1, -1])
				cube([10, (5.0)*Scale_Factor+1, (2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2.8)*Scale_Factor+2]);
			translate([-(4*Tab_Slot_Separation+4*Knuckle_Tab_Width)/2-10+0.8*Scale_Factor, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor-1, -1])
				cube([10, (5.0)*Scale_Factor+1, (2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2.8)*Scale_Factor+2]);
			
//Screw holes to hold the fingers on
			translate([-(3*Tab_Slot_Separation+2*Knuckle_Tab_Width)/2-1, 0, (Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor])
				rotate(a=[0, 90, 0])
					cylinder(h=3*Tab_Slot_Separation+2*Knuckle_Tab_Width+2, r=(MCPJ_Hole_Size-0.2)/2, $fn=20);
			translate([-(4*Tab_Slot_Separation+4*Knuckle_Tab_Width)/2-20, 0, (Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor])
				rotate(a=[0, 90, 0])
					cylinder(h=4*Tab_Slot_Separation+4*Knuckle_Tab_Width+40, r=(MCPJ_Hole_Size2-0.2)/2, $fn=20);

//Slots to insert the proximal sections
			translate([1.5*Tab_Slot_Separation+Knuckle_Tab_Width, -(1.5+Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor, -1])
				cube([Knuckle_Tab_Width, 30, (2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+1.2)*Scale_Factor+1]);
			translate([0.5*Tab_Slot_Separation, -(1.5+Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor, -1])
				cube([Knuckle_Tab_Width, 30, (2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+1.2)*Scale_Factor+1]);
			translate([-0.5*Tab_Slot_Separation-Knuckle_Tab_Width, -(1.5+Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor, -1])
				cube([Knuckle_Tab_Width, 30, (2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+1.2)*Scale_Factor+1]);
			translate([-1.5*Tab_Slot_Separation-2*Knuckle_Tab_Width, -(1.5+Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor, -1])
				cube([Knuckle_Tab_Width, 30, (2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+1.2)*Scale_Factor+1]);

//Clear slots all the way through for the tie-off rods
			if (Use_Bungee_Tie_Rods)
				{
				difference()
					{
					union()
						{
						translate([1.5*Tab_Slot_Separation+1.5*Knuckle_Tab_Width-Bungee_Cutout_Width/2, -(4.5+Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor-1, (1.5*Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor])
							cube([Bungee_Cutout_Width, 9*Scale_Factor, (0.5*Knuckle_Base_Radius+MCPJ_Size_Increase+1.2)*Scale_Factor]);
						translate([0.5*Tab_Slot_Separation+Knuckle_Tab_Width/2-Bungee_Cutout_Width/2, -(4.5+Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor-1, (1.5*Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor])
							cube([Bungee_Cutout_Width, 9*Scale_Factor, (0.5*Knuckle_Base_Radius+MCPJ_Size_Increase+1.2)*Scale_Factor]);
						translate([-0.5*Tab_Slot_Separation-Knuckle_Tab_Width/2-Bungee_Cutout_Width/2, -(4.5+Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor-1, (1.5*Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor])
							cube([Bungee_Cutout_Width, 9*Scale_Factor, (0.5*Knuckle_Base_Radius+MCPJ_Size_Increase+1.2)*Scale_Factor]);
						translate([-1.5*Tab_Slot_Separation-1.5*Knuckle_Tab_Width-Bungee_Cutout_Width/2, -(4.5+Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor-1, (1.5*Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor])
							cube([Bungee_Cutout_Width, 9*Scale_Factor, (0.5*Knuckle_Base_Radius+MCPJ_Size_Increase+1.2)*Scale_Factor]);
						}				
					
//Leave the circular contact area of the proximal joint	intact		
					translate([-(4*Tab_Slot_Separation+4*Knuckle_Tab_Width)/2, 0, (Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor])
						rotate(a=[0, 90, 0])
							cylinder(h=4*Tab_Slot_Separation+4*Knuckle_Tab_Width, r=(Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor, $fn=32);	
					}
				}

			if (!Use_Bungee_Tie_Rods)
				{
				translate([-(4*Tab_Slot_Separation+4*Knuckle_Tab_Width+2)/2, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor-1, (2*Knuckle_Base_Radius+2*MCPJ_Size_Increase)*Scale_Factor])
					cube([4*Tab_Slot_Separation+4*Knuckle_Tab_Width+2, 6*Scale_Factor+1, 10*Scale_Factor]);
				}
					
//Holes for strings
			translate([1.5*Tab_Slot_Separation+1.5*Knuckle_Tab_Width, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase-1.5)*Scale_Factor, Knuckle_Base_Radius+MCPJ_Size_Increase])
				rotate(a=[60, 0, 0])
					translate([0, 0, -10])
						cylinder(h=30, r=String_Hole_Diameter/2, $fn=16);
			translate([0.5*Tab_Slot_Separation+0.5*Knuckle_Tab_Width, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase-1.5)*Scale_Factor, Knuckle_Base_Radius+MCPJ_Size_Increase])
				rotate(a=[60, 0, 0])
					translate([0, 0, -10])			
						cylinder(h=30, r=String_Hole_Diameter/2, $fn=16);
			translate([-0.5*Tab_Slot_Separation-0.5*Knuckle_Tab_Width, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase-1.5)*Scale_Factor, Knuckle_Base_Radius+MCPJ_Size_Increase])
				rotate(a=[60, 0, 0])
					translate([0, 0, -10])			
						cylinder(h=30, r=String_Hole_Diameter/2, $fn=16);
			translate([-1.5*Tab_Slot_Separation-1.5*Knuckle_Tab_Width, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase-1.5)*Scale_Factor, Knuckle_Base_Radius+MCPJ_Size_Increase])
				rotate(a=[60, 0, 0])
					translate([0, 0, -10])			
						cylinder(h=30, r=String_Hole_Diameter/2, $fn=16);
		
//Nut traps to allow the use of standard screws for the main knuckle pivot			
			if (Use_Knuckle_Nut_Traps)
				{
				translate([-1.5*Tab_Slot_Separation-2*Knuckle_Tab_Width-Knuckle_Nut_Thickness-0.2, 0, (Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor])	
					rotate(a=[0, 90, 0])
						cylinder(h=Knuckle_Nut_Thickness+1, r=Knuckle_Nut_Radius, $fn=6);
				translate([1.5*Tab_Slot_Separation+2*Knuckle_Tab_Width-1+0.2, 0, (Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor])	
					rotate(a=[0, 90, 0])
						cylinder(h=Knuckle_Nut_Thickness+1, r=Knuckle_Nut_Radius, $fn=6);
				}
			}
	
//Rods to tie off bungees
		if (Use_Bungee_Tie_Rods)
			{
			translate([1.5*Tab_Slot_Separation+1.5*Knuckle_Tab_Width, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase-1.25)*Scale_Factor, (1.5*Knuckle_Base_Radius+MCPJ_Size_Increase-0.2)*Scale_Factor])
				cylinder(h=(0.5*Knuckle_Base_Radius+MCPJ_Size_Increase+1.2+0.4)*Scale_Factor, r=Bungee_Tie_Rod_Size/2*Scale_Factor, $fn=16);
			translate([0.5*Tab_Slot_Separation+0.5*Knuckle_Tab_Width, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase-1.25)*Scale_Factor, (1.5*Knuckle_Base_Radius+MCPJ_Size_Increase-0.2)*Scale_Factor])
				cylinder(h=(0.5*Knuckle_Base_Radius+MCPJ_Size_Increase+1.2+0.4)*Scale_Factor, r=Bungee_Tie_Rod_Size/2*Scale_Factor, $fn=16);
			translate([-0.5*Tab_Slot_Separation-0.5*Knuckle_Tab_Width, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase-1.25)*Scale_Factor, (1.5*Knuckle_Base_Radius+MCPJ_Size_Increase-0.2)*Scale_Factor])
				cylinder(h=(0.5*Knuckle_Base_Radius+MCPJ_Size_Increase+1.2+0.4)*Scale_Factor, r=Bungee_Tie_Rod_Size/2*Scale_Factor, $fn=16);
			translate([-1.5*Tab_Slot_Separation-1.5*Knuckle_Tab_Width, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase-1.25)*Scale_Factor, (1.5*Knuckle_Base_Radius+MCPJ_Size_Increase-0.2)*Scale_Factor])
				cylinder(h=(0.5*Knuckle_Base_Radius+MCPJ_Size_Increase+1.2+0.4)*Scale_Factor, r=Bungee_Tie_Rod_Size/2*Scale_Factor, $fn=16);			
			}
		}
	
	}


	
module Cuff()
	{
	difference()
		{

		scale([Scale_Factor, Scale_Factor, Scale_Factor])
			{

			difference()
				{
				union()
					{
					
					translate([-Knuckle_Block_Width/2, -Mount_Length/Scale_Factor, -1.45])
						cube([3, 18, 2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7+0.01]);
					difference()
						{
						translate([-0.01, -Mount_Length/Scale_Factor, Cuff_Height/Scale_Factor+Knuckle_Base_Radius+MCPJ_Size_Increase])
							cube([Knuckle_Block_Width/2+Tab_Slot_Separation/(2*Scale_Factor)+0.01, 18, 3]);
						translate([Knuckle_Block_Width/2+Tab_Slot_Separation/(2*Scale_Factor), -15, 0])
							rotate(a=[0, 0, -12])
								translate([0, -80, 0])
									cube([20, 100, 40]);
						}
					union()
						{
						translate([-Knuckle_Block_Width/2+Cuff_Height/Scale_Factor+1.45-Knuckle_Base_Radius-MCPJ_Size_Increase+3-2*1.7, -Mount_Length/Scale_Factor, Cuff_Height/Scale_Factor+Knuckle_Base_Radius+MCPJ_Size_Increase])
							cube([Knuckle_Block_Width/2-(Cuff_Height/Scale_Factor+1.45-Knuckle_Base_Radius-MCPJ_Size_Increase+3-2*1.7), 18, 3]);
						translate([-Knuckle_Block_Width/2+Cuff_Height/Scale_Factor+1.45-Knuckle_Base_Radius-MCPJ_Size_Increase+3-2*1.7, -Mount_Length/Scale_Factor, -1.45+2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7])
							rotate(a=[-90, 0, 0])
								intersection ()
									{
									difference()
										{
										cylinder(h=18, r=Cuff_Height/Scale_Factor+1.45-Knuckle_Base_Radius-MCPJ_Size_Increase+3-2*1.7, $fn=32);
										translate([0, 0, -1])
											cylinder(h=20, r=Cuff_Height/Scale_Factor+1.45-Knuckle_Base_Radius-MCPJ_Size_Increase+3-2*1.7-3, $fn=20);
										}
									translate([-10, -10, 0])
										cube([10, 10, 20]);
									}
						if (Use_Support)
							{
							translate([-Knuckle_Block_Width/2+1.2, -Mount_Length/Scale_Factor, Cuff_Height/Scale_Factor+Knuckle_Base_Radius+MCPJ_Size_Increase])
								cube([4, 18, 3]);
							}
						}
					hull()
						{
						translate([0, -Wrist_Distance/Scale_Factor+10, Cuff_Height/Scale_Factor+Knuckle_Base_Radius+MCPJ_Size_Increase])
							cylinder(h=3, r=7);
						translate([-12, -Wrist_Distance/Scale_Factor+10+7, Cuff_Height/Scale_Factor+Knuckle_Base_Radius+MCPJ_Size_Increase])
							cube([24, 3, 3]);
						}
					hull()
						{
						translate([-0.01, -Wrist_Distance/Scale_Factor+10+7+2.5, Cuff_Height/Scale_Factor+Knuckle_Base_Radius+MCPJ_Size_Increase])
							cube([12.01, 0.5, 3]);	
						difference()
							{
							translate([-0.01, -Mount_Length/Scale_Factor, Cuff_Height/Scale_Factor+Knuckle_Base_Radius+MCPJ_Size_Increase])
								cube([Knuckle_Block_Width/2+Tab_Slot_Separation/(2*Scale_Factor)+0.01, 0.5, 3]);
							translate([Knuckle_Block_Width/2+Tab_Slot_Separation/(2*Scale_Factor), -15, 0])
								rotate(a=[0, 0, -12])
									translate([0, -80, 0])
										cube([20, 100, 40]);
							}						
						}
					hull()
						{
						translate([-12, -Wrist_Distance/Scale_Factor+10+7+2.5, Cuff_Height/Scale_Factor+Knuckle_Base_Radius+MCPJ_Size_Increase])
							cube([12, 0.5, 3]);
						translate([-Knuckle_Block_Width/2+Cuff_Height/Scale_Factor+1.45-Knuckle_Base_Radius-MCPJ_Size_Increase+3-2*1.7, -Mount_Length/Scale_Factor, Cuff_Height/Scale_Factor+Knuckle_Base_Radius+MCPJ_Size_Increase])
							cube([Knuckle_Block_Width/2-(Cuff_Height/Scale_Factor+1.45-Knuckle_Base_Radius-MCPJ_Size_Increase+3-2*1.7), 18, 3]);							
						}
					}
				translate([-Knuckle_Block_Width/2, -Mount_Length/Scale_Factor-0.01, -1.45-0.01])
					rotate(a=[0, -90, 0])
						fillet(r=2, h=40);
				}
			}

//Put in the holes that never change size

//Mounting holes to the main mount block
		translate([-Knuckle_Block_Width*Scale_Factor/2+10, -Mount_Length+5*Scale_Factor, (Knuckle_Base_Radius+MCPJ_Size_Increase+1.7-1.45)*Scale_Factor])		
			rotate(a=[0, -90, 0])
				cylinder(h=20, r=Mount_Screw_Size/2);
		translate([-Knuckle_Block_Width*Scale_Factor/2+10, -Mount_Length+(5+8)*Scale_Factor, (Knuckle_Base_Radius+MCPJ_Size_Increase+1.7-1.45)*Scale_Factor])		
			rotate(a=[0, -90, 0])
				cylinder(h=20, r=Mount_Screw_Size/2);

		translate([-Knuckle_Block_Width*Scale_Factor/2+3*Scale_Factor+Mount_Screw_Size-0.2, -Mount_Length+5*Scale_Factor, (Knuckle_Base_Radius+MCPJ_Size_Increase+1.7-1.45)*Scale_Factor])		
			rotate(a=[0, -90, 0])
				cylinder(h=2*Mount_Screw_Size, r1=2*Mount_Screw_Size, r2=0);
		translate([-Knuckle_Block_Width*Scale_Factor/2+3*Scale_Factor+Mount_Screw_Size-0.2, -Mount_Length+(5+8)*Scale_Factor, (Knuckle_Base_Radius+MCPJ_Size_Increase+1.7-1.45)*Scale_Factor])		
			rotate(a=[0, -90, 0])
				cylinder(h=2*Mount_Screw_Size, r1=2*Mount_Screw_Size, r2=0);						

//Mounting holes into the floating hole mount portion		
		translate([Knuckle_Block_Width/2-0.5*Scale_Factor, -Mount_Length-0.5, 0])
			rotate(a=[0, 0, -12])
				{
				translate([0, 8, 60])
					polyhole(h=120, d=Mount_Screw_Size);
				translate([0, 16, 60])
					polyhole(h=120, d=Mount_Screw_Size);
				}
			
		translate([Knuckle_Block_Width/2-0.5*Scale_Factor, -Mount_Length-0.5, Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor-Mount_Screw_Size+0.2])
			rotate(a=[0, 0, -12])
				{
				translate([0, 8, 0])
					cylinder(h=2*Mount_Screw_Size, r1=2*Mount_Screw_Size, r2=0);
				translate([0, 16, 0])
					cylinder(h=2*Mount_Screw_Size, r1=2*Mount_Screw_Size, r2=0);
				}

//Add some holes to connect velcro to hold the hand.
//Screw holes for the velcro
		translate([0, -Mount_Length+6, 50])
			polyhole(h=100, d=Mount_Screw_Size);
		translate([-9*Scale_Factor, -Mount_Length+18*Scale_Factor-6, 50])
			polyhole(h=100, d=Mount_Screw_Size);
		translate([9*Scale_Factor, -Mount_Length+18*Scale_Factor-6, 50])
			polyhole(h=100, d=Mount_Screw_Size);

//Counter sink the velcro mounting screws
		translate([0, -Mount_Length+6, Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor-Mount_Screw_Size+0.2])
			cylinder(h=2*Mount_Screw_Size, r1=2*Mount_Screw_Size, r2=0);
		translate([-9*Scale_Factor, -Mount_Length+18*Scale_Factor-6, Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor-Mount_Screw_Size+0.2])
			cylinder(h=2*Mount_Screw_Size, r1=2*Mount_Screw_Size, r2=0);
		translate([9*Scale_Factor, -Mount_Length+18*Scale_Factor-6, Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase)*Scale_Factor-Mount_Screw_Size+0.2])
			cylinder(h=2*Mount_Screw_Size, r1=2*Mount_Screw_Size, r2=0);		
			
//Hole for gimble mount to provide lateral wrist motion			
		translate([0, -Wrist_Distance+10*Scale_Factor, 20])
			polyhole(h=40, d=Pivot_Screw_Size);
		translate([0, -Wrist_Distance+10*Scale_Factor, -40+Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase+1)*Scale_Factor])
			cylinder(h=40, r=5.0);

		}
	}
	


module Cuff_Guide()
	{
	difference()
		{

		scale([Scale_Factor, Scale_Factor, Scale_Factor])
			{

			difference()
				{
				union()
					{
					
//String guide block
				translate([0, -Mount_Length/Scale_Factor, Cuff_Height/Scale_Factor+Knuckle_Base_Radius+MCPJ_Size_Increase+3-1])
					difference()
						{
						translate([-20, 0, 0])
							cube([40, 18, 9]);
						translate([12, 0, -1])
							rotate(a=[0, 0, -12])
								cube([20, 40, 15]);
						mirror([1, 0, 0])
							translate([12, 0, -1])
								rotate(a=[0, 0, -12])
									cube([20, 40, 15]);
						translate([0, 0, 9-0.05])
							rotate(a=[-atan(2/18), 0, 0])
							translate([-18, -3, 0])
								cube([36, 30, 10]);
						translate([12.01, 0, 9.01])
							rotate(a=[0, 0, -12])
							rotate(a=[0, 180, 0])
							rotate(a=[90+atan(2/18), 0, 0])
								fillet(h=60, r=4.5);
						mirror([1, 0, 0])								
							translate([12.01, 0, 9.01])
								rotate(a=[0, 0, -12])
								rotate(a=[0, 180, 0])
								rotate(a=[90+atan(2/18), 0, 0])
									fillet(h=60, r=4.5);
						}
					}

				translate([0, -Mount_Length/Scale_Factor-1, Cuff_Height/Scale_Factor+Knuckle_Base_Radius+MCPJ_Size_Increase+3-3])
					translate([-20, 0, 0])
						cube([40, 20, 3]);
				}
			}

//Put in the holes that never change size

//Add some nut traps and holes to connect velcro to hold the hand.
//Nut traps for the velcro			
		translate([0, -Mount_Length+6, Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase+3+7-1+1.5)*Scale_Factor-Mount_Nut_Thickness])
			rotate(a=[0, 0, 30])
				cylinder(h=10, r=Mount_Nut_Radius-0.1, $fn=6);
		translate([-9*Scale_Factor, -Mount_Length+18*Scale_Factor-6, Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase+3+7-1+0.5)*Scale_Factor-Mount_Nut_Thickness])
			rotate(a=[0, 0, 30])
				cylinder(h=10, r=Mount_Nut_Radius-0.1, $fn=6);
		translate([9*Scale_Factor, -Mount_Length+18*Scale_Factor-6, Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase+3+7-1+0.5)*Scale_Factor-Mount_Nut_Thickness])
			rotate(a=[0, 0, 30])
				cylinder(h=10, r=Mount_Nut_Radius-0.1, $fn=6);
//Screw holes for the velcro
		translate([0, -Mount_Length+6, 50])
			polyhole(h=100, d=Mount_Screw_Size);
		translate([-9*Scale_Factor, -Mount_Length+18*Scale_Factor-6, 50])
			polyhole(h=100, d=Mount_Screw_Size);
		translate([9*Scale_Factor, -Mount_Length+18*Scale_Factor-6, 50])
			polyhole(h=100, d=Mount_Screw_Size);

//Holes for strings
		translate([-9*Scale_Factor, -56, 3.5*Scale_Factor])
		rotate(a=[0, 0, 12])
		translate([0, 0, Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase+3+7-2-3)*Scale_Factor])		
			rotate(a=[90-1.6*atan(2/18), 0, 0])
				polyhole(h=100, d=String_Hole_Diameter);
		translate([-4.5*Scale_Factor, -56, 3.5*Scale_Factor])
		rotate(a=[0, 0, 4])
		translate([0, 0, Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase+3+7-2-3)*Scale_Factor])
			rotate(a=[90-1.6*atan(2/18), 0, 0])
				polyhole(h=100, d=String_Hole_Diameter);
		translate([4.5*Scale_Factor, -56, 3.5*Scale_Factor])
		rotate(a=[0, 0, -4])
		translate([0, 0, Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase+3+7-2-3)*Scale_Factor])
			rotate(a=[90-1.6*atan(2/18), 0, 0])
				polyhole(h=100, d=String_Hole_Diameter);
		translate([9*Scale_Factor, -56, 3.5*Scale_Factor])
		rotate(a=[0, 0, -12])
		translate([0, 0, Cuff_Height+(Knuckle_Base_Radius+MCPJ_Size_Increase+3+7-2-3)*Scale_Factor])
			rotate(a=[90-1.6*atan(2/18), 0, 0])
				polyhole(h=100, d=String_Hole_Diameter);

		}
	}

	
	
module CuffGimbal()
	{
	
	translate([0, 0, -1*Scale_Factor])

	//Remove static sized portions 
	difference()
		{

//Scale everything that is not static
		scale([Scale_Factor, Scale_Factor, Scale_Factor])
			{

//Remove any portions that should be scaled along with the gimbal cuff
			difference()
				{

//Build the main block out of separate shapes
				union()
					{

//Remove an inner shell from an outer shell to form the gimbal body.						
					difference()
						{
							
//Produce the outer shell.  Because of how hull works, it will be a solid.
						hull()
							{
					
//Produce an arc for the wrist side portion of the gimbal.						
							union()
								{
								translate([-12.01,Gimbal_Height/Scale_Factor+3,Gimbal_Thickness-0.5])
									cube([24.02,2,0.5]);
								translate([-Wrist_Width/(2*Scale_Factor)-2,0,Gimbal_Thickness-0.5])
									cube([2,Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius+0.01,0.5]);
								translate([Wrist_Width/(2*Scale_Factor),0,Gimbal_Thickness-0.5])
									cube([2,Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius+0.01,0.5]);
								difference()
									{
									intersection()
										{
										translate([12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, Gimbal_Thickness-0.5])
											cylinder(h=0.5, r=Wrist_Outside_Radius);
										translate([12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, Gimbal_Thickness-0.5])
											cube([Wrist_Outside_Radius, Wrist_Outside_Radius, 0.5]);
										}
									translate([12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, -1])
										cylinder(h=100, r=Wrist_Outside_Radius-2);	
									}
								difference()
									{
									intersection()
										{
										translate([-12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, Gimbal_Thickness-0.5])
											cylinder(h=0.5, r=Wrist_Outside_Radius);
										translate([-12-Wrist_Outside_Radius, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, Gimbal_Thickness-0.5])
											cube([Wrist_Outside_Radius, Wrist_Outside_Radius, 0.5]);
										}
									translate([-12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, -1])
										cylinder(h=100, r=Wrist_Outside_Radius-2);	
									}
								}

//Produce an arc for the hand side portion of the gimbal.						
							union()
								{
								translate([-12.01,Gimbal_Height/Scale_Factor+3,0])
									cube([24.02,2,0.5]);
								translate([-Gimbal_Hand_Width/(2*Scale_Factor)-2,0,0])
									cube([2,Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius+0.01,0.5]);
								translate([Gimbal_Hand_Width/(2*Scale_Factor),0,0])
									cube([2,Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius+0.01,0.5]);
								difference()
									{
									intersection()
										{
										translate([12, Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius, 0])
											cylinder(h=0.5, r=Hand_Outside_Radius);
										translate([12, Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius, 0])
											cube([Hand_Outside_Radius, Hand_Outside_Radius, 0.5]);
										}
									translate([12, Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius, -1])
										cylinder(h=100, r=Hand_Outside_Radius-2);	
									}
								difference()
									{
									intersection()
										{
										translate([-12, Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius, 0])
											cylinder(h=0.5, r=Hand_Outside_Radius);
										translate([-12-Hand_Outside_Radius, Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius, 0])
											cube([Hand_Outside_Radius, Hand_Outside_Radius, 0.5]);
										}
									translate([-12, Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius, -1])
										cylinder(h=100, r=Hand_Outside_Radius-2);	
									}
								}
					
							}
							
//Produce the inner shell to remove from the outer to get the final gimbal shape.
						hull()
							{
					
//Produce an arc for the wrist side portion of the gimbal.						
							union()
								{
								translate([-12.01,Gimbal_Height/Scale_Factor+3-2,Gimbal_Thickness-0.5])
									cube([24.02,2,0.6]);
								translate([-Wrist_Width/(2*Scale_Factor),-0.1,Gimbal_Thickness-0.5])
									cube([2,Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius+0.11,0.6]);
								translate([Wrist_Width/(2*Scale_Factor)-2,-0.1,Gimbal_Thickness-0.5])
									cube([2,Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius+0.11,0.6]);
								difference()
									{
									intersection()
										{
										translate([12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, Gimbal_Thickness-0.5])
											cylinder(h=0.6, r=Wrist_Outside_Radius-2);
										translate([12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, Gimbal_Thickness-0.5])
											cube([Wrist_Outside_Radius-2, Wrist_Outside_Radius-2, 0.6]);
										}
									translate([12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, -1])
										cylinder(h=100, r=Wrist_Outside_Radius-4);	
									}
								difference()
									{
									intersection()
										{
										translate([-12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, Gimbal_Thickness-0.5])
											cylinder(h=0.6, r=Wrist_Outside_Radius-2);
										translate([-12-Wrist_Outside_Radius+2, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, Gimbal_Thickness-0.5])
											cube([Wrist_Outside_Radius-2, Wrist_Outside_Radius-2, 0.6]);
										}
									translate([-12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, -1])
										cylinder(h=100, r=Wrist_Outside_Radius-4);	
									}
								}

//Produce an arc for the hand side portion of the gimbal.						
							union()
								{
								translate([-12.01,Gimbal_Height/Scale_Factor+3-2,-0.1])
									cube([24.02,2,0.5]);
								translate([-Gimbal_Hand_Width/(2*Scale_Factor),-0.1,-0.1])
									cube([2,Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius+0.11,0.6]);
								translate([Gimbal_Hand_Width/(2*Scale_Factor)-2,-0.1,-0.1])
									cube([2,Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius+0.11,0.6]);
								difference()
									{
									intersection()
										{
										translate([12, Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius, -0.1])
											cylinder(h=0.6, r=Hand_Outside_Radius-2);
										translate([12, Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius, -0.1])
											cube([Hand_Outside_Radius-2, Hand_Outside_Radius-2, 0.6]);
										}
									translate([12, Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius, -1])
										cylinder(h=100, r=Hand_Outside_Radius-4);	
									}
								difference()
									{
									intersection()
										{
										translate([-12, Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius, -0.1])
											cylinder(h=0.6, r=Hand_Outside_Radius-2);
										translate([-12-Hand_Outside_Radius+2, Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius, -0.1])
											cube([Hand_Outside_Radius-2, Hand_Outside_Radius-2, 0.6]);
										}
									translate([-12, Gimbal_Height/Scale_Factor+5-Hand_Outside_Radius, -1])
										cylinder(h=100, r=Hand_Outside_Radius-4);	
									}
								}
					
							}

						}
							
//Pivot points for the standard wrist flexion and extension.							
					translate([-Wrist_Width/(2*Scale_Factor)-2.8, 0, Gimbal_Thickness/2+10])
						rotate(a=[0, 90, 0])
						rotate(a=[0, 0, 90])
							cylinder(h=2.8, r=5.7, $fn=32);

					translate([Wrist_Width/(2*Scale_Factor)+0, 0, Gimbal_Thickness/2+10])
						rotate(a=[0, 90, 0])
						rotate(a=[0, 0, 90])
							cylinder(h=2.8, r=5.7, $fn=32);

//Add block for the cable runs and to close off the gimbal screw
					translate([-Gimbal_String_Block_Width/(2*Scale_Factor), Gimbal_Height/Scale_Factor+3+2-1.5, 0])
						cube([Gimbal_String_Block_Width/Scale_Factor, 6.5, Gimbal_Thickness]);

//Add a little wing to hold the pivot better after carving away the underside.
					difference()
						{
						intersection()
							{
							union()
								{
								translate([12, 0, Gimbal_Thickness-0.01])
									cube([Wrist_Outside_Radius, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius+0.01, 5.0]);
								intersection()
									{
									translate([12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, Gimbal_Thickness-0.01])
										cylinder(h=5.0, r=Wrist_Outside_Radius);
									translate([12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, Gimbal_Thickness-0.01])
										cube([Wrist_Outside_Radius, Wrist_Outside_Radius, 5.0]);
									}
								}
							translate([0, 0, Gimbal_Thickness/2+10-5.7-Gimbal_Height/Scale_Factor])
								rotate(a=[0, 90, 0])
									cylinder(h=100, r=Gimbal_Height/Scale_Factor+8);
							}
						translate([12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, -1])
							cylinder(h=100, r=Wrist_Outside_Radius-2);
						translate([12-1, -1, 0])
							cube([Wrist_Outside_Radius-1, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius+1, 100]);
						}

					difference()
						{
						intersection()
							{
							union()
								{
								translate([-12-Wrist_Outside_Radius, 0, Gimbal_Thickness-0.01])
									cube([Wrist_Outside_Radius, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius+0.01, 5.0]);
								intersection()
									{
									translate([-12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, Gimbal_Thickness-0.01])
										cylinder(h=5.0, r=Wrist_Outside_Radius);
									translate([-12-Wrist_Outside_Radius, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, Gimbal_Thickness-0.01])
										cube([Wrist_Outside_Radius, Wrist_Outside_Radius, 5.0]);
									}
								}
							translate([-100, 0, Gimbal_Thickness/2+10-5.7-Gimbal_Height/Scale_Factor])
								rotate(a=[0, 90, 0])
									cylinder(h=100, r=Gimbal_Height/Scale_Factor+8);
							}
						translate([-12, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius, -1])
							cylinder(h=100, r=Wrist_Outside_Radius-2);
						translate([-12-Wrist_Outside_Radius+2, -1, 0])
							cube([Wrist_Outside_Radius-1, Gimbal_Height/Scale_Factor+5-Wrist_Outside_Radius+1, 100]);	
						}
				
					}
							
//Round off the edges of the integrated cable guide.
				translate([-Gimbal_String_Block_Width/(2*Scale_Factor)-0.01, Gimbal_Height/Scale_Factor+3+2+5+0.01, 0])
					rotate(a=[0, 0, -90])
						fillet(h=100, r=5.5);
				translate([Gimbal_String_Block_Width/(2*Scale_Factor)+0.01, Gimbal_Height/Scale_Factor+3+2+5+0.01, 0])
					rotate(a=[0, 0, 180])
						fillet(h=100, r=5.5);
	
//Cut away a bit of the corners to make more room for the thumb.
				translate([-50, -0.1, Gimbal_Thickness/2+10-5.7-1.5])
					rotate(a=[180+30, 0, 0])
						cube([100, 40, 40]);
				translate([0, 0, Gimbal_Thickness/2+10-5.7-Gimbal_Height/Scale_Factor])
					rotate(a=[0, 90, 0])
						cylinder(h=100, r=Gimbal_Height/Scale_Factor-0.01);

//Flatten the inside of the wrist pivot surface in case other curves have
//flowed onto it and made it non-flat.
				translate([Wrist_Width/(2*Scale_Factor)-2.79, 0, Gimbal_Thickness/2+10])
					rotate(a=[0, 90, 0])
					rotate(a=[0, 0, 90])
						cylinder(h=2.8, r=5.8, $fn=32);
				translate([-Wrist_Width/(2*Scale_Factor)-0.01, 0, Gimbal_Thickness/2+10])
					rotate(a=[0, 90, 0])
					rotate(a=[0, 0, 90])
						cylinder(h=2.8, r=5.8, $fn=32);

//Cut off a small portion between this part and the hand to increase gimbal angle
				translate([-100, -100, -19])
					cube([200, 200, 20]);
				
				}
			}

//Put in the holes that never change size

//Hole for the gimbal with inset for the nylock nut and fender washer
		translate([0, 100, Gimbal_Thickness*Scale_Factor/2])
			rotate(a=[90, 0, 0])
				cylinder(h=200, r=Pivot_Screw_Size/2);
		translate([0, Gimbal_Height+(3+2+0.1)*Scale_Factor, Gimbal_Thickness*Scale_Factor/2])
			rotate(a=[-90, 0, 0])
				cylinder(h=20, r=5.0);
				
//Screw holes to mount the wrist piece
		translate([-100, 0, Gimbal_Thickness*Scale_Factor/2+10*Scale_Factor])
			rotate(a=[0, 90, 0])
				cylinder(h=200, r=Pivot_Screw_Size/2);

//Holes for the drive strings.
		rotate(a=[-4, 0, 0])					
			translate([-Gimbal_String_Block_Width/2+Gimbal_String_Spacing+String_Hole_Diameter, Gimbal_Height+(3+2+1.5)*Scale_Factor, 0]) 
				polyhole(h=200, d=String_Hole_Diameter);
		rotate(a=[-4, 0, 0])	
			translate([-5-String_Hole_Diameter/2-1.0, Gimbal_Height+(3+2+1.5)*Scale_Factor, 0]) 
				polyhole(h=200, d=String_Hole_Diameter);
		rotate(a=[-4, 0, 0])	
			translate([Gimbal_String_Block_Width/2-Gimbal_String_Spacing-String_Hole_Diameter, Gimbal_Height+(3+2+1.5)*Scale_Factor, 0]) 
				polyhole(h=200, d=String_Hole_Diameter);
		rotate(a=[-4, 0, 0])	
			translate([5+String_Hole_Diameter/2+1.0, Gimbal_Height+(3+2+1.5)*Scale_Factor, 0]) 
				polyhole(h=200, d=String_Hole_Diameter);			
		}

	}
	
	
	
module PinkySideMount()
	{
//Remove static sized portions 
	difference()
		{

//Scale everything that is not static
		scale([Scale_Factor, Scale_Factor, Scale_Factor])
			{

			difference()
				{

//Build the main block out of separate shapes
				union()
					{
					translate([0, -Mount_Length/Scale_Factor, 0])
						cube([2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7, Mount_Length/Scale_Factor, 4.4]);
					translate([0, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7), 0])
						cube([2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7, 4.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7, 6.0]);
					translate([Knuckle_Base_Radius+MCPJ_Size_Increase+1.7, 0, 0])
						cylinder(h=6.0, r=Knuckle_Base_Radius+MCPJ_Size_Increase+1.7, $fn=32);
					}

//Cut out to hold the knuckle block
				difference()
					{
					translate([Knuckle_Base_Radius+MCPJ_Size_Increase+1.7, 0, 4.41])
						cylinder(h=6.8, r=Knuckle_Base_Radius+MCPJ_Size_Increase+0.25, $fn=32);
					translate([-1.45, -(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase+0.25), 4.41-1])
						cube([2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7, -1.1+Knuckle_Base_Radius+MCPJ_Size_Increase+0.25, 6.8+2]);
					}
				translate([-1.45, -(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+0.25), 4.41])
					cube([2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7, -1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+0.25, 6.8]);
	
//Round the corners
				translate([-0.01, -Mount_Length/Scale_Factor-0.01, -10])
					fillet(r=2, h=40);
				translate([2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7+0.01, -Mount_Length/Scale_Factor-0.01, -10])
					rotate(a=[0, 0, 90])
						fillet(r=2, h=40);
				}
			}

//Put in the holes that never change size

//Screw hole to hold the fingers on
		translate([(Knuckle_Base_Radius+MCPJ_Size_Increase+1.7)*Scale_Factor, 0, -10])
			polyhole(d=MCPJ_Hole_Size, h=120);

//Screw holes to mount the wrist piece
		if (!Use_Mount_Nut_Traps)
			{
			for (i=[Mount_Length-19*Scale_Factor : 7*Scale_Factor : Mount_Length-5*Scale_Factor])
				{
				translate([(Knuckle_Base_Radius+MCPJ_Size_Increase+1.7)*Scale_Factor, -i, -10])
					polyhole(d=Mount_Screw_Size, h=120);
				}
			}
		else
			{
			for (i=[Mount_Length-13*Scale_Factor : 8*Scale_Factor : Mount_Length-5*Scale_Factor])
				{
				translate([(Knuckle_Base_Radius+MCPJ_Size_Increase+1.7)*Scale_Factor, -i, -10+Mount_Nut_Thickness])
					cylinder(h=10, r=Mount_Nut_Radius, $fn=6);
				translate([(Knuckle_Base_Radius+MCPJ_Size_Increase+1.7)*Scale_Factor, -i, -5+10+Mount_Nut_Thickness+Layer_Height])
					polyhole(d=Mount_Screw_Size, h=10);
				}
			}
		}

	}

	
	

module ThumbSideKnuckle()
	{
	mirror([1, 0, 0])
		translate([0, 0, 3.4*Scale_Factor])
			rotate(a=[0, -90, 0])
				{

//Remove static sized portions 
				difference()
					{

//Scale everything that is not static
					scale([Scale_Factor, Scale_Factor, Scale_Factor])
						{
	
						difference()
							{

//Build the main block out of separate shapes
							union()
								{
								translate([-3.4, -1.4*(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4)*sin(15)-(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4)+3.1/Scale_Factor, 1.4*(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4)*cos(15)])
									rotate(a=[-75, 0, 0])
										cube([6.8, 1.4*(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4), 10]);
								translate([-3.4, -(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4)+3.1/Scale_Factor, 0])
									cube([6.8, (-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7)+2.4, 2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7]);
								translate([-3.4, 3.1/Scale_Factor, Knuckle_Base_Radius+MCPJ_Size_Increase+1.7])
									rotate(a=[0, 90, 0])
										cylinder(h=6.8, r=Knuckle_Base_Radius+MCPJ_Size_Increase+1.7, $fn=32);
								}
						
//Cut out to hold the knuckle block
							difference()
								{
								translate([1.8, 3.1/Scale_Factor, Knuckle_Base_Radius+MCPJ_Size_Increase+1.7])
									rotate(a=[0, 90, 0])
										cylinder(h=6.8, r=Knuckle_Base_Radius+MCPJ_Size_Increase+0.25, $fn=32);
								translate([1.8-1, -(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+0.25), 1.45-1])
									cube([6.8+2, -1.1+Knuckle_Base_Radius+MCPJ_Size_Increase+0.25, 2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2.8+2]);
								}
							translate([1.8, -(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+0.25)+3.1/Scale_Factor, 1.45])
								cube([6.8, -1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+0.25, 2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2.8]);

								
//Trim off the excess for where the turning portion will connect
							translate([-4.4, -20.6+3.1/Scale_Factor, 2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7])
								cube([8.8, 20.6, 2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7]);

//Round the inside portion
							translate([-3.4, -1.5*(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4)*sin(15)-(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4)+3.1/Scale_Factor, 1.5*(4.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7)*cos(15)])							
								rotate(a=[-75, 0, 0])
									translate([6.8+0.01, 0, -0.01])
										rotate(a=[0, -90, 0])
										rotate(a=[90, 0, 0])
											fillet_bez(r=3.5, h=40);

//Round the bottom and top corners
							translate([-3.4, -(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4)+3.1/Scale_Factor-0.01, -0.01])
								rotate(a=[90, 0, 0])
								rotate(a=[0, 90, 0])
									fillet_bez(r=9.5, h=40, a=105);
							translate([-3.4, -(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4)+3.1/Scale_Factor-(2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7)*tan(15)-0.01, (2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7)+0.01])
								rotate(a=[15, 0, 0])
								rotate(a=[0, 90, 0])
									fillet_bez(r=5, h=40, a=75);
							}
						}

//Put in the holes that never change size

//Screw hole to hold the fingers on
					translate([0, 3.1, (Knuckle_Base_Radius+MCPJ_Size_Increase+1.7)*Scale_Factor])
						rotate(a=[0, 90, 0])
							polyhole(d=MCPJ_Hole_Size, h=120);

//Screw hole to connect arm to knuckle
					translate([0, -(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4-3.4)*Scale_Factor, -1])
						cylinder(h=36, r=M3/2, $fn=12);

//Nut trap to lock arm to knuckle
					hull()
						{
						translate([0, -(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4-3.4)*Scale_Factor, (2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7-4.4)*Scale_Factor])
							cylinder(h=1.7+0.6, r=(6.1+0.7)/2, $fn=6);
						translate([-10, -(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4-3.4)*Scale_Factor, (2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7-4.4)*Scale_Factor])
							cylinder(h=1.7+0.6, r=(6.1+0.7)/2, $fn=6);
						}

					}
				}
	}




module ThumbSideArm()
	{
	extra=((Wrist_Distance-27-23*Scale_Factor)-floor((Wrist_Distance-27-23*Scale_Factor)/(8*Scale_Factor))*(8*Scale_Factor))/2;
	mirror([1, 0, 0])
		translate([0, 0, 3.4*Scale_Factor])
			rotate(a=[0, -90, 0])
				{

//Remove static sized portions 
				difference()
					{

//Scale everything that is not static
					scale([Scale_Factor, Scale_Factor, Scale_Factor])
						{
	
						difference()
							{

//Build the main block out of separate shapes
							union()
								{
								hull()
									{
									translate([-3.4, -(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4)-(2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7)*tan(15)+3.1/Scale_Factor, (2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7)+2+15])
										rotate(a=[-90, 0, 0])
											cube([6.8, 2, 12]);
									translate([-3.4, -26.1+2+5+3.1/Scale_Factor, (Knuckle_Base_Radius+MCPJ_Size_Increase+1.7)+Cuff_Height/Scale_Factor+3+15])
										cube([9, 2, 2]);
									}

								if (!Use_Mount_Nut_Traps)
									{
									translate([-3.4, (-Mount_Length+3.1)/Scale_Factor, (Knuckle_Base_Radius+MCPJ_Size_Increase+1.7)+Cuff_Height/Scale_Factor+3+15])
										cube([9, -24.1+5+3.1/Scale_Factor-(-Mount_Length+3.1)/Scale_Factor+2, 2]);
									}
									
								if (Use_Mount_Nut_Traps)
									{
									hull()
										{
										translate([-3.4, -26.1+2+5+3.1/Scale_Factor, (Knuckle_Base_Radius+MCPJ_Size_Increase+1.7)+Cuff_Height/Scale_Factor+3+15])
											cube([9, 2, 2]);
										translate([-3.4, (-Mount_Length+3.1)/Scale_Factor, (Knuckle_Base_Radius+MCPJ_Size_Increase+1.7)+Cuff_Height/Scale_Factor+3+15])
											cube([9, 18/Scale_Factor, 3.5]);
										}
									}	
								}	

//Trim off everything below the join plane
							translate([-10, -Wrist_Distance-10, 1.5+15])
								cube([20, 60, 17]);	


									translate([-3.4+6.8-1.2, -30, (2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7)-1.2+15])
								cube([4, 60, 2]);

//Round the hinge corner that could poke the user's wrist
							translate([5.6-2.8, (-Wrist_Distance+3.1+3.0)/Scale_Factor+0.5+(Scale_Factor-1)*2, 30])
								rotate(a=[0, 0, 90-8-(Scale_Factor-1)*7])
									fillet_bez(r=7.5, h=30, a=98+(Scale_Factor-1)*7);
							}
						}

//Put in the holes that never change size

//Holes for screw through to the knuckle block
					translate([0, -(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4-3.4)*Scale_Factor, 15*Scale_Factor])
						cylinder(h=30, r=M3/2, $fn=12);
					translate([0, -(-1.0+Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+2.4-3.4)*Scale_Factor, ((2*Knuckle_Base_Radius+2*MCPJ_Size_Increase+2*1.7)+3.2+15)*Scale_Factor])
						cylinder(h=30, r=(5.4+0.4)/2, $fn=12);

//Screw holes to mount the wrist piece
					translate([1.1, (-Mount_Length+3.1)+6, (6.4+15)*Scale_Factor])
						cylinder(h=120, r=Mount_Screw_Size/2);
					translate([1.1, (-Mount_Length+3.1)+5+9, (6.4+15)*Scale_Factor])
						cylinder(h=120, r=Mount_Screw_Size/2);
				
				if (Use_Mount_Nut_Traps)
					{
					translate([1.1, (-Mount_Length+3.1)+6, (Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+3+3.5+15)*Scale_Factor+Cuff_Height-Mount_Nut_Thickness+0.2])
						cylinder(h=10, r=Mount_Nut_Radius-0.1, $fn=6);
					translate([1.1, (-Mount_Length+3.1)+5+9, (Knuckle_Base_Radius+MCPJ_Size_Increase+1.7+3+3.5+15)*Scale_Factor+Cuff_Height-Mount_Nut_Thickness+0.2])
						cylinder(h=10, r=Mount_Nut_Radius-0.1, $fn=6);
					}
				}
			}
	}


	