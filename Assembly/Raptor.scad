//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//
//      Raptor
//
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

module DrawHandRaptor(CBscale, CBscaleW, CCBscale, CCBscaleW, EHscale, EHscaleW, scale, scaleW, explode=0, flare=0, mount=0, gauntlet=1) {
    echo("DrawHandRaptor()");
    echo("raptorGauntletType", raptorGauntletType);

    mirror([prostheticHand, 0, 0])
    translate([0, -explode, 0]) {
        if (raptorGauntletType == RaptorGauntlet)
            DrawRaptorGauntlet();
        else if (raptorGauntletType == RaptorGauntletNoSupports)
            DrawRaptorGauntletNoSupports();
        else if (raptorGauntletType == RaptorGauntletFlared)
            DrawRaptorGauntletFlared();
        else if (raptorGauntletType == RaptorGauntletFlaredNoSupports)
            DrawRaptorGauntletFlaredNoSupports();
    }
}

module DrawRaptorGauntlet() {
    echo("DrawRaptorGauntlet()");

    color("blue")
    scale([scaleW, scale, scale])
    EH2Gauntlet(measurements, padding, support=1, flare=0);

    for(i=[0:1]) {
        DrawRaptorHingePin(i);
        DrawRaptorHingeCap(i);
    }
    DrawRaptorDoveTail();
    DrawRaptorTensioner();
    DrawRaptorPalm();
}

module DrawRaptorGauntletNoSupports() {
    echo("DrawRaptorGauntletNoSupports()");

    color("blue")
    scale([scaleW, scale, scale])
    EH2Gauntlet(measurements, padding, support=0, flare=0);

    for(i=[0:1]) {
        DrawRaptorHingePin(i);
        DrawRaptorHingeCap(i);
    }
    DrawRaptorDoveTail();
    DrawRaptorTensioner();
    DrawRaptorPalm();
}

module DrawRaptorGauntletFlared() {
    echo("DrawRaptorGauntletFlared()");

    color("blue")
    scale([scaleW, scale, scale])
    EH2Gauntlet(measurements, padding, support=1, flare=1);

    for(i=[0:1]) {
        DrawRaptorHingePin(i);
        DrawRaptorHingeCap(i);
    }
    DrawRaptorDoveTail();
    DrawRaptorTensioner();
    DrawRaptorPalm();
}

module DrawRaptorGauntletFlaredNoSupports() {
    echo("DrawRaptorGauntletFlaredNoSupports()");

    color("blue")
    scale([scaleW, scale, scale])
    EH2Gauntlet(measurements, padding, support=0, flare=1);

    for(i=[0:1]) {
        DrawRaptorHingePin(i);
        DrawRaptorHingeCap(i);
    }
    DrawRaptorDoveTail();
    DrawRaptorTensioner();
    DrawRaptorPalm();
}

module DrawRaptorHingePin(i=0) {
    color("white") 
    translate(wristControl) 
    translate([(-19*scaleW)*(i-0.5)*2, 0, -3*scaleW])
    rotate(180-180*i, [0, 0, 1])
    difference()
    {
        EHhingePins(EHscale, EHscaleW);
        
        translate([11, 0, 3])
        cube([20, 10, 10], center=true);
    }
}

module DrawRaptorHingeCap(i=0) {
    color("white") 
    translate(wristControl)
    translate([-28*scaleW*(i-0.5)*2, 0, -8*scaleW]) 
    rotate(180-180*i, [0, 0, 1])
    rotate([0,-90, 0])
    difference()
    {
        EHhingeCaps(EHscale, EHscaleW);
        
        translate([-10, 0, 2.5])
        cube([20, 20, 10], center=true);
    }
}

module DrawRaptorDoveTail() {
    color("red") 
    translate([0,-68*scale, 23.2*EHscale]) 
    rotate([180,0,0])
    EHdovetail(EHscale, EHscaleW, flare=flare);
}

module DrawRaptorTensioner() {
    color("red") 
    translate([0,-56*scale, 25*scale]) 
    rotate([-90,0,0])
    EHtensioner(EHscale, EHscaleW);
    
    for(i=[0:4])
        DrawRaptorHexPin(i);
}

module DrawRaptorHexPin(i=0) {
    color("white")
    translate([0,-40*EHscaleW,25*EHscale])
    EHhexPins(EHscale, EHscaleW);
}

module DrawRaptorPalm() {
    palmColor = "blue";
    
    if (palmSelect == 5)
        color(palmColor)
        EHLeftPalm(assemble=true,  wrist=wristControl, 
            knuckle=knuckleControl, measurements=measurements,
            label=label, font=font, support=1);
    if (palmSelect == 6)
        color(palmColor)
        EHLeftPalm(assemble=true, wrist=wristControl, 
            knuckle=knuckleControl, measurements=measurements,
            label=label, font=font, support=0);
    if (palmSelect == 7)
        color(palmColor)
        EHLeftPalm(assemble=true, wrist=wristControl, 
            knuckle=knuckleControl, measurements=measurements, 
            label=label, font=font, support=1, thumb=0);
    if (palmSelect == 8)
        color(palmColor)
        EHLeftPalm(assemble=true, wrist=wristControl, 
            knuckle=knuckleControl, measurements=measurements, 
            label=label, font=font, support=0, thumb=0);
    if (palmSelect == 9)
        color(palmColor)
        EHLeftPalm(assemble=true, wrist=wristControl, 
            knuckle=knuckleControl, measurements=measurements, 
            label=label, font=font, support=1, thumb=1, mount=1);
    if (palmSelect == 10)
        color(palmColor)
        EHLeftPalm(assemble=true, wrist=wristControl, 
            knuckle=knuckleControl, measurements=measurements, 
            label=label, font=font, support=1, thumb=1, mount=0, 
            demoHand=1);
    
    DrawRaptorKnucklePin();
    DrawRaptorThumbPin();
    echo("EHProximale scale ",[EHscaleW,EHscale,EHscale]);
    for(i=[0:4])
        if (i<4)
            translate(knuckleControl) 
            translate([-fingerSpacing*scaleW*(i-1.55), 0, -2*scale])
            scale([EHscaleW,EHscale,EHscale])
            DrawRaptorProximal(i);
        else
            mirror([prostheticHand,0,0])
            translate([thumbControl[0]*scaleW, 
                thumbControl[1]*scale, 
                thumbControl[2]*scale]) 
            rotate(thumbRotate)     
            scale([EHscaleW,EHscale,EHscale])
            DrawRaptorProximal(i);
}

module DrawRaptorKnucklePin() {
    color("white")
    translate(knuckleControl) 
    translate([0,0,-2*scale]) 
    EHknucklePins(EHscale, EHscaleW);
}

module DrawRaptorThumbPin() {
    mirror([prostheticHand,0,0]) 
    translate([thumbControl[0]*scaleW, 
        thumbControl[1]*scale, 
        thumbControl[2]*scale]) 
    rotate(thumbRotate)
    translate([0, 0, -2.3*scale])
    rotate([0, 0, 180]) 
    color("white") 
    EHthumbPin(EHscale,EHscaleW);
}

module DrawRaptorProximal(i=0) {
    echo("EH fingers spacing ",fingerSpacing, scaleW);
    
    color("white")
    EHProximalPhalange();
    
    DrawRaptorFingerPin();
    DrawRaptorFingerTip();
}

module DrawRaptorFingerPin() {
    translate([0, EHproxLen*scale, -1])
    rotate([0, 0, 180])
    color("white")
    EHfingerPin(EHscale, EHscaleW);
}

module DrawRaptorFingerTip() {
    translate([0, EHproxLen*scale, 0])
    scale([scaleW, scale, scale])
    color("red")
    EHFingertip();
}


