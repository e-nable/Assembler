module fingertipexamples(set=0)
	{
	if (set==0)
		{
		translate([-0.35,22.5+0.5,1.5]) rotate([10,0,0]) import("cb-fingertip.stl"); 		//	"Finger_CyborgBeast6.4_original.stl"
		mirror([0,0,1]) mirror([0,1,0]) translate([0,0,-9.5]) import("cb-fingermid.stl"); 		//	"Proximal_Phalange_Cyborg_Beast_7.0.stl"
		}
	if (set==1)
		{
		translate([0,22.5+0.5,1.5]) rotate([10,0,0]) fingertip(s=1, grip=1, len=0);
		mirror([0,0,1]) mirror([0,1,0]) translate([0,0,-9.5]) import("cb-fingermid.stl");
		}
	}

//	Finger tip, can be scaled, lengthened, and grips added
module fingertip(s=1, len=0, grip=1)
	{
	difference()
		{
		scale([s,s,s]) fingertipsolid(len=len, grip=grip);
		//	Hole for screw
		translate([0,(-11-len/3)*s,5*s]) rotate([0,90,0]) cylinder(r=4/2, h=20, center=true, $fn=fn/2);
		//	Channel for elastic
		translate([0,0,3*s]) rotate([90,0,0]) cylinder(r=2.25/2, h=(40+len*4)*s, center=true, $fn=fn/2);
		translate([0,8.5*s,3*s]) rotate([-90,0,0]) cylinder(r=3.25/2, h=(40+len*4)*s, center=false, $fn=fn/2);
		hull() for (i=[-1,3]) translate([0,-1.5*s,i*s]) rotate([90,0,0]) cylinder(r=2.25/2, h=(40+len*4)*s, center=false, $fn=fn/2);
		//	Channel for tension cable
		hull() { for(i=[0:1]) translate([0,5*s,8*s+10*s*i]) rotate([90,0,0]) cylinder(r=2/2, h=(40+len*4)*s, center=false, $fn=fn/2); }
		translate([0,(17+len/3)*s,8*s]) 
			{
			rotate([90,0,0]) cylinder(r=2/2, h=(40+len*4)*s, center=false, $fn=fn/2);
			rotate([30,0,0]) 
				{
				rotate([-90,0,0]) cylinder(r=3/2, h=(40+len*4)*s, center=false, $fn=fn/2);
				rotate([-90,0,0]) sphere(r=3/2, $fn=fn/2);
				}
			}
		}
	}

//	Finger tip solid
module fingertipsolid(len=0, grip=1, rad=5)
	{
	difference()
		{
		union()
			{
			//	Do we need grips?
			if (grip) 
				{ 
				translate([0,0.5,0]) for(i=[0:4]) translate([0,i*1.75,0]) fingerpoints(rows=2, rad=rad); 
				//	Add more grips if the finger is a little longer
				if (len>0) 
					{ translate([0,0.5,0]) for(i=[5:ceil(len/6)+4]) translate([0,i*1.75,0]) fingerpoints(rows=2, rad=rad); }
				}
			//	Finger tip
			translate([0,len/3,0]) rotate([30,0,0]) translate([0,10.4,-0.5]) 
				{
				if (grip) 
					{
					translate([0,0.5,0]) for(i=[0:4]) translate([0,i*1.75+0.75,-5]) fingerpoints(rows=2, rad=rad);
					if (len>0)
						{
						//	Add more grips if the finger is a little longer
						translate([0,0.5,0]) for(i=[5:ceil(len/5.5)+4]) translate([0,i*1.75+0.75,-5]) 
							fingerpoints(rows=2, rad=rad);
						for(i=[1:4]) translate([0,4*1.75 +1.3+len/3,0]) rotate([-24*i,0,0]) 
							translate([0,0,-5]) fingerpoints(rows=2-round(i%2), rad=rad);
						}
					else
						{
						for(i=[1:4]) translate([0,4*1.75 +1.3,0]) rotate([-24*i,0,0]) translate([0,0,-5]) 
							fingerpoints(rows=2-round(i%2), rad=rad);
						}
					}
				hull()
					{
					translate([0,0.5,0]) sphere(r=rad-0.25, $fn=fn);
					if (len>0)
						{
						translate([0,8.5+len/3,0]) sphere(r=rad-0.25, $fn=fn);
						translate([0,8.5+len/3,0]) intersection()
							{
							cylinder(r=4.75, h=10, center=true, $fn=fn);
							rotate([90,0,0]) cylinder(r=rad-0.25, h=10, center=true, $fn=fn);
							translate([0,0,-100/2]) cube(100, center=true);
							}
						}
					else
						{
						translate([0,8.5,0]) sphere(r=rad-0.25, $fn=fn);
						translate([0,8.5,0]) intersection()
							{
							cylinder(r=rad-0.25, h=10, center=true, $fn=fn);
							rotate([90,0,0]) cylinder(r=rad-0.25, h=10, center=true, $fn=fn);
							translate([0,0,-100/2]) cube(100, center=true);
							}
						}
					}
				}
			//	Finger, mid part
			union() 
				{
				//	Flat part (this is where mouse ears would go)
				translate([0,0,2/2-0.05]) hull()
					{
					for(i=[-1,1]) translate([(rad-2+1.5)*i,-8,0]) rotate([90,0,0]) 
						cylinder(r=1, h=8+len/3, $fn=fn/2, center=false);
					}
				//	Hinge to center of finger
				hull()
					{
					//	Blending to the bottom flat part
					translate([0,0,2/2-0.05]) for(i=[-1,1]) translate([(rad-2+1.5)*i,-8,0]) rotate([90,0,0]) 
						cylinder(r=1, h=(8+len/3)/2, $fn=fn/2, center=false);
					//	Cylinder connector to hinge
					translate([0,-11-len/3,5]) rotate([0,90,0]) cylinder(r=4.75, h=10, center=true, $fn=fn);
					//	Blending to sphere between finger nail and middle of finger
					translate([0,len/3,0]) rotate([30,0,0]) translate([0,rad*2 + 0.3,-0.5]) translate([0,0.5,0]) 
						sphere(r=rad-0.25, $fn=fn);
					}
				}
			//	End of union of solid finger tip
			}
		//	Differencing out connection to knuckle
		hull() for(j=[0,5]) for(i=[5,10]) translate([0,-11-len/3-j,i]) rotate([0,90,0]) cylinder(r=4.75+0.25+0.1, h=4.6, center=true, $fn=fn);
		}
	}

//	A single grippy bit for a finger tip
module fingerpoint(rad=5)
	{
//	translate([0,0,8.33]) rotate([45,35,90]) cube(1.5, center=true);
	translate([0,0,rad+3.33]) rotate([45,35,90]) cube(1.5, center=true);
	}

//	A curved semi-circle of grippy bits for a finger tip
module fingerpoints(rows=3, rad=5)
	{
	for(j=[0,1]) mirror([0,j,0]) scale([0.78,1,1.1]) for(i=[-rows:rows]) 
		rotate([0,i*15,0]) rotate([0,0,round(i%2)*180]) 
		fingerpoint(rad);
	}