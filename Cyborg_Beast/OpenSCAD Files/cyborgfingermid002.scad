//	Middle segment of finger, can be scaled and lengthened
module fingermid(s=1, len=0, rad=5)
	{
	difference()
		{
		scale([s,s,s]) fingermidsolid(len=len, rad=rad);
		//	Hole for screw
		for (i=[-1,1]) translate([0,(-11.5-len/3)*s*i,5*s]) rotate([0,90,0]) 
			cylinder(r=4/2, h=20, center=true, $fn=fn/2); 
		//	Channel for elastic and tension cable
		for (i=[-1,1]) translate([0,0,5+ 6.5/2*i]) rotate([90,0,0]) 
			cylinder(r=2/2, h=40+len, $fn=fn/2, center=true);
		//	Channels for tension cables to constrict
		for(i=[0,1]) mirror([0,i,0]) hull() for (i=[0,1]) translate([0,-6-len/3,1.75-6.5/2 *i]) rotate([90,0,0]) 
			cylinder(r=2/2, h=20+len, $fn=fn/2, center=false);
		}
	}

//	Middle segment of finger, solid
module fingermidsolid(len=0, rad=5)
	{
	difference()
		{
		union()
			{
			hull()
				{
				//	Back of knuckle
				translate([0,(13+rad*2+len/3*2)/-2,7.5]) rotate([0,-90,0]) intersection() 
					{ 
					cylinder(r=5, h=4.6, center=true, $fn=fn); 
					translate([0,0,-100/2]) cube(100, center=false); 
					}
				//	Flat bottom so it touches the build surface
				translate([0,0,2/2]) cube([4.6-0.2, (11.5+len/3)*2, 2], center=true);
				}
			hull()
				{
				//	Circular parts for connecting hinges
				for(i=[-1,1]) translate([0,(-11.5-len/3)*i,5]) rotate([0,90,0]) 
					cylinder(r=(4.75+0.25+0.1-0.2), h=4.6-0.2, center=true, $fn=fn);
				//	Flat bottom so it touches the build surface
				translate([0,0,2/2]) cube([4.6-0.2, (11.5+len/3)*2, 2], center=true);
				}
		//	Rounding the finger so it looks more natural
			hull()
				{
				translate([0,0,5+0.5]) intersection()
					{
					scale([1,2,1]) rotate([90,0,0]) 
						cylinder(r2=5.75, r1=6.75, h=(11.5+rad+len/3), center=true, $fn=fn*2);
					cube([11,(11.5+len/3)*2,11], center=true);
					}
				}
			}
		//	Difference out stuff
		for(j=[0:1]) mirror([0,j,0]) for(i=[0:1]) mirror([i,0,0]) hull() 
			{
			translate([(4.6-0.2)/2,-(11.5+len/3),5]) 
				{
				rotate([-90-60,0,0]) translate([0,0,-10]) rotate([0,90,0]) 
					cylinder(r=5+0.2*2, h=10, center=false, $fn=fn);
				translate([0,0,-10]) rotate([0,90,0]) cylinder(r=5+0.2*2, h=10, center=false, $fn=fn);
				rotate([0,90,0]) cylinder(r=5+0.2*2, h=10, center=false, $fn=fn);
				}
			}
		}
	}