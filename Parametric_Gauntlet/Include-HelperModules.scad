/*
	This file is a collection of helper modules that gets included in each
	of the various scad files used to create a customized hand.  Originally,
	each scad had its own modules in-line.  It made more sense to pull them
	all into a separate file and then include that file.  This has allowed
	more consistent attribution, as well as ensuring that the best "golden"
	version of any given module is always the one used.
*/

	
	
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



//OpenSCAD Bezier Function by WilliamAAdams
//licensed under the Creative Commons - Public Domain license - no rights reserved
//provided here, as-is, without any warranty of any sort
//original work available at http://www.thingiverse.com/thing:8443

joinfactor = 0.125;
gFocalPoint = [0,0];
gSteps = 10;
gHeight = 8;

//BezQuadCurve( [[0, 15],[5,5],[10,5],[15,15]], [7.5,0], gSteps, gHeight);

//=======================================
// Functions
//=======================================
function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function PointAlongBez4(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]];

//=======================================
// Modules
//=======================================
// c - ControlPoints
module BezQuadCurve(c, focalPoint, steps=gSteps, height=gHeight)
{
	// Draw control points
	// Just comment this out when you're doing the real thing
//	for(point=[0:3])
//	{
//		translate(c[point])
//		color([1,0,0])
//		cylinder(r=1, h=height+joinfactor);
//	}

	for(step = [steps:1])
	{
		linear_extrude(height = height, convexity = 10) 
		polygon(
			points=[
				focalPoint,
				PointAlongBez4(c[0], c[1], c[2],c[3], step/steps),
				PointAlongBez4(c[0], c[1], c[2],c[3], (step-1)/steps)],
			paths=[[0,1,2,0]]
		);
	}
}

//==============================================
// Test functions
//==============================================
//PlotBEZ0(100);
//PlotBEZ1(100);
//PlotBEZ2(100);
//PlotBEZ3(100);
//PlotBez4Blending();


module PlotBEZ0(steps)
{
	cubeSize = 1;
	cubeHeight = steps;

	for (step=[0:steps])
	{
		translate([cubeSize*step, 0, 0])
		cube(size=[cubeSize, cubeSize, BEZ03(step/steps)*cubeHeight]);
	}	
}

module PlotBEZ1(steps)
{
	cubeSize = 1;
	cubeHeight = steps;

	for (step=[0:steps])
	{
		translate([cubeSize*step, 0, 0])
		cube(size=[cubeSize, cubeSize, BEZ13(step/steps)*cubeHeight]);
	}	
}

module PlotBEZ2(steps)
{
	cubeSize = 1;
	cubeHeight = steps;

	for (step=[0:steps])
	{
		translate([cubeSize*step, 0, 0])
		cube(size=[cubeSize, cubeSize, BEZ23(step/steps)*cubeHeight]);
	}	
}

module PlotBEZ3(steps)
{
	cubeSize = 1;
	cubeHeight = steps;

	for (step=[0:steps])
	{
		translate([cubeSize*step, 0, 0])
		cube(size=[cubeSize, cubeSize, BEZ33(step/steps)*cubeHeight]);
	}	
}

module PlotBez4Blending()
{
	sizing = 100;

	translate([0, 0, sizing + 10])
	PlotBEZ0(100);

	translate([sizing+10, 0, sizing + 10])
	PlotBEZ1(100);

	translate([0, 0, 0])
	PlotBEZ2(100);

	translate([sizing+10, 0, 0])
	PlotBEZ3(100);
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


