/*

Parametric Gauntlet
By David Orgeman

licensed under the Creative Commons - Attribution - Share Alike license

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

*/

include <Include-HelperModules.scad>;
include <Include-MetricSizes.scad>;
include <Include-HandParameters.scad>;


//Uncomment the below to show the gauntlet next to Frankie Flood's original
//translate([30, 50, 15])
//	rotate(a=[0, 0, -90])
//		import("Reinforced_Ganutlet.stl");


//Uncomment the below to show the gauntlet with the cuff gimble		
//translate([-30, 0, 5.7*Scale_Factor])
//	rotate(a=[0, 90, 0])
//	rotate(a=[0, 0, 90])
//		import("David-CuffGimble.stl");


//The following table is used to create the printed string tuner
Metric_Table=[ 	["M2", 0.8000, 1.1000, 2.3094], 
				["M25", 1.0250, 1.3750, 2.8868], 
				["M3", 1.2500, 1.6500, 3.1754], 
				["M4", 1.6500, 2.2000, 4.0415], 
				["M5", 2.1000, 2.7500, 4.6188]  ];



//PARAMETERS

//Gauntlet_Wall_Thickness is how thick the shell portion of the gauntlet will be.
//This value is, however, scaled, so that could make it more or less.
Gauntlet_Wall_Thickness=2.5;//default value 2.5

//Extra_Gap makes the inside of the gauntlet a little bit larger.  This is mostly
//to make the wrist pieces mesh up.  For example, if the hand uses the same wrist
//width, but will have the pivots inside the gauntlet parts, then the thickness of
//the pivots on the hand need to be added.  It also could facilitate some foam
//padding.
Extra_Gap=2.8;//default value 2.8

//Hinge_Bearing_Radius is the size of the circular pivot point of the wrist/hand
//joint.  The size is scaled with the Scale_Factor (just like with percent increase
//or equivalent stl files) so it might be larger.  This needs to be made compatible
//with whatever hand you are using.  That might take a bit of tweaking to get the
//values just right.
Hinge_Bearing_Radius=5.7;//default value 5.7

//Velcro_Width is the width of the strips of velcro used for the closure.  Velcro
//is generally sold in inch sizes, so this multiplies by 25.4 to convert that to
//mm - which is the unit used throughout this script.  If the velcro is too wide,
//there will not be room for two straps in the gauntlet.  It might be necessary to
//either get narrower strips, or to lengthen the gauntlet.
Velcro_Width=1.5*25.4;//default value 1.5*25.4

//Velcro_Slot_Thickness controls how big the slots are for the velcro to pass through.
//It might be possible to reduce this, but it probably isn't necessary to change it. 
//This value is scaled.
Velcro_Slot_Thickness=2.5;//default value 2.5

//Velcro_Slot_Count allows control over how many slots should be included.  This will
//generally be 2, but could be 1 on small gauntlets.
Velcro_Slot_Count=2;//default value 2

//Velcro_Offset 1 and 2 allow you to shift the position of the velcro slots.  Positive
//numbers move the slot towards the back of the gauntlet.  Negative numbers move the
//slot towards the front.  If there is only one slot, then only Offset1 is used.
Velcro_Offset1=0;//default value 0
Velcro_Offset2=0;//default value 0

//Rail_Thickness is how thick the strips are that hold the velcro and that attach
//to the hand.  This is a scaled value.
Rail_Thickness=3.5;//default value 3.5

//Rail_Extension is how far the rails stick out in front past the beginning of the
//shell portion.  There needs to be some extension to allow proper joint motion.
//This value is not scaled, and takes up part of the total Gauntlet_Length value.
Rail_Extension=8.0;//default value 8.0

//Include_Rail_Support puts some small blocks at the point where the curves of the
//rails meet the print bed. If used, the rails will need to be filed/sanded to round
//at those points.  I find, however, that most printers struggle printing that
//shape, and it comes out much better with the support blocks.
Include_Rail_Support=true;//default value true

//Pivot_Screw_Size is the hole in the hand end of the rail.  A screw is put through
//this hole to allow wrist flexion and extension.  This should match the size of the
//hole used in the hand parts.
Pivot_Screw_Size=M3;//default value M3

//The three Include Rib lines control whether or not three reinforcing rings will
//be included in the print.  You may include or omit any combination of the three.
//These were originally included to add a little additional stability to the shell.
//If they are present, then it might be possible to use a slightly thinner wall
//thickness.
Include_Front_Rib=false;//default value false
Include_Mid_Rib=true;//default value true
Include_Back_Rib=true;//default value true

//Rib_Width is how wide any reinforcing rings will be.  If the Include Rib lines
//above are all false, then this value does nothing.  If any of them are true, then
//this will control the sizing.  It is not possible in this version to set widths
//to be different for the various rings.
Rib_Width=3.5;//default value 3.5

//Include_Front_Cutout and Front_Cutout_Angle allow a bit of an arc to be removed
//from the front of the shell portion.  The amount of cutout can be adjusted by
//changing the angle.  Greater angles cut out more of the shell.  The reason to
//cut out the front of the shell is to allow better motion between the hand and
//the arm portions - it might be essential in many designs.  
Include_Front_Cutout=true;//default value true
Front_Cutout_Angle=60;//default value 60

//Include_Back_Cutout and Back_Cutout_Angle are similar to the front cutout above,
//except it does the same thing to the back of the shell.  There is little value
//in doing this.  Some have done it in the past to try to get a more open gauntlet
//or for aesthetic reasons.
Include_Back_Cutout=false;//default value false
Back_Cutout_Angle=60;//default value 60

//Include_Tuner determines if an integrated string tuner block will be included on
//the top of the gauntlet.  This generally should be true unless some other means
//of dealing with string termination is planned.
Include_Tuner=true;//default value true

//Tuner_Distance is the distance in mm from the wrist hinge to the start of the
//tuner block.  This value is not scaled.
Tuner_Distance=90.5;//default value 90.5

//Extra_Tuner_Height provides a way to raise the string termination higher off the
//gauntlet if desired.  There are not a lot of situations where this would be useful.
//The value should be left at 0 unless there is some specific problem that will be
//solved by elevating the tuners.
Extra_Tuner_Height=0.0;//default value 0.0

//Include_Guide adds a holder for the strings at the front edge of the shell.  Many
//designers do not include this, but I always do.  It helps constrain the strings
//to a well defined path and also helps set string elevation at the wrist, which
//can be a useful way to control how sharp the wrist needs to bend to close the
//fingers.
Include_Guide=true;//default value true

//Guide_Distance is the distance in mm from the wrist hinge to the front of the guide
//block.  This value is not scaled.
Guide_Distance=24;//default value 24

//Extra_String_Height, similar to the tuners, allows a way to raise the strings up a
//little.  Unlike with the tuners, this can be quite useful.  It can help make a
//better path between the hand and the arm portions, and can improve the leverage
//for closing the fingers.  I would, however, leave it at 0 unless there is some
//specific reason to increase it.
Extra_String_Height=0.0;//default value 0.0

//Guide_Thickness is how big to make the string guide.  I don't find a lot of value
//in making it very big.  It just needs to be big enough to not be easily broken.
Guide_Thickness=10;//default value 10

//String_Count is the number of string holes in the guide.  This will generally be
//5, but all of my efforts are on hands for people who have a usable thumb.  for
//that reason, my version is defaulted to 4 - but it can easily be changed.
String_Count=4;//default value 4

//String_Hole_Spacing is the gap between the drive string guide holes.  In general,
//this value should not need to be changed.  It might be useful, however, if the
//drive string is some unusual size.
String_Hole_Spacing=2.8;//default value 2.8

//String_Hole_Diameter is the size of the hole for the drive string.  This should
//be enough larger than the drive string that the string can easily slide through.
//It might need to be larger still because printed plastic tends to pull closed
//for small holes.  The default value should not be changed unless the string used
//requires it to be.
String_Hole_Diameter=2.5;//default value 2.5

//Print_Tuners determines whether or not the tuning rods that go inside the block
//should be printed.
Print_Tuners=true;//default value true

//Tuner_Size is the size of the tuner drive screws.  Larger screws will make the
//tuners much stronger, are easier to print, and are more available.  For those
//reasons, I always try to use M3.  The tradeoff, though, is that the tuner block
//needs to be larger for larger screws.  With 5 tuner, especially on a child's
//hand, the M3 will likely be too large.
Tuner_Size="M3";//[ M2, M25, M3, M4, M5 ] default value "M3"

//Rod_Length is the functional length of the tuner rods.  The total length is this
//plus an extra length.  The two values exist for legacy reasons.  I would suggest
//leaving this value alone unless there is some specific need to change it.
Rod_Length=18.0;//default value 18.0

//Extra_Tuner_Length is some extra tuner rod to tie the string to.
Extra_Tuner_Length=5.0;//default value 5.0

//String_Radius is the radius of the hole in the rod to hold the string.  This is
//smaller than the size used for most of the strings, but there is limited room
//to put a hole in the tuners.
String_Radius=1.0;

//Tuner_Count is the number of tuner rods and tuner slots in the block.  For most
//this value should be 5.  I am exclusively making hands where I am only dealing
//with the four fingers (no thumb) so my default is 4.  Change as appropriate.
Tuner_Count=4;//[1, 2, 3, 4, 5] default value 4

//Tuner_Fit adds some extra gap in the tuner block slots to allow the rods to fit.
//This value might need to be tweaked if the rods are too tight or too loose in
//the slots.
Tuner_Fit=0.2;//default value 0.2



//CALCULATED VALUES

Metric_Index=search([Tuner_Size], Metric_Table)[0];
Tuner_Screw_Radius=Metric_Table[Metric_Index][1];
Block_Screw_Radius=Metric_Table[Metric_Index][2];
Rod_Radius=Metric_Table[Metric_Index][3];
Shell_Length=Gauntlet_Length-Rail_Extension;
AngleW=atan((Arm_Width/(2*Scale_Factor)-Wrist_Width/(2*Scale_Factor))/(Shell_Length/Scale_Factor));
AngleT=atan((Arm_Thickness/(2*Scale_Factor)-Wrist_Thickness/(2*Scale_Factor))/(Shell_Length/Scale_Factor));



//RENDER

//Remove static sized portions 
difference()
	{

//Scale everything that is not static
	scale([Scale_Factor, Scale_Factor, Scale_Factor])
		{

		union()
			{
			difference()
				{

//Build the main block out of separate shapes
				union()
					{
				
//Main curved part of the gauntlet		
					translate([0, 0, Hinge_Bearing_Radius+Velcro_Slot_Thickness/2-0.01])
						difference()
							{
							union()
								{
							
//Main body of the gauntlet							
								hull()
									{
									translate([Shell_Length/Scale_Factor-1, 0, 0]) 
										scale([1, Arm_Width/Scale_Factor+2*Extra_Gap+2*Gauntlet_Wall_Thickness, Arm_Thickness/Scale_Factor+2*Extra_Gap+2*Gauntlet_Wall_Thickness])
											rotate(a=[0, 90, 0])
												cylinder(h=1, r=0.5, $fn=64);
									scale([1, Wrist_Width/Scale_Factor++2*Extra_Gap+2*Gauntlet_Wall_Thickness, Wrist_Thickness/Scale_Factor+2*Extra_Gap+2*Gauntlet_Wall_Thickness])
										rotate(a=[0, 90, 0])
											cylinder(h=1, r=0.5, $fn=64);
									}

//Front raised rib to strengthen the gauntlet		
								if (Include_Front_Rib)
									{						
									hull()
										{
										scale([1, Wrist_Width/Scale_Factor++2*Extra_Gap+2*Rail_Thickness, Wrist_Thickness/Scale_Factor+2*Extra_Gap+2*Rail_Thickness])
											rotate(a=[0, 90, 0])
												cylinder(h=0.1, r=0.5, $fn=64);
										translate([Rib_Width, 0, 0])
											scale([1, Wrist_Width/Scale_Factor++2*Extra_Gap+2*Rail_Thickness+2*Rib_Width*tan(AngleW), Wrist_Thickness/Scale_Factor+2*Extra_Gap+2*Rail_Thickness+2*Rib_Width*tan(AngleT)])
												rotate(a=[0, 90, 0])
													cylinder(h=0.1, r=0.5, $fn=64);
										}
									}

//Middle raised rib to strengthen the gauntlet
								if (Include_Mid_Rib)
									{
									hull()
										{
										translate([Shell_Length/(2*Scale_Factor)-Rib_Width/2, 0, 0])
											scale([1, Wrist_Width/Scale_Factor++2*Extra_Gap+2*Rail_Thickness+2*(Shell_Length/(2*Scale_Factor)-Rib_Width/2)*tan(AngleW), Wrist_Thickness/Scale_Factor+2*Extra_Gap+2*Rail_Thickness+2*(Shell_Length/(2*Scale_Factor)-Rib_Width/2)*tan(AngleT)])
												rotate(a=[0, 90, 0])
													cylinder(h=0.1, r=0.5, $fn=64);
										translate([Shell_Length/(2*Scale_Factor)+Rib_Width/2, 0, 0])
											scale([1, Wrist_Width/Scale_Factor++2*Extra_Gap+2*Rail_Thickness+2*(Shell_Length/(2*Scale_Factor)+Rib_Width/2)*tan(AngleW), Wrist_Thickness/Scale_Factor+2*Extra_Gap+2*Rail_Thickness+2*(Shell_Length/(2*Scale_Factor)+Rib_Width/2)*tan(AngleT)])
												rotate(a=[0, 90, 0])
													cylinder(h=0.1, r=0.5, $fn=64);
										}
									}

//Rear raised rib to strengthen the gauntlet
								if (Include_Back_Rib)
									{
									hull()
										{
										translate([Shell_Length/Scale_Factor-Rib_Width, 0, 0])
											scale([1, Wrist_Width/Scale_Factor++2*Extra_Gap+2*Rail_Thickness+2*(Shell_Length/Scale_Factor-Rib_Width)*tan(AngleW), Wrist_Thickness/Scale_Factor+2*Extra_Gap+2*Rail_Thickness+2*(Shell_Length/Scale_Factor-Rib_Width)*tan(AngleT)])
												rotate(a=[0, 90, 0])
													cylinder(h=0.1, r=0.5, $fn=64);
										translate([Shell_Length/Scale_Factor, 0, 0])
											scale([1, Wrist_Width/Scale_Factor++2*Extra_Gap+2*Rail_Thickness+2*(Shell_Length/Scale_Factor)*tan(AngleW), Wrist_Thickness/Scale_Factor+2*Extra_Gap+2*Rail_Thickness+2*(Shell_Length/Scale_Factor)*tan(AngleT)])
												rotate(a=[0, 90, 0])
													cylinder(h=0.1, r=0.5, $fn=64);
										}								
									}					
								}

//Hollow out the gauntlet							
							hull()
								{
								translate([Shell_Length/Scale_Factor-1, 0, 0]) 
									scale([1.1, Arm_Width/Scale_Factor+2*Extra_Gap, Arm_Thickness/Scale_Factor+2*Extra_Gap])
										rotate(a=[0, 90, 0])
											cylinder(h=1, r=0.5, $fn=64);
								translate([-0.1, 0, 0])
									scale([1, Wrist_Width/Scale_Factor++2*Extra_Gap, Wrist_Thickness/Scale_Factor+2*Extra_Gap])
										rotate(a=[0, 90, 0])
											cylinder(h=1, r=0.5, $fn=64);
								}

//Front oval cut out to open the motion a bit
								if (Include_Front_Cutout)
									{
									rotate(a=[0, Front_Cutout_Angle, 0])
										translate([-60, 0, 0])
											scale([1, Wrist_Width/Scale_Factor++2*Extra_Gap+2*Gauntlet_Wall_Thickness, Wrist_Thickness/Scale_Factor+2*Extra_Gap+2*Gauntlet_Wall_Thickness])
												rotate(a=[0, 90, 0])
													cylinder(h=60, r=0.5, $fn=64);
									}

//Back oval cut out if desired for aesthetic reasons
								if (Include_Back_Cutout)
									{
									translate([(Gauntlet_Length-Rail_Extension)/Scale_Factor, 0, Hinge_Bearing_Radius])
										rotate(a=[0, -Back_Cutout_Angle, 0])
											translate([-30, 0, 0])
												scale([1, Arm_Width/Scale_Factor++2*Extra_Gap+1.5*Gauntlet_Wall_Thickness, Arm_Thickness/Scale_Factor+2*Extra_Gap+1.5*Gauntlet_Wall_Thickness])
													rotate(a=[0, 90, 0])
														cylinder(h=90, r=0.5, $fn=64);
									}
								
//Cut off the bottom half of the oval to leave only the upper portion							
							translate([-50, -100, -200])
								cube([200, 200, 200]);
							
//Trim the sides to keep edges of oval from poking out through the rails
							translate([0, -Wrist_Width/(2*Scale_Factor)-Extra_Gap-Rail_Thickness+0.1, 0])
								rotate(a=[0, 0, -AngleW])				
									translate([-50, -200, -100])
										cube([200, 200, 200]);
							translate([0, Wrist_Width/(2*Scale_Factor)+Extra_Gap+Rail_Thickness-0.1, 0])
								rotate(a=[0, 0, AngleW])				
									translate([-50, 0, -100])
										cube([200, 200, 200]);
							}
				
//Rails that will hold the velcro and that attach on the outside of the wrist gimble						
					translate([0, Wrist_Width/(2*Scale_Factor)+Extra_Gap, 0])
						rotate(a=[0, 0, AngleW])				
							cube([Shell_Length/Scale_Factor, Rail_Thickness, 2*Hinge_Bearing_Radius]);
					translate([0, -Wrist_Width/(2*Scale_Factor)-Extra_Gap-Rail_Thickness, 0])
						rotate(a=[0, 0, -AngleW])				
							cube([Shell_Length/Scale_Factor, Rail_Thickness, 2*Hinge_Bearing_Radius]);
//Straight sections of rail to separate the gauntlet from the wrist pivot
					translate([-Rail_Extension/Scale_Factor, Wrist_Width/(2*Scale_Factor)+Extra_Gap, 0])
						cube([Rail_Extension/Scale_Factor+0.1, Rail_Thickness, 2*Hinge_Bearing_Radius]);
					translate([-Rail_Extension/Scale_Factor, -Wrist_Width/(2*Scale_Factor)-Extra_Gap-Rail_Thickness, 0])
						cube([Rail_Extension/Scale_Factor+0.1, Rail_Thickness, 2*Hinge_Bearing_Radius]);
//Bearing surface for wrist extension and flexion
					translate([-Rail_Extension/Scale_Factor, Wrist_Width/(2*Scale_Factor)+Extra_Gap, Hinge_Bearing_Radius])
						rotate(a=[-90, 0, 0])
							cylinder(h=Rail_Thickness, r=Hinge_Bearing_Radius);
					translate([-Rail_Extension/Scale_Factor, -Wrist_Width/(2*Scale_Factor)-Extra_Gap-Rail_Thickness, Hinge_Bearing_Radius])
						rotate(a=[-90, 0, 0])
							cylinder(h=Rail_Thickness, r=Hinge_Bearing_Radius);
					}

//Cut outs to hold the velcro straps
				if (Velcro_Slot_Count == 2)
					{
					rotate(a=[0, 0, AngleW])
						translate([Shell_Length/(2*Scale_Factor)+(Shell_Length/(2*Scale_Factor)-Velcro_Width/Scale_Factor-3)/2-1+Velcro_Offset2, 0, Hinge_Bearing_Radius-Velcro_Slot_Thickness/2])
							cube([Velcro_Width/Scale_Factor+3, 100, Velcro_Slot_Thickness]);
					rotate(a=[0, 0, AngleW])
						translate([Shell_Length/(2*Scale_Factor)+(Shell_Length/(2*Scale_Factor)-Velcro_Width/Scale_Factor-3)/2-1+Velcro_Offset2, 0, Hinge_Bearing_Radius-Velcro_Slot_Thickness/2-10.5])
							cube([Velcro_Width/Scale_Factor+3, Wrist_Width/(2*Scale_Factor)+Extra_Gap+1, Velcro_Slot_Thickness+10]);
					rotate(a=[0, 0, AngleW])
						translate([(Shell_Length/(2*Scale_Factor)-Velcro_Width/Scale_Factor-3)/2+1+Velcro_Offset1, 0, Hinge_Bearing_Radius-Velcro_Slot_Thickness/2])
							cube([Velcro_Width/Scale_Factor+3, 100, Velcro_Slot_Thickness]);
					rotate(a=[0, 0, AngleW])
						translate([(Shell_Length/(2*Scale_Factor)-Velcro_Width/Scale_Factor-3)/2+1+Velcro_Offset1, 0, Hinge_Bearing_Radius-Velcro_Slot_Thickness/2-10.5])
							cube([Velcro_Width/Scale_Factor+3, Wrist_Width/(2*Scale_Factor)+Extra_Gap+1, Velcro_Slot_Thickness+10]);
					rotate(a=[0, 0, -AngleW])
						translate([Shell_Length/(2*Scale_Factor)+(Shell_Length/(2*Scale_Factor)-Velcro_Width/Scale_Factor-3)/2-1+Velcro_Offset2, -100, Hinge_Bearing_Radius-Velcro_Slot_Thickness/2])
							cube([Velcro_Width/Scale_Factor+3, 100, Velcro_Slot_Thickness]);
					rotate(a=[0, 0, -AngleW])
						translate([Shell_Length/(2*Scale_Factor)+(Shell_Length/(2*Scale_Factor)-Velcro_Width/Scale_Factor-3)/2-1+Velcro_Offset2, -(Wrist_Width/(2*Scale_Factor)+Extra_Gap+1), Hinge_Bearing_Radius-Velcro_Slot_Thickness/2-10.5])
							cube([Velcro_Width/Scale_Factor+3, Wrist_Width/(2*Scale_Factor)+Extra_Gap+1, Velcro_Slot_Thickness+10]);
					rotate(a=[0, 0, -AngleW])
						translate([(Shell_Length/(2*Scale_Factor)-Velcro_Width/Scale_Factor-3)/2+1+Velcro_Offset1, -100, Hinge_Bearing_Radius-Velcro_Slot_Thickness/2])
							cube([Velcro_Width/Scale_Factor+3, 100, Velcro_Slot_Thickness]);
					rotate(a=[0, 0, -AngleW])
						translate([(Shell_Length/(2*Scale_Factor)-Velcro_Width/Scale_Factor-3)/2+1+Velcro_Offset1, -(Wrist_Width/(2*Scale_Factor)+Extra_Gap+1), Hinge_Bearing_Radius-Velcro_Slot_Thickness/2-10.5])
							cube([Velcro_Width/Scale_Factor+3, Wrist_Width/(2*Scale_Factor)+Extra_Gap+1, Velcro_Slot_Thickness+10]);
					}
				if (Velcro_Slot_Count == 1)
					{
					rotate(a=[0, 0, AngleW])
						translate([Shell_Length/(2*Scale_Factor)-(Velcro_Width/Scale_Factor+3)/2+Velcro_Offset1, 0, Hinge_Bearing_Radius-Velcro_Slot_Thickness/2])
							cube([Velcro_Width/Scale_Factor+3, 100, Velcro_Slot_Thickness]);
					rotate(a=[0, 0, AngleW])
						translate([Shell_Length/(2*Scale_Factor)-(Velcro_Width/Scale_Factor+3)/2+Velcro_Offset1, 0, Hinge_Bearing_Radius-Velcro_Slot_Thickness/2-10.5])
							cube([Velcro_Width/Scale_Factor+3, Wrist_Width/(2*Scale_Factor)+Extra_Gap+1, Velcro_Slot_Thickness+10]);
					rotate(a=[0, 0, -AngleW])
						translate([Shell_Length/(2*Scale_Factor)-(Velcro_Width/Scale_Factor+3)/2+Velcro_Offset1, -100, Hinge_Bearing_Radius-Velcro_Slot_Thickness/2])
							cube([Velcro_Width/Scale_Factor+3, 100, Velcro_Slot_Thickness]);
					rotate(a=[0, 0, -AngleW])
						translate([Shell_Length/(2*Scale_Factor)-(Velcro_Width/Scale_Factor+3)/2+Velcro_Offset1, -(Wrist_Width/(2*Scale_Factor)+Extra_Gap+1), Hinge_Bearing_Radius-Velcro_Slot_Thickness/2-10.5])
							cube([Velcro_Width/Scale_Factor+3, Wrist_Width/(2*Scale_Factor)+Extra_Gap+1, Velcro_Slot_Thickness+10]);
					}
				
//Clean up back end of gauntlet to account for parts that stick out after rotation
				translate([Shell_Length/Scale_Factor, -100, -100])
					cube([200, 200, 200]);

//Round the back end of the beams that otherwise might poke the arm				
				translate([Shell_Length/Scale_Factor+0.01, 0, -0.01])
					rotate(a=[0, -90, 0])
					rotate(a=[90, 0, 0])
						fillet(h=200, r=4);
			
				}
			if (Include_Rail_Support)
				{
				translate([-Rail_Extension/Scale_Factor-0.65*Hinge_Bearing_Radius, Wrist_Width/(2*Scale_Factor)+Extra_Gap+0.01, 0])
					cube([0.65*Hinge_Bearing_Radius, Rail_Thickness-0.02, Hinge_Bearing_Radius/2]);
				translate([-Rail_Extension/Scale_Factor-0.65*Hinge_Bearing_Radius, -Wrist_Width/(2*Scale_Factor)-Extra_Gap-Rail_Thickness-0.01, 0])
					cube([0.65*Hinge_Bearing_Radius, Rail_Thickness-0.02, Hinge_Bearing_Radius/2]);
				translate([Shell_Length/Scale_Factor-Hinge_Bearing_Radius, Arm_Width/(2*Scale_Factor)+Extra_Gap-0.1, 0])
					cube([0.75*Hinge_Bearing_Radius, Rail_Thickness-0.02, Hinge_Bearing_Radius/2]);
				translate([Shell_Length/Scale_Factor-Hinge_Bearing_Radius, -Arm_Width/(2*Scale_Factor)-Extra_Gap-Rail_Thickness+0.1, 0])
					cube([0.75*Hinge_Bearing_Radius, Rail_Thickness-0.02, Hinge_Bearing_Radius/2]);
				}
			}
		}

//Put in the holes that never change size

//Holes for the wrist pivot screws
	translate([-Rail_Extension, 10, Hinge_Bearing_Radius*Scale_Factor])
		rotate(a=[-90, 0, 0])
			cylinder(h=60, r=Pivot_Screw_Size/2);
	translate([-Rail_Extension, -70, Hinge_Bearing_Radius*Scale_Factor])
		rotate(a=[-90, 0, 0])
			cylinder(h=60, r=Pivot_Screw_Size/2);


	}

//Add the tuner block, if desired, in the configured position	
if (Include_Tuner)
	{
	translate([Tuner_Distance-Rail_Extension, 0, Wrist_Thickness/2+(Extra_Gap+Gauntlet_Wall_Thickness+Hinge_Bearing_Radius+Velcro_Slot_Thickness/2)*Scale_Factor+Tuner_Distance*tan(AngleT)-1])
		rotate(a=[0, -AngleT, 0])
			Tuner_Block();
	}

//Add the tuner block, if desired, in the configured position	
if (Include_Guide)
	{
	translate([Guide_Distance-Rail_Extension, 0, Wrist_Thickness/2+(Extra_Gap+Gauntlet_Wall_Thickness+Hinge_Bearing_Radius+Velcro_Slot_Thickness/2)*Scale_Factor+Guide_Distance*tan(AngleT)-1])
		rotate(a=[0, -AngleT, 0])
			Guide_Block();
	}

if (Print_Tuners)
	{
	if (Tuner_Count>0)
		{
		for(i=[1:Tuner_Count])
			{
			translate([-15-3*Rod_Radius*i, 0, 0])
				tuner();
			}
		}
	}
	
	
	

module Tuner_Block()
	{
	rotate(a=[0, 0, -90])
//	translate([0, -(Rod_Length+3), 0])
	difference()
		{
		translate([-2.1*Rod_Radius*(Tuner_Count+1)/2, 0, -6])
			cube([4.2*Rod_Radius*(Tuner_Count+1)/2, Rod_Length+3, 3.8*Rod_Radius+Extra_Tuner_Height+6]);
			
		translate([0, 0, -1])
			rotate(a=[-AngleT, 0, 0])
				translate([0, 0, -(Wrist_Thickness+2*Extra_Gap+2*Rail_Thickness+2*Tuner_Distance*tan(AngleT))/2])
					hull()
						{
						translate([0, 0, 0])
							scale([Wrist_Width+2*Extra_Gap+2*Rail_Thickness+2*Tuner_Distance*tan(AngleW), 1, Wrist_Thickness+2*Extra_Gap+2*Rail_Thickness+2*Tuner_Distance*tan(AngleT)])
								rotate(a=[90, 0, 0])
									cylinder(h=0.1, r=0.5, $fn=64);
						translate([0, Rod_Length+8, 0])
							scale([Wrist_Width+2*Extra_Gap+2*Rail_Thickness+2*(Tuner_Distance+Rod_Length+8)*tan(AngleW), 1, Wrist_Thickness+2*Extra_Gap+2*Rail_Thickness+2*(Tuner_Distance+Rod_Length+8)*tan(AngleT)])
								rotate(a=[90, 0, 0])
									cylinder(h=0.1, r=0.5, $fn=64);
						}	
									
		for(i=[1:Tuner_Count])
			{
			translate([-2.4*Rod_Radius*(Tuner_Count+1)/2 + 2.4*Rod_Radius*i, Rod_Length+0.5, 1.9*Rod_Radius+Extra_Tuner_Height])
				rotate(a=[0, 30, 0])
				rotate(a=[90, 0, 0])
					cylinder(h=Rod_Length+2, r=Rod_Radius+Tuner_Fit, $fn=6);
			}

		for(i=[1:Tuner_Count])
			{
			translate([-2.4*Rod_Radius*(Tuner_Count+1)/2 + 2.4*Rod_Radius*i, 0, 1.9*Rod_Radius+Extra_Tuner_Height])
				rotate(a=[90, 0, 0])
					polyhole(h=100, d=Block_Screw_Radius*2);
			}
		
		translate([-2.1*Rod_Radius*(Tuner_Count+1)/2-0.01, 0, 3.8*Rod_Radius+Extra_Tuner_Height+0.01])
			rotate(a=[-90, 0, 0])
				fillet(r=2.5*Rod_Radius, h=100);
		translate([2.1*Rod_Radius*(Tuner_Count+1)/2+0.01, 0, 3.8*Rod_Radius+Extra_Tuner_Height+0.01])
			rotate(a=[0, 90, 0])
			rotate(a=[-90, 0, 0])
				fillet(r=2.5*Rod_Radius, h=100);
		
		}	
	}	

module Guide_Block()
	{
	rotate(a=[0, 0, -90])
	difference()
		{
		translate([-(String_Count*String_Hole_Diameter+(String_Count+1)*String_Hole_Spacing)/2, 0, -6])
			cube([String_Count*String_Hole_Diameter+(String_Count+1)*String_Hole_Spacing, Guide_Thickness, 2.5*String_Hole_Spacing+String_Hole_Diameter+Extra_String_Height+6]);
			
		translate([0, 0, -1])
			rotate(a=[-AngleT, 0, 0])
				translate([0, 0, -(Wrist_Thickness+2*Extra_Gap+2*Rail_Thickness+2*Guide_Distance*tan(AngleT))/2])
					hull()
						{
						translate([0, 0, 0])
							scale([Wrist_Width+2*Extra_Gap+2*Rail_Thickness+2*Guide_Distance*tan(AngleW), 1, Wrist_Thickness+2*Extra_Gap+2*Rail_Thickness+2*Guide_Distance*tan(AngleT)])
								rotate(a=[90, 0, 0])
									cylinder(h=0.1, r=0.5, $fn=64);
						translate([0, Guide_Thickness+8, 0])
							scale([Wrist_Width+2*Extra_Gap+2*Rail_Thickness+2*(Guide_Distance+Guide_Thickness+8)*tan(AngleW), 1, Wrist_Thickness+2*Extra_Gap+2*Rail_Thickness+2*(Guide_Distance+Guide_Thickness+8)*tan(AngleT)])
								rotate(a=[90, 0, 0])
									cylinder(h=0.1, r=0.5, $fn=64);
						}	

		for(i=[1:String_Count])
			{
			translate([-(String_Count*String_Hole_Diameter+(String_Count+1)*String_Hole_Spacing)/2+i*String_Hole_Spacing+(2*i-1)*String_Hole_Diameter/2, 50, 1.5*String_Hole_Spacing+0.5*String_Hole_Diameter+Extra_String_Height])
				rotate(a=[90, 0, 0])
					cylinder(h=100, r=String_Hole_Diameter/2);
			}
		
		translate([-(String_Count*String_Hole_Diameter+(String_Count+1)*String_Hole_Spacing)/2-0.01, 0, 2.5*String_Hole_Spacing+String_Hole_Diameter+Extra_String_Height+0.01])
			rotate(a=[-90, 0, 0])
				fillet(r=2.5*String_Hole_Spacing, h=100);
		translate([(String_Count*String_Hole_Diameter+(String_Count+1)*String_Hole_Spacing)/2+0.01, 0, 2.5*String_Hole_Spacing+String_Hole_Diameter+Extra_String_Height+0.01])
			rotate(a=[0, 90, 0])
			rotate(a=[-90, 0, 0])
				fillet(r=2.5*String_Hole_Spacing, h=100);
		
		}	
	}	
	
	
	
module tuner()
	{
	translate([0, Rod_Length/2, Rod_Radius*cos(30)])
	difference()
		{
		rotate(a=[90, 0, 0])
			cylinder(h=Rod_Length+Extra_Tuner_Length, r=Rod_Radius, $fn=6);
		translate([0, 1, 0])
			rotate(a=[90, 0, 0])
				cylinder(h=Rod_Length+1-0.5, r=Tuner_Screw_Radius, $fn=16);
		translate([-String_Radius, -Rod_Length-Extra_Tuner_Length/2, -10])
//			polyhole(h=20, d=String_Radius*2);
//			cylinder(h=20, r=String_Radius, center=true);
			cube([2*String_Radius, 2*String_Radius, 20]);
		}
	}



