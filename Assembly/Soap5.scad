$fn=64;

margin=2;

shapes = [[30,50],[45,45],[58,37],[20,40],[40,40],[40,70],[20,50],[22,14],[25*(2+3/8),25*(3+3/8)]];

//height=30; width=50; // regular bar
//height=45; width=45; // square bar

depth=1.5;
hdepth=0.5; //depth/2;
g=0.4;
edge=10;
boxHeight = 25;
w=.5; // wall thickness

//spacing=height+10;

//module soap(message, font, offset=0, shape=0) {
//	assign (height=shapes[shape][0], width=shapes[shape][1]) {
//	color("grey") 
//	translate([width-margin,margin+offset,0]) 
//	resize([width-2*margin,height-2*margin,depth]) 
//	linear_extrude(height=10, convexity=1000) 
//	mirror([1,0,0]) text(t=message, font=font, size=10, 
//		halign=[0, "center"], 
//		valign=[10,"bottom"]);
//	cube([width,height,hdepth]);
//	}
//	}

module imprint(messageList, font, offset=0, sp=7, shape=0) {
	assign (height=shapes[shape][0], width=shapes[shape][1]) {
		echo("soap",height,width);
		color("grey") translate([width/2, height/2,0])  writeStuff(messageList, font, offset, sp, shape);
//		translate([width-margin,margin+height*(len(messageList)-1)/len(messageList),hdepth-.01]) 
	cube([shapes[shape][1],shapes[shape][0],1]);
	}
	}
	
//imprint(["LOVE"],"Courier");
//imprint(["MAKE"],"Arial:style=Bold");


module soap(messageList, font, offset=0, sp=7, shape=0) {
	assign (height=shapes[shape][0], width=shapes[shape][1]) {
		echo("soap",height,width);
		color("grey") translate([width/2, height/2,-2])  
			writeStuff(messageList, font, offset, sp, shape);
//		translate([width-margin,margin+height*(len(messageList)-1)/len(messageList),hdepth-.01]) 
//		resize([width-2*margin,height-2*margin,hdepth]) 
//		mirror([1,0,0]) 
//		union() 
//		for (i = [0:len(messageList)-1]) {
//			assign(
//				message = messageList[i],
//				offset = (len(messageList)-1)/2,
//				spacing = height/len(messageList)
//				) {
//				translate([0,-sp*i,0]) linear_extrude(height=depth, convexity=1000) 
//					resize([100,5]) text(message, font=font, size=5, halign=[0, "center"], valign=[0, "center"]);
//				echo(message, i, offset, sp, font);
//				}
//			}
		//cube([width,height,hdepth]);
		box(shape);
		}
	}

module writeStuff(messageList, font, offset=0, sp=7, shape=0, rot=0) {
	assign (h=shapes[shape][0], w=shapes[shape][1])  
		{
		echo("write",messageList, font, offset,sp, shape, shapes[shape],"height",h, "width",w);
		color("grey") translate([-w/2,-h/2,2])
		translate([w-margin,margin+h*(len(messageList)-1)/len(messageList),0]) 
			resize([w-2*margin,h-2*margin,depth]) 
		mirror([1,0,0]) 
		union() 
		for (i = [0:len(messageList)-1]) {
			assign(
				message = messageList[i],
				offset = (len(messageList)-1)/2,
				spacing = height/len(messageList)
				) {
				translate([0,-sp*i,0]) linear_extrude(height=depth+hdelth, convexity=1000) 
					resize([100,5]) text(message, font=font, size=5, halign=[0, "center"], valign=[0, "center"]);
				echo(message, i, offset, sp, font);
				}
			}
		}
	}

//writeStuff(["TEST"],"courier", shape=4);
//cube(shape[0],center=true);

module box(shape) {
	translate([-edge,-edge,0]) difference() {
		translate([-w,-w,0]) cube([shapes[shape][1]+2*edge+2*w, shapes[shape][0]+2*edge+2*w, 25+hdepth]);
		translate([0,0,hdepth]) cube([shapes[shape][1]+2*edge, shapes[shape][0]+2*edge, 25+g]);
		//translate([10-g,10-g,-1]) cube([shapes[shape][1]+2*g, shapes[shape][0]+2*g, hdepth+2]);
		}
	}

//wide=50;
//tall=70;
//deep=25;
thin=2;

module soapShield(message, font, width, height, thick, shape=3, rot=0) {
	echo("soapShield",message, font, width, height, thick, "shape", shape);
	translate([0,height/4,0]) 
	//translate([-shapes[shape][1]*.5,.5*shapes[shape][0],thick]) 
		rotate([0,0,rot]) writeStuff(message, font, shape=shape, rot=rot);
	shield(width+g, height+g, thick);
	shieldBox(width,height,thin);
	}

module shield(width, height, thick) {
	assign(slant=thick/10) {
		intersection() {
			translate([0,-height/2*.8,0]) cylinder(r=height, h=thick);
			//cube([width, height, 2], center=true);
			translate([height-width/2, height/3, 0])
				cylinder(r1=height,r2=height+slant, h=thick);
			mirror([1,0,0])
				translate([height-width/2, height/3, 0])
					cylinder(r1=height,r2=height+slant, h=thick);
			}
		}
	}

module shieldBox(wide, tall, thin) {
	echo("shieldbox ",wide, tall, thin);
	shield(wide, tall, thin);
	translate([0,0,thin-.05]) color("yellow") shield(wide-2*thin, tall-2*thin, thin);
	difference() {
		shield(wide+2*thin, tall+2*thin, 25);
		translate([0,0,-1]) shield(wide, tall, 25+2);
		}
	}

module roundBox(height, width, depth, radius) {
	hull() for (x=[radius,width-radius], y=[radius,height-radius], z=[radius,depth]) {
		//echo("point",x, y, z);
		translate([x,y,z]) sphere(radius, $fn=32);
		}
	}

module roundShell(shape, depth, radius) {
	assign (height=shapes[shape][0]+2*radius, width=shapes[shape][1]+2*radius) {
		echo("roundShell",height,width, depth, radius);
		difference() {
			translate([-w,-w,-w]) cube([width+2*w,height+2*w,depth]);
			roundBox(height,width,depth,radius);
			}
		}
	}

caked = 50;
caked2 = 54;

module cake() {
	// HAPPEE BIRTHDAE HARRY
	intersection() {
		translate([0,0,thin+.1]) cylinder(r=caked/2+thin, h=thin-.2);

		mirror([1,0,0]) difference() {
			cylinder(r1=caked/2+thin, r2=caked2/2+thin, h=boxHeight);
			translate([0,0,2*thin]) cylinder(r1=caked/2, r2=caked2/2, h=boxHeight);
			//translate([-20,5,thin]) linear_extrude(height=thin, convexity=1000) text("HAPPEE", font="Comic Sans MS", size=7);
			rotate([0,0,5]) cakewrite(-15,10,"HAPPEE",6);
			cakewrite(-22,0,"BIRTHDAE",6);
			rotate([0,0,7]) cakewrite(-15,-13,"HARRY",8);
			}
		}
	}

module cakewrite(x,y,text,size) {
	color("blue") translate([x,y,thin]) linear_extrude(height=thin+1, convexity=1000) text(t=text, font="Comic Sans MS:style=Bold", size=size);
	}

module sherlock(shape) {
	assign (h=shapes[shape][0], w=shapes[shape][1]) {
		translate([-w/2-edge,-h/2-edge,0]) difference() {
			cube([w+2*edge, h+2*edge, 25]);
			echo(w+2*edge, h+2*edge, 25);
			translate([1,1,hdepth]) cube([w+2*edge-2, h+2*edge-2, 25]);
			}
		translate([8,0,0]) writeStuff(["221"], "Baskerville:style=Bold",12,shape=0,rot=0);
		translate([-24,-6,0]) writeStuff("B", "Baskerville:style=Bold",8,shape=7);
		}
	}

//sherlock(0);

//cake();

//roundShell(shape=0, depth=25, radius=5);
//translate([5,5,0]) writeStuff(["BRAVE"], "Arial Black",12,shape=0);

module makeSoap (label,font="Arial Black") {
	echo("shell");
	roundShell(shape=8, depth=25, radius=5);
	echo("write");
	translate([shapes[8][1]/2+6,shapes[8][0]/2+5,-2.5]) 
		writeStuff([label], font,12,shape=8);
	echo("done");
	}

//makeSoap("THINK");
	difference(){
//makeSoap("MAKE");
	//translate([-10,-10,-10]) cube(50);
	}
	
//translate([shapes[8][1]/2+6,shapes[8][0]/2+5,-2]) writeStuff(["MAKE"], "Arial Black",12,shape=8);
//translate([shapes[8][1]/2+6,shapes[8][0]/2+5,-2]) writeStuff(["ORL"], "Arial Black",12,shape=8);
//translate([shapes[0][1]/2+6,shapes[0][0]/2+5,-2]) writeStuff(["2014"], "Arial Black",12,shape=0);
//translate([shapes[0][1]/2+6,shapes[0][0]/2+5,-2]) writeStuff(["FAIRE"], "Arial Black",12,shape=0);
//translate([shapes[8][1]/2+6,shapes[8][0]/2+5,-2]) writeStuff(["THINK"], "Arial Black",12,shape=8);


//soapShield(["BRAVE"],"Arial Black",50,75,depth/2);
//soapShield(["LOYAL"],"Arial Black",50,75,depth/2);
//soapShield(["SMART"],"Arial Black",50,75,depth/2, shape=4, rot=90);
//soapShield(["AMB","ITI","OUS"],"Arial Black",50,75,depth/2,shape=4);
//soapShield(["SELF","LESS"],"Arial Black",50,75,depth/2,shape=4);
//soapShield(["PEACEFUL"],"Arial Black",50,75,depth/2,shape=3);

//roundShell(shape=0, depth=25, radius=5);
//translate([5,5,0]) writeStuff(["Nitwit!"], "Arial Black",12,shape=0);
//translate([5,5,0]) writeStuff(["Blubber!"], "Arial Black",12,shape=0);
//translate([5,5,0]) writeStuff(["Oddment!"], "Arial Black",12,shape=0);
//translate([5,5,0]) writeStuff(["Tweak!"], "Arial Black",12,shape=0);


//soap(["Happiness can be found","even in the darkest of times,","if one only remembers","to turn on the light."], "Arial Black",12);

//soap(["Wit beyond measure ","is man's greatest","treasure"], font="Copperplate", offset=3,sp=4);

//soap(["Nitwit! Blubber!","Oddment! Tweak!"], font="Copperplate", offset=-1,sp=4);

//soap("Turn to page 394",font="Mesquite Std", offset=0, shape=0);

//soap(["Friendship!","And bravery!"], font="Avenir", offset=1s,sp=5, shape=0);
//soap(["Brave","Ambitious", "Smart", "Loyal"], font="Copperplate", offset=0,sp=7, shape=2);

//box(2);

//soap(["Selfless","Inteligent", "Brave", "Peaceful", "Honest"], font="Copperplate", offset=8.5,sp=7, shape=0);
//box(0);



//soap(["Books!","& cleverness!"], font="Avenir", offset=0,sp=7);

module chip(name, font="Prestige Elite Std") {
	difference() {
		union() {
		soap([name], font=font, offset=3);

		for (x=[-2.5:10:shapes[0][1]]) {
			translate([x-w,-edge-w-5,0]) cube([5+2*w,5,boxHeight+hdepth]);
			translate([x-w,shapes[0][0]+edge+w,0]) cube([5+2*w,5,boxHeight+hdepth]);
			}
		}
		for (x=[-2.5:10:shapes[0][1]]) {
			translate([x,-edge-5,5]) cube([5,5+g,boxHeight]);
			translate([x,shapes[0][0]+edge-g,5]) cube([5,5+g,boxHeight]);
			}
		//translate([-5,-9,3]) cube([shapes[0][1]+10,shapes[0][0]+18,boxHeight]);
		}
		translate([shapes[0][1]+edge, shapes[0][0]/2, 0]) cylinder(r=5,h=5);
	}

difference(){
//chip("6502");
chip("x86");
//chip("Arduino", font="Arial");
//chip("Pi");
//chip("ARM", font="Arial");
//translate([-50,-50]) cube(50);
	}
	
//soap(["Ron","Weasley"], font="Prestige Elite Std", offset=3);
//soap(["Harry","Potter"], font="Prestige Elite Std", offset=1);
//soap(["Hermione","Granger"], font="Copperplate", offset=-1,sp=4);
//soap("I open at the close", "HogwartsWizard",7);
//soap(["Keep Calm","-   and   -","Magic On"], "Keep Calm", sp=7, offset=9);
//soap(["Nope,","but I'll try",""], "Arial Black",0);
//soap("DFTBA", "Courier");
//soap(["Nothing like a","nightime stroll","to give you ideas"], "Copperplate",3.5);


