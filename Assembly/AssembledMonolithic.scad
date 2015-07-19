// debug values
//fingerSelect = 4;
//palmSelect = 6;
//gauntletSelect = 4;
//prostheticHand = 1;

EHproxLen = 22;

module assembled(CBscale, CBscaleW, CCBscale, CCBscaleW, EHscale, EHscaleW, scale, scaleW, explode=0, flare=0, mount=0, gauntlet=1) {
    echo(str("Rendering ", explode?"exploded":"assembled", " view."));
    echo(str("CB scale [",CBscale,CBscaleW,"]"));
    echo(str("CCB scale [",CCBscale,CCBscaleW,"]"));
    echo(str("EH scale [",EHscale,EHscaleW,"]"));
    echo(str("scale [",scale,scaleW,"]"));
    // scaling for selected palm

    if (showControls) %showControlPoints();
    
    if (isRaptor) {
        echo("*** assembling Raptor pins");
        echo("wrist ",wristControl);
        echo("knuckle ",knuckleControl);
        if (gauntlet) {
            color("green") 
            translate(wristControl) 
            translate([-21*scaleW+explode,0,-3*scaleW])
            EHhingePins(EHscale, EHscaleW);
            
            color("green") 
            translate(wristControl) 
            translate([-32*scaleW-0.5*explode,0,-7*scaleW]) 
            rotate([0,-90,0])
            EHhingeCaps(EHscale, EHscaleW);
            
            color("red") 
            translate([0,-56*scale-4*explode, 25*scale]) 
            rotate([-90,0,0])
            EHtensioner(EHscale, EHscaleW);
            
            color("orange") 
            translate([0,-68*scale-4.5*explode,23.2*EHscale]) 
            rotate([180,0,0])
            EHdovetail(EHscale, EHscaleW, flare=flare);
            
            color("green")
            translate([0,-40*EHscaleW+1.5*explode,24*EHscale])
            EHhexPins(EHscale, EHscaleW);
        }
        
        color("green")
        translate(knuckleControl) 
        translate([-1-1.8*explode*EHscaleW,0,-4*scale]) 
        EHknucklePins(EHscale, EHscaleW);
        
        if (haveThumb) 
            mirror([prostheticHand,0,0]) 
            translate([thumbControl[0]*scaleW,thumbControl[1]*scale,thumbControl[2]*scale]) 
            rotate(thumbRotate)
            color("green") 
            translate([-1.5*explode,0,-1.25*scale])
            rotate([0,0,180]) 
            EHthumbPin(EHscale,EHscaleW);
    }
    // Four Fingers
    //echo("FINGERS");
    //echo(fingerSpacing);
    translate(knuckleControl) {
        // assemble the fingers
        if (isRaptor) { // e-NABLE Hand 2.0 uses distinct fingers
            echo("EH fingers spacing ",fingerSpacing, scaleW);
            translate([-1.5*fingerSpacing*scaleW,0+explode,-2*scale]) {
                echo("EHProximale scale ",[EHscaleW,EHscale,EHscale]);
                color("yellow") scale([EHscaleW,EHscale,EHscale]) EHProximalPhalange();
                color("green") translate([0,EHproxLen*scale+explode,-1]) rotate([0,0,180]) EHfingerPin(EHscale, EHscaleW);
                color("orange") translate([0,EHproxLen*scale+2*explode,0]) scale([scaleW,scale,scale]) EHFingertip(1);
            }
            translate([-.5*fingerSpacing*scaleW,0+explode,-2*scale]) {
                color("yellow") scale([EHscaleW,EHscale,EHscale])  EHProximalPhalange();
                color("green") translate([0,EHproxLen*scale+explode,-1]) rotate([0,0,180]) EHfingerPin(EHscale, EHscaleW);
                color("orange") translate([0,EHproxLen*scale+2*explode,0]) scale([scaleW,scale,scale]) EHFingertip(2);
            }
            translate([.5*fingerSpacing*scaleW,0+explode,-2*scale]) {
                color("yellow") scale([EHscaleW,EHscale,EHscale])  EHProximalPhalange();
                color("green") translate([0,EHproxLen*scale+explode,-1]) rotate([0,0,180]) EHfingerPin(EHscale, EHscaleW);
                color("orange") translate([0,EHproxLen*scale+2*explode,0]) scale([scaleW,scale,scale]) EHFingertip(3);
            }
            translate([1.5*fingerSpacing*scaleW,0+explode,-2*scale]) {
                color("yellow") scale([EHscaleW,EHscale,EHscale])  EHProximalPhalange();
                color("green") translate([0,EHproxLen*scale+explode,-1]) rotate([0,0,180]) EHfingerPin(EHscale, EHscaleW);
                color("orange") translate([0,EHproxLen*scale+2*explode,0]) scale([scaleW,scale,scale]) EHFingertip(2);
            }
        }
        else { // Other hands use the same finger four times
            for (fX = [-1.5:1:1.5]) {
                translate([fX*fingerSpacing*scaleW, explode, 0]) {
                    if (cyborgFingers) {
                        echo(str("cyborg beast fingers scale ",str(scale*100),"% scale width ",scaleW*100,"%."));
                        //sphere(10);
                        //translate(phalangeOffset)
                        if (palmSelect==1) { // Cyborg Beast
                            color("yellow") translate([0,-14*scale,0])
                            scale([CBscaleW,CBscale,CBscale])
                            CyborgProximalPhalange();
                            color("orange") translate([0,9*scale+explode,0])
                            scale([CBscaleW,CBscale,CBscale])
                            CyborgFinger(bump=(fingerSelect==CyborgBeastFingersBump));
                        }
                        if (palmSelect==4) { // Cyborg Beast No Thumb
                            color("yellow") translate([0,-7*scale,0])
                            scale([CBscaleW,CBscale,CBscale])
                            CyborgProximalPhalange();
                            color("orange") translate([0,17*scale+explode,0])
                            scale([CBscaleW,CBscale,CBscale])
                            CyborgFinger(bump=(fingerSelect==CyborgBeastFingersBump));
                        }
                        //color("yellow") translate([0,-14*scale,0]) scale([CBscaleW,CBscale,CBscale]) CyborgProximalPhalange();
                        //translate(fingerOffset)
                        //color("orange") translate([0,17*scale+explode,0])
                        //rotate([0,180,0])
                        //    scale([CBscaleW,CBscale,CBscale]) CyborgFinger(bump=(fingerSelect==CyborgBeastFingersBump));
                    }
                    if (fingerSelect==DavidFingers) {
                        echo("david fingers");
                        translate(davidFingerProximalOffset)
                        scale([scaleW,scale,scale]) DavidFingerProximal();
                        translate(davidFingerDistalOffset) translate([0,+explode,0])
                        scale([scaleW,scale,scale]) rotate([0,180,90]) DavidFingerDistal();
                    }
                    if (fingerSelect==3) {
                        echo(str("Creo beast fingers scale ",scale*100,"% scale W ",scaleW*100,"%."));
                        scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgProximalPhalange();
                        translate([0,29*CCBscale+explode,0]) scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgFinger();
                    }
                    // ADD FINGERS HERE
                }
            }
        }
    }

    // palm
    
    color("orange") {
        if (isCB) {
            echo("SCALE PALM ",CBscaleW,CBscale);
            rotate([1,0,0]) scale([CBscaleW,CBscale,CBscale])
            CyborgLeftPalm(assemble=true, wrist=wristControl,
                           knuckle=knuckleControl, measurements=measurements,
                           label=label, font=font, thumb=haveThumb);
        }

        if (palmSelect == CBParametricPalm) {
            echo("cyborg beast parametric palm");
            CyborgBeastParametricPalm(assemble=true, wrist=wristControl,
                                      knuckle=knuckleControl, measurements=measurements,
                                      label=label, font=font);
        }
        if (palmSelect == 3)
            CreoCyborgLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements,
                               label=label, font=font);
        if (palmSelect == 5)
            EHLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements,
                       label=label, font=font, support=1);
        if (palmSelect == 6)
            EHLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements,
                       label=label, font=font, support=0);
        if (palmSelect == 7)
            EHLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=1, thumb=0);
        if (palmSelect == 8)
            EHLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=0, thumb=0);
        if (palmSelect == 9)
            EHLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=1, thumb=1, mount=1);
        if (palmSelect == 10)
            EHLeftPalm(assemble=true, wrist=wristControl, knuckle=knuckleControl, measurements=measurements, label=label, font=font, support=1, thumb=1, mount=0, demoHand=1);

        // ADD PALMS HERE
    }

    // For the cyborg beast palm the thumb is here:

    thPhalangeLen = thumbPhalangeLen; // from import

    // Draw thumb. Mirror if rendering right hand. Use only for preview, not for compiled parts.
    if (haveThumb) mirror([prostheticHand,0,0]) translate([thumbControl[0]*scaleW+explode,thumbControl[1]*scale,thumbControl[2]*scale]) rotate(thumbRotate) {
        if (fingerSelect==3) {
            color("yellow") scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgThumbPhalange();
            color("orange") translate([0,31*CCBscaleW+2*explode,0])
            scale([CCBscaleW,CCBscale,CCBscale]) CreoCyborgThumbFinger();
        }
        else if (fingerSelect==1) translate([0,1,0]) {
            color("yellow") scale([CBscaleW,CBscale,CBscale]) CyborgThumbPhalange();
            color("orange") translate([0,22*CBscaleW+2*explode,0])
            scale([CBscaleW,CBscale,CBscale]) CyborgThumbFinger();
        }
        else if (fingerSelect==4) {
            color("yellow") scale([EHscale,EHscaleW,EHscaleW]) EHProximalPhalange();
            color("orange") translate([0,EHproxLen*EHscaleW+explode,0])  scale([EHscale,EHscaleW,EHscaleW]) EHFingertip(2);
        }
        else if (fingerSelect==5) {
            color("yellow") scale([EHscale,EHscaleW,EHscaleW]) EHProximalPhalange();
            color("orange") translate([0,EHproxLen*EHscaleW+explode,0])  scale([EHscale,EHscaleW,EHscaleW]) EHFingertip(2);
        }
    }
    /***/
    echo("gauntlet scale ",scaleW);
    if (haveGauntlet) 
        mirror([prostheticHand,0,0])
        color("yellow")
        translate([0,-explode,0]) {
        
        if (gauntletSelect==1)
            scale([scaleW*.7,scale, scale]) translate(gauntletOffset) rotate([0,0,-90]) DavidGauntlet();
        if (gauntletSelect==2)
            scale([scaleW*.7,scale, scale]) KarunaGauntlet(measurements, padding);
        if (gauntletSelect==3)
            scale([scaleW,scale, scale]) EH2Gauntlet(measurements, padding, support=1);
        if (gauntletSelect==4)
            scale([scaleW,scale, scale]) EH2Gauntlet(measurements, padding, support=0);
        if (gauntletSelect==5)
            scale([scaleW,scale, scale]) EH2Gauntlet(measurements, padding, support=1, flare=1);
        if (gauntletSelect==6)
            scale([scaleW,scale, scale]) EH2Gauntlet(measurements, padding, support=0, flare=1);
        if (gauntletSelect==7)
            scale([scaleW,scale, scale]) CyborgGauntlet(thumb=(palmSelect==1));
        // ADD GAUNTLETS HERE
    }

    //%ModelArm(measurements);
    //showControlPoints();
}