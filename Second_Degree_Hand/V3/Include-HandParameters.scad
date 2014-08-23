/*
	The following are parameters that are used by many of the hand scripts.
	They are all put together here, and then simply included as a whole into
	the other scripts.  This was done to prevent errors from changing a
	value for one part, but failing to change it for another.  Now the key
	values only need to be edited in one place.
	
	There are still often parameters in each of the other scripts.  Those
	ones, however, are specific to that individual part.  The ones here are
	more global in scope.
*/

include <Include-MetricSizes.scad>;



//MEASURED PARAMETERS

//Knuckle_Width is the measured distance on the full hand across the four
//metacarpalphalangeal joints from outside to outside.  This value is used
//to calculate the Scale_Factor.  If Scale_Factor is being entered explicitly
//then this measure is not used.
Knuckle_Width=79.375;

//Set Wrist_Distance to the desired distance between the knuckle hinge point
//and the wrist hinge point.  This is a measured value that is not scaled.
Wrist_Distance=112;

//The following are the measured lengths of the proximal phalanges of each finger.
//This is best measured by curling the finger and then measuring from the back of
//the hand across the proximal phalanges to the front of the intermediate.  The
//measure includes the knuckles on both sides.
Index_Proximal=52*1.3;
Middle_Proximal=57*1.3;
Ring_Proximal=51*1.3;
Pinky_Proximal=42*1.3;

//The following are the measured lengths of the intermediate phalanges of each finger.
//This is best measured by curling the finger, and then measuring from the outside of
//the proximal to the outside of the distal.  In other words, the measure includes the
//knuckles on both sides.
Index_Intermediate=29*1.3;
Middle_Intermediate=34*1.3;
Ring_Intermediate=32*1.3;
Pinky_Intermediate=25*1.3;

//The following distal measurements are not currently used.  The script currently uses
//the same size distal on every finger.  In the future, I might change the script to
//allow this to be customized.  I have included the measures here as a place holder.
//They are the length of the distal from the back of the intermediate to the tip.
Index_Distal=22*1.3;
Middle_Distal=24*1.3;
Ring_Distal=24*1.3;
Pinky_Distal=22*1.3;

//Pivot_Width is the measure of the width for the actual wrist hinge.
//This is generally more than the wrist width.  A normal size would
//be around 5mm more than the wrist width to allow room for screws to
//be present without rubbing the user's wrist.
Pivot_Width=51+2+6;

//Wrist_Width is the measure across the wrist at the hinge point.
Wrist_Width=51+2+6-5;

//Wrist_Thickness is the measured thickness from the palm side to the
//back of the hand at the hinge point of the wrist.  This value is used
//to calculate the distance between the pivot points and the underside
//of the gimble cuff which sits on top of the hand cuff.
Wrist_Thickness=36+2+3-6;

//Arm_Width is the measure across the forearm at the point where the gauntlet
//will end.  Unlike with the Wrist_Width, there is no need to increase this
//value unless fitting shows it to be needed.  This value is used by the
//gauntlet, but that part already adds 5.6mm to fit on the outside of the
//gimble wrist pivots.
Arm_Width=64+4+2;

//Arm_Thickness is the measured thickness of the arm at the same point as
//the Arm_Width measure.
Arm_Thickness=76+4;

//Gauntlet_Length is the distance from the pivot point of the wrist to the
//end of the gauntlet.  The end of the gauntlet should be at the same point
//that the Arm_Width measure was taken.
Gauntlet_Length=228*.75;// 127;



//HAND CONFIGURATION PARAMETERS

//Left_Hand determines which hand is being made.  If a left hand is desired, set
//this value to true.  If a right hand is desired, set this to false.
Left_Hand=true;

//Set Scale_Factor to match the scaling of the other prosthetic hand parts.
//This value can either be entered directly or can be calculated from the value
//measured for the Knuckle_Width.  The value used is printed to the OpenSCAD
//window in case it is needed for manual scaling of other stl parts.
Scale_Factor=1.3;
//Scale_Factor=round(10*(Knuckle_Width+6)/59.2)/10;
echo ("Scale Factor is", Scale_Factor);

//Mount_Length is the length from the pivot of the knuckle joint back to the wrist
//side screws.  Although it can be set manually, it is usually a fraction of the
//Wrist_Distance and is just calculated dynamically.
Mount_Length=0.64*Wrist_Distance;

//Cuff_Height controls the cuff on the hand portion.  It is the measure from
//the pivot point of the MCP knuckle joint to the underside of the cuff over
//the back of the hand.  This should allow for some padding and velcro.
//Although this is a configurable value, it probably should be left alone unless
//there are specific reasons to change it.
Cuff_Height=10.5*Scale_Factor;

//Gimbal_Thickness is how wide the gimbal is on the back of the hand.  This
//value should generally be left alone.  It could be tweaked, however, if
//special circumstances require it.  If the value is made too large, then
//the gimbal will limit ulnar and radial flexion.  If the value is made too
//small, then the gimbal will wobble and will be unstable for standard wrist
//flexion and extension.
Gimbal_Thickness=14;

//Tab_Width is the size of the tabs on some finger that insert into slots
//either in other finger portions or int the knuckle block.  The size of the
//tabs or slots might be adjusted in each part.  For example, a little is
//added to this value to make the slots in the knuckle block a little loose
//so that the fingers move properly.
Tab_Width=4.4;

//In general, there is a standard separation between the slots in the knuckle block
//that scales with the hand.  Sometimes it is desirable to make the separation a
//little greater or lesser for a wider or narrower hand.  Knuckle_Slot_Adjustment
//allows such a change.
Knuckle_Slot_Adjustment=-1.0;

//Use_Bungee_Tie_Rods determines whether there should be a tieoff bar for the bungee, or the
//standard hole through the back of the knuckle block for both bungee and string
Use_Bungee_Tie_Rods=true;

//Bungee_Tie_Rod_Size is the size of the small tie-off rod for securing the bungee
//to the knuckle block.  If Use_Bungee_Tie_Rods is false, this value will be ignored.
//The platform the rod sits on is 2.5mm, so this should be less than or equal 2.5.
//It will be scaled with the Scale_Factor, so will generally be larger.
Bungee_Tie_Rod_Size=2.4;

//Use_Finger_Bungee_Tieoff determines whether there should be a tieoff bar in the back
//of the finger for the bungee, or the standard hole through the fingernail.
Use_Finger_Bungee_Tieoff=true;

//Knuckle_Base_Radius is the size of the bearing surface of the knuckle joints.
//This value IS scaled by the Scale_Factor.  This is currently set to the size of
//the original fingers.  It is exposed as a variable in case the bearing size is
//standardized to some other value at a future time.  Each knuckle in the scripts
//might include a size adjustment that is added to this Base value.
Knuckle_Base_Radius=4.8;

//PIJ_Size_Increase is a radius adjustment at the proximal interphalangeal joint
//to make the fingers increase as you move from tip to base.  This is not common
//in these sort of hands.  I find this increase to make a stronger and more real
//looking finger.  If this is other than 0, then the MCPJ should increase as well.
//This value will scale with the hand - just like the Base_Radius.
PIJ_Size_Increase=1.0;

//MCPJ_Size_Increase is a radius adjustment at the metacarpalphalangeal joint to
//make the fingers increase in size from tip to base.  This value will scale with
//the hand.
MCPJ_Size_Increase=2.0;

//Use_PIJ_Pins determines if the proximal interphalangeal joint in the fingers will
//use a simple snap pin to hold the joint together, or something else.  Something
//else would mean just a hole that would either be threaded for a screw, or maybe
//smooth to fit a Chicago screw.  If it is a pin, then there is a retaining portion
//and a head cutout - as well as the need to print the actual pin.
Use_PIJ_Pins=true;
PIJ_Pin_Head_Height=1.4;

//Use_PIJ_Bearings determines if the proximal finger portion that links with the
//intermediate should include a press-fit hole for a bearing.  If it should the
//PIJ_Bearing_Diameter is the size of the press-fit hole.  The thickness variable
//is used to include a slight retaining lip for the bearing if the finger tab is
//thick enough to allow it.  If bearings are not used, then the other parameters
//are ignored.
Use_PIJ_Bearings=false;
PIJ_Bearing_Diameter=6.2;
PIJ_Bearing_Thickness=2.5;
PIJ_Bearing_Pin_Size=2.95;
Inset_PIJ_Rivets=true;
PIJ_Rivet_Diameter=5.0;
PIJ_Rivet_Depth=1.0;

//Use_MCPJ_Bearings determines if the proximal finger portion that links with the
//knuckle block should include a press-fit hole for a bearing.  If it should the
//MCPJ_Bearing_Diameter is the size of the press-fit hole.  The thickness variable
//is used to include a slight retaining lip for the bearing if the finger tab is
//thick enough to allow it.  If bearings are not used, then the other parameters
//are ignored.
Use_MCPJ_Bearings=false;
MCPJ_Bearing_Diameter=6.2;
MCPJ_Bearing_Thickness=2.5;
MCPJ_Bearing_Pin_Size=3.00;
Inset_MCPJ_Rivets=true;
MCPJ_Rivet_Diameter=5.0;
MCPJ_Rivet_Depth=1.0;

//PIJ_Hole_Size_P is the size of the hole in the proximal phalanx for the PI joint.
//If this is a pin, then it is the size of the pin shaft, where larger sizes work
//better.  If the joint is a screw instead of a pin, then this should be the actual
//screw size so that the joint pivots on the screw.
//PIJ_Hole_Size_P=M4;
PIJ_Hole_Size_P=5.0;

//PIJ_Hole_Size_I is the size of the hole in the intermediate phalanx for the PI joint.
//If this is a pin, then it is the same size as the pin hole in the proximal.  If it
//is a screw that will thread in, then this would generally be a tappable hole size.
//If it is a Chicago screw, then it should be large enough to slip the body through.
//PIJ_Hole_Size_I=M4T;
PIJ_Hole_Size_I=5.0;

//MCPJ_Hole_Size is the long screw that makes the metacarpalphalangeal joint.  This
//hole will not be scaled so that it will fit more precisely.
MCPJ_Hole_Size=M4;

//Finger_Bungee_Hole_Size is the diameter of the hole for the bungee.  This needs to be much larger
//than the actual bungee cord. Two strands of bungee run through the hole and
//they might get twisted together.  As a general rule, make this as large as it
//can be without causing print problems.
Finger_Bungee_Hole_Size=3;

//Finger_String_Hole_Size is the diameter of the hole for the drive string.  This can probably be
//left alone, but should be tweaked if required for the drive string to fit.
Finger_String_Hole_Size=1.8;

//Mount_Screw_Size is for the few screws used to connect various plastic parts and to
//attach velcro straps to the hand.  This size will not be scaled to ensure proper fit.
Mount_Screw_Size=M3;

//Pivot_Screw_Size is the diameter of the screws used for both the wrist
//pivot points for standard flexion and extension and also for the gimbal
//pivot used for ulnar and radial flexion.
Pivot_Screw_Size=M3;

//If Use_Mount_Nut_Traps is true, then these parameters control the size of the trap.
//For the nut trap, measure nut width flat to flat and make that Mount_Nut_Width.
//Mount_Nut_Radius is then the conversion to make the needed hole.  Mount_Nut_Thickness
// is how thick the nut is.
Use_Mount_Nut_Traps=true;
Mount_Nut_Width=M3NutW;
Mount_Nut_Radius=(Mount_Nut_Width/cos(30)+0.4)/2;
Mount_Nut_Thickness=M3SNutT+0.2;

//If Use_Knuckle_Nut_Traps is true, then these parameters control the size of the trap.
//For the nut trap, measure nut width flat to flat and make that Knuckle_Nut_Width.
//Knuckle_Nut_Radius is then the conversion to make the hole.  Knuckle_Nut_Thickness
//is how thick the nut is.
Use_Knuckle_Nut_Traps=true;
Knuckle_Nut_Width=M4NutW;
Knuckle_Nut_Radius=(Knuckle_Nut_Width/cos(30)+0.4)/2;
Knuckle_Nut_Thickness=M4JNutT+0.2;

//String_Count is the number of drive strings.  This would normally be set to 5 - 
//1 for each finger and another for the thumb.  My efforts have been around a hand
//for a user with a functioning thumb.  For that reason, I default to 4.  a value
//of 5 might work for some parts, but not others.  For example, a gauntlet will work
//fine with 5 strings.  The hand parts will not work until a thumb portion is made
//and integrated into the scad files.
String_Count=4;

//String_Hole_Diameter is the size of the hole for the drive string.  This should
//be enough larger than the drive string that the string can easily slide through.
//It might need to be larger still because printed plastic tends to pull closed
//for small holes.  The default value should not be changed unless the string used
//requires it to be.
String_Hole_Diameter=2.5;

//Gimbal_String_Spacing is the gap between the drive string guide holes.  In general,
//this value should not need to be changed.  It might be useful, however, if the
//drive string is some unusual size.
Gimbal_String_Spacing=2.5;



//PRINTING PARAMETERS

//If Use_Support is true, then a block is added along the bottom edge of some
//parts.  This makes it easier to get a good print.  One then needs to 
//file off the block to return the part to round.  This is only used where a
//cylinder would otherwise be tangent to the print bed.
Use_Support=true;

//Layer_Height is the layer height of the print.  This is used in cases where an
//even layer split is needed to produce a bridge.  For example, if a nut trap is
//printed against the build plate, but then a screw hole sits above the trap.
//In that case, a single bridge layer will be printed over the nut trap to hold
//the walls of the screw hole above it.
Layer_Height=0.2;

