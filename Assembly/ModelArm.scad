// This creates a basic 'arm' based on measurements provided. This is useful for digital fittings of prosthetic hands.
// https://github.com/creuzerm/openscad-projects/blob/master/e-NABLE_Arm_Model.scad

// This is intended to be used by https://github.com/laird/e-NABLE

// http://enablingthefuture.org/ for more information

/*
// sample measurements for the Left side
Left1 = 66.47;
Left2 = 64.04;
Left3 = 46.95;
Left4 = 35.14;
Left5 = 35.97;
Left6 = 27.27;
Left7 = 31.80;
Left8 = 40.97;
Left9 = 31.06;
Left10 = 147.5;

// sample measurements for the Right side
Right1 = 66.47;
Right2 = 64.04;
Right3 = 46.95;
Right4 = 35.14;
Right5 = 35.97;
Right6 = 27.27;
Right7 = 31.80;
Right8 = 40.97;
Right9 = 31.06;
Right10 = 147.5;

// Which hand is the prosthetic for?
prostheticHand=0; // [0:Left, 1:Right]
*/

module ModelArm(measurements) {
	if(measurements[0][0] == 0)
	{	
		scale([1,1,.7]) arm(measurements[0][1], measurements[0][2], 
		measurements[0][3], measurements[0][4], 
		measurements[0][5], measurements[0][6], 
		measurements[0][7], measurements[0][8], 
		measurements[0][9], measurements[0][10] );
		}else if(measurements[0][0] == 1)
		{
		// # 6 & 9 are flipped on the right side to reflect inside/outside
		scale([1,1,.7]) arm(measurements[1][1], measurements[1][2], 
		measurements[1][3], measurements[1][4], 
		measurements[1][5], measurements[1][9], 
		measurements[1][7], measurements[1][8], 
		measurements[1][6], measurements[1][10] );
		arm(Right1, Right2, Right3, Right4, Right5, Right9, Right7, Right8, Right6, Right10 );
		}
	}



//arm
// Set up a set of spheres down the length of the arm and create 'hulls' between them to rough in the arm
module arm(Measurement1, Measurement2, Measurement3, Measurement4, Measurement5, Measurement6, Measurement7, Measurement8, Measurement9, Measurement10 )
	{
	hull()
		{
		translate([0,-Measurement10,0]) sphere(d = Measurement1);
		translate([0,-(Measurement10 * 4/5),0]) sphere(d = Measurement2);
		}
	hull()
		{
		translate([0,-(Measurement10 * 4/5),0]) sphere(d = Measurement2);
		translate([0,-(Measurement10 / 2),0]) sphere(d = Measurement3);
		}
	hull()
		{
		translate([0,-(Measurement10 / 2),0]) sphere(d = Measurement3);
		translate([0,-(Measurement10 * 1/5),0]) sphere(d = Measurement4);
		}
	hull()
		{
		translate([0,-(Measurement10 * 1/5),0]) sphere(d = Measurement4);
		//% sphere(d = Measurement5); // The next two lines gives us a better match to the flattening of the arm
		translate([Measurement5/2 - Measurement6/2,Measurement6/2,0]) sphere(d = Measurement6);
		translate([-(Measurement5/2 - Measurement9/2),Measurement9/2,0]) sphere(d = Measurement9);
		}

	//hand
	
	hull()
		{
		translate([Measurement8/2 - Measurement6/2,Measurement6/2,0]) sphere(d = Measurement6); // offset the outside edge by half the width of the hand, taking into account the size of this section
		translate([0,Measurement7/2,0]) sphere(d = Measurement7); // make the center of the hand
		}
	
	hull()
		{
		translate([0,Measurement7/2,0]) sphere(d = Measurement7); // make the center of the hand
		translate([-(Measurement8/2 - Measurement9/2),Measurement9/2,0]) sphere(d = Measurement9); // offset the outside edge by half the width of the hand, taking into account the size of this section
		}
	}