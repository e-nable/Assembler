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



//HAND PARAMETERS

//Set Scale_Factor to match the scaling of the other prosthetic hand parts.
//This is a hold over to the stl scaling used for the original Robohand parts.
//This value needs to be consistent for all parts for them to work together.
Scale_Factor=1.3;

//Set Wrist_Distance to the desired distance between the knuckle hinge point
//and the wrist hinge point.  This is a measured value that is not scaled.
Wrist_Distance=82;

//Mount_Length is the length from the pivot of the knuckle joint back to the wrist
//side screws.  Although it can be set manually, it is usually a fraction of the
//Wrist_Distance and is just calculated dynamically.
Mount_Length=(2/3)*Wrist_Distance;

//Knuckle_Base_Radius is the size of the bearing surface of the knuckle joints.
//This value IS scaled by the Scale_Factor.  This is currently set to the size of
//the original fingers.  It is exposed as a variable in case the bearing size is
//standardized to some other value at a future time.  Each knuckle in the scripts
//might include a size adjustment that is added to this Base value.
Knuckle_Base_Radius=4.8;

//Wrist_Width is the measure across the wrist at the hinge point.  This
//value should be large enough that the user's wrist will fit inside the
//measured distance with a little room for the heads of the button head
//screws that hold the pivots together.  A good first approximation is
//the measured width of the wrist plus five.  It is, however, a value
//that might need to be tuned for the comfort of the user.
Wrist_Width=60;

//Wrist_Thickness is the measured thickness from the palm side to the
//back of the hand at the hinge point of the wrist.  This value is used
//to calculate the distance between the pivot points and the underside
//of the gimble cuff which sits on top of the hand cuff.
Wrist_Thickness=37;

//Arm_Width is the measure across the forearm at the point where the gauntlet
//will end.  Unlike with the Wrist_Width, there is no need to increase this
//value unless fitting shows it to be needed.  This value is used by the
//gauntlet, but that part already adds 5.6mm to fit on the outside of the
//gimble wrist pivots.
Arm_Width=66;

//Arm_Thickness is the measured thickness of the arm at the same point as
//the Arm_Width measure.
Arm_Thickness=47;

//Gauntlet_Length is the distance from the pivot point of the wrist to the
//end of the gauntlet.  The end of the gauntlet should be at the same point
//that the Arm_Width measure was taken.
Gauntlet_Length=116;



//PRINTING PARAMETERS

//Layer_Height is the layer height of the print.  This is used in cases where an
//even layer split is needed to produce a bridge.  For example, if a nut trap is
//printed against the build plate, but then a screw hole sits above the trap.
//In that case, a single bridge layer will be printed over the nut trap to hold
//the walls of the screw hole above it.
Layer_Height=0.2;

