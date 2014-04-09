knuckleR = 4.85;
wristH = 10;
palmH = 20;
palmW = 64;
th = 3;
fn = 32;

//CyborgBeastParametricPalm();

module CyborgBeastParametricPalm() {

translate([1000,0,0]) cube();

// translate([6.4,0,0]) import("cb-palmleft.stl"); 
difference()
	{
	difference()
		{
		cyborgbeast07palm();
		cyborgbeast07palminsidespace();
		//	Finger connectors
//		for(i=[-3,-1,1,3]) translate([i*7.3,28,0]) cube([5,15,21.6], center=true);
		for(i=[-3,-1,1,3]) translate([i*7.3,28,0]) 
			{
			cube([5,15,21.6], center=true);
			translate([0,-4.5,0]) rotate([30,0,i*-6]) cylinder(r=1.25, h=100, center=false, $fn=fn/2);
		render()	difference()
				{
				hull() translate([0,-4.5,0]) 
					{
					rotate([30,0,i*-6]) cylinder(r=1.25, h=100, center=false, $fn=fn/2);
					rotate([0,0,0]) cylinder(r=1.25, h=100, center=false, $fn=fn/2);
					}
				translate([0,0,-100/2 + 10]) cube(100, center=true);
				}
			}
		
		//	Thumb connector
		translate([40,-13,5]) rotate([-72,0,0]) 
			translate([4,4.1,0]) cube([21.6,15,5], center=true);
		//	Making sure the bottom is flat
		translate([0,0,-100/2]) cube(100, center=true);
		}
	hardwarecutouts();
	}
}

module cyborgthumbsolid()
	{
	translate([-1.5,-2.4,0]) rotate([91,90,20]) knuckleblock();
	hull() 
		{
		translate([-20,0,5]) rotate([0,30,0]) scale([1,1,0.5]) sphere(r=9);
		hull() 
			{
			cylinder(r=4.5, h=11-1, center=true, $fn=fn*2);
			translate([-10,-1,0]) cylinder(r=4.5, h=10, center=true, $fn=fn*2);
			rotate([-10,0,0]) translate([-10,-6,-1]) 
				cylinder(r=4.5, h=9, center=true, $fn=fn*2);
			}
		hull() 
			{
		rotate([-20,0,0]) translate([-10,-8,-3]) cylinder(r=5, h=7, center=true, $fn=fn*2);
		rotate([-10,0,0]) translate([-10,-6,-1]) cylinder(r=4.5, h=9, center=true, $fn=fn*2);
		rotate([-20,0,0]) translate([-16,-10,-1]) cylinder(r=4.5, h=9, center=true, $fn=fn*2);
			}
		}
	}

module cyborgbeast07palminsidespace()
	{
	//	Cutouts through the top of the palm - cosmetic and to reduce plastic?
	for(i=[0,1]) 
		{
		mirror([i,0,0])
			{
			hull()
				{
				translate([13,13,0]) cylinder(r=3, h=100, center=true, $fn=fn/2);
				translate([10,5,0]) cylinder(r=2, h=100, center=true, $fn=fn/2);
				}
			hull()
				{
				translate([10,5,0]) cylinder(r=2, h=100, center=true, $fn=fn/2);
				translate([5,-5,0]) cylinder(r=1.5, h=100, center=true, $fn=fn/2);
				}
			}
		}
	//	
//	translate([40,-13,5]) rotate([-72,0,0]) 

	//	Cutout of area inside the palm
	hull()
		{
		//	Rectangular cutout
		translate([0,-3.5,0]) cube([48,40,20], center=true);
		//	Cutout of the rounded bits on either side of the user's knucles
		for(i=[-1,1]) translate([17*i,4,0]) cylinder(r=11, h=20, center=true);
		//	Organic-y bits inside the hand
		translate([0,4,15]) rotate([-10,0,0]) scale([1,1,0.3]) sphere(r=10);
		translate([14,4,15]) rotate([-10,10,0]) scale([1,1,0.3]) sphere(r=10);
		translate([-14,4,15]) rotate([-10,-10,0]) scale([1,1,0.3]) sphere(r=10);
		translate([0,-24,19]) rotate([-10,0,0]) scale([1,1,0.3]) sphere(r=20);
		}
	}


module hardwarecutouts()
	{
	//	Three holes for putting in velcro straps
		for (i=[-1,0,1]) translate([18*i,pow(i,2)*-12 +3,0]) 
			cylinder(r=4/2, h=100, center=true, $fn=fn/2);
	//	Knuckle block hinge
		translate([0,27,5]) rotate([0,90,0]) cylinder(r=4/2, h=100, center=true, $fn=fn/2);
	//	Wrist hinges
		translate([0,-27,5.5]) rotate([0,90,0]) cylinder(r=4/2, h=100, center=true, $fn=fn/2);
	//	Holes for tying the elastic cord at knuckles
		for (i=[-1,1]) translate([7.3*2*i,22,0]) for(i=[-1,1]) translate([2*i,0,0])
			cylinder(r=1.25, h=100, center=true, $fn=fn/4);
	//	Holes for the tendons on wrist
		translate([0,-10,palmW/2-5]) rotate([-4,0,0]) 
			{
		*	for(i=[-4,-2,0,2,4]) translate([i*2,0,pow(i,2)*-0.05  ]) rotate([90,0,i*-2]) 
				cylinder(r=1, h=100, center=true, $fn=fn/4);
			for(i=[-3,-1,1,3]) translate([i*2,0,pow(i,2)*-0.05  ]) rotate([90,0,i*-2]) 
				cylinder(r=1, h=100, center=true, $fn=fn/4);
			translate([5*2,0,pow(5,2)*-0.05  ]) rotate([90,0,5*-2]) 
				union() translate([0,0,10]) {
				cylinder(r=1, h=100, center=false, $fn=fn/4);
				rotate([0,120,-15]) cylinder(r=1, h=100, center=false, $fn=fn/4);
				sphere(1.25);
				}
			}
	//	Holes for thumb knuckle
		translate([40,-13,5]) rotate([-72,0,0]) cylinder(r=4/2, h=40, center=true, $fn=fn/2);
	//	Elastic return cutout
		translate([31,-13,16]) rotate([-72,0,0]) cylinder(r=3/2, h=40, center=true, $fn=fn/2);
	//	Thumb tendon channel
		translate([33,-13,5]) rotate([90-72,-90,-30]) 
			rotate([0,-20,-0]) rotate([10,90,0]) translate([0,0,-10]) 
				cylinder(r=1, h=100, center=false, $fn=fn/2);
	//	Thumb tendon channel
		translate([33,-13,5]) rotate([90-72,-90,-30]) 
			rotate([0,-20,-0]) rotate([10,90,0]) translate([0,0,5]) 
				cylinder(r1=1, r2=20, h=100, center=false, $fn=fn/2);
		
	}

module knuckleblock()
	{
	difference()
		{
		hull() for(j=[-1,1]) for(i=[-1,1]) translate([2.6*i,0,2.5*j]) rotate([90,0,0]) 
			cylinder(r=1.5, h=10, center=true, $fn=fn/2);
		cube([5,11,5.5], center=true);
	*	translate([0,7.8,-2]) cube(9, center=true);
		}
	}

module cyborgbeast07palm()
	{
	//	Thumb!!!
	translate([40,-13,5]) rotate([-72,0,0]) cyborgthumbsolid();
	//	Knuckle Block
	for(i=[-3,-1,1,3]) translate([i*7.3,23.9,4+4]) knuckleblock();

	//	Palm
	hull() 
		{
		//	Organic forms for back of knuckles
			//	Near thumb
		translate([20.5,10,15.7]) rotate([-18,10,0]) scale([1,1,0.4]) sphere(10);
			//	Center of back of hand
		translate([0,11,18.1]) rotate([-23,0,0]) scale([1,1,0.2]) sphere(10);
			//	Near pinky
		translate([-20,10,14.5]) rotate([-18,-20,0]) scale([1,1,0.4]) sphere(10);
		//	Knuckles
		translate([0,27,knuckleR]) rotate([0,90,0]) 
			cylinder(r=knuckleR, h=55, center=true, $fn=fn);
		//	Palm
		translate([0,2,0]) scale([1,0.8,1]) cylinder(r=palmW/2-0.5, h=wristH/2, $fn=fn*2);	
		difference()
			{
			translate([0,-1,wristH-1]) rotate([-10,-5,0]) scale([1,0.8,0.3]) 
				sphere(r=palmW/2+1.25, $fn=fn*2);
			translate([0,0,-1000/2]) cube(1000, center=true);
			}
		//	Wrist
		for(i=[-1,1]) translate([26.6*i,-12,wristH/2]) cube([th,10,wristH], center=true); 
		//	Back of wrist
		translate([0,-18,0]) 
			{
			translate([0,0,17]) scale([1,1,0.4]) rotate([90,0,0]) 
				cylinder(r=palmW/2-6, h=th, center=true, $fn=fn); 
			rotate([90,0,0]) intersection() 
				{ 
				cylinder(r=palmW/2-4, h=th, center=true, $fn=fn); 
				translate([0,palmW,0]) cube(palmW*2, center=true); 
				}
			}
		//	Back of wrist, end of tendons
		translate([0,-19,26]) intersection() 
			{ 
			rotate([-20,0,0]) scale([0.5,0.3,0.1]) sphere(r=palmW/2-6); 
			}
		}


	//	Wrist hinge
	for(i=[-1,1]) 
		translate([26.6*i,-12,wristH/2]) { 
			cube([th,30,wristH], center=true); 
			translate([0,-30+wristH*1.5,0]) rotate([0,90,0]) 
				cylinder(r=wristH/2, h=th, center=true, $fn=fn);
			}
	}

//CyborgBeastParametricPalm();