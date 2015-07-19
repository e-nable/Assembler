//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//
//      Cyborg Beast
//
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

module DrawHandCyborgBeast(CBscale, CBscaleW, CCBscale, CCBscaleW, EHscale, EHscaleW, scale, scaleW, explode=0, flare=0, mount=0, gauntlet=1) {
    if (cyborgBeastGauntletType == CyborgBeastGauntlet)
        DrawCyborgBeastGauntlet();
    else if (cyborgBeastGauntletType == CyborgBeastGauntletThumbless)
        DrawCyborgBeastGauntletThumbless();
    else if (cyborgBeastGauntletType == CyborgBeastGauntletParametric)
        DrawCyborgBeastGauntletKaruna();
    else if (cyborgBeastGauntletType == CyborgBeastGauntletKaruna)
        DrawCyborgBeastGauntletKaruna();

}

module DrawCyborgBeastGauntlet() {
    mirror([prostheticHand,0,0])
    color("blue")
    scale([scaleW,scale, scale])
    CyborgGauntlet(thumb=1);
    
    for (i=[0:1]) {
        DrawCyborgBeastCap(i);
        DrawCyborgBeastWristPin(i);
    }
    DrawCyborgBeastPalm();
}

module DrawCyborgBeastGauntletThumbless() {
    mirror([prostheticHand,0,0])
    color("blue")
    scale([scaleW,scale, scale])
    CyborgGauntlet(thumb=0);
    
    DrawCyborgBeastCap(0);
    DrawCyborgBeastWristPin(0);
    DrawCyborgBeastPalm();
}

module DrawCyborgBeastGauntletKaruna() {
    mirror([prostheticHand,0,0])
    color("blue")
    translate([0,-explode,0])
    scale([scaleW*.7,scale, scale])
    KarunaGauntlet(measurements, padding);

    for (i=[0:1]) {
        DrawCyborgBeastCap(i);
        DrawCyborgBeastWristPin(i);
    }
    DrawCyborgBeastPalmThumbless();
}

module DrawCyborgBeastGauntletParametric() {
    scale([scaleW*.7,scale, scale]) 
    translate(gauntletOffset) 
    rotate([0,0,-90]) 
    color("blue")
    DavidGauntlet();
    
    for (i=[0:1]) {
        DrawCyborgBeastCap(i);
        DrawCyborgBeastWristPin(i);
    }
    DrawCyborgBeastPalm();
}
    
module DrawCyborgBeastCap(i=0) {
    color("green") 
    translate(wristControl) 
    translate([-32*scaleW-0.5*explode,0,-7*scaleW]) 
    rotate([0,-90,0])
    EHhingeCaps(EHscale, EHscaleW);
}

module DrawCyborgBeastWristPin(i=0) {
    color("green") 
    translate(wristControl) 
    translate([-21*scaleW+explode,0,-3*scaleW])
    EHhingePins(EHscale, EHscaleW);
}

module DrawCyborgBeastTensioner() {    
    color("red") 
    translate([0,-56*scale-4*explode, 25*scale]) 
    rotate([-90,0,0])
    EHtensioner(EHscale, EHscaleW);
}

module DrawCyborgBeastDovetail() {    
    color("orange") 
    translate([0,-68*scale-4.5*explode,23.2*EHscale]) 
    rotate([180,0,0])
    EHdovetail(EHscale, EHscaleW, flare=flare);
}

module DrawCyborgBeastHexPins() {    
    color("green")
    translate([0,-40*EHscaleW+1.5*explode,24*EHscale])
    EHhexPins(EHscale, EHscaleW);
}

module DrawCyborgBeastPalm() {
    DrawCyborgBeastThumbPin();
    for(i=[0:1])
        DrawCyborgBeastKnucklePin(i);
    for(i=[0:4])
        DrawCyborgBeastPhlange(i);
}

module DrawCyborgBeastPalmThumbless() {
    for(i=[0:3])
        DrawCyborgBeastPhlange(i);
}

module DrawCyborgBeastThumbPin() {
}

module DrawCyborgBeastKnucklePin(i=0) {
}

module DrawCyborgBeastPhlange(i=0) {
    color("yellow")
    translate([0,-14*scale,0])
    scale([CBscaleW,CBscale,CBscale])
    CyborgProximalPhalange();

    DrawCyborgBeastFingerPin();
    if (cyborgBeastFingerType == CyborgBeastFinger)
        DrawCyborgBeastFinger();
    else if (cyborgBeastFingerType == CyborgBeastFingerBump() )
        DrawCyborgBeastFingerBump();
    else if (cyborgBeastFingerType == CyborgBeastFingerDavid() )
        DrawCyborgBeastFingerDavid();
}

module DrawCyborgBeastFingerPin() {
}

module DrawCyborgBeastFinger() {
    echo(str("Creo beast fingers scale ",scale*100,"% scale W ",scaleW*100,"%."));
    translate([0,29*CCBscale+explode,0])
    scale([CCBscaleW,CCBscale,CCBscale])
    CreoCyborgFinger();
}

module DrawCyborgBeastFingerBump() {
    color("orange")
    translate([0,9*scale+explode,0])
    scale([CBscaleW,CBscale,CBscale])
    CyborgFinger(bump=(fingerSelect==CyborgBeastFingersBump));
}

module DrawCyborgBeastFingerDavid() {
    echo("david fingers");
    translate(davidFingerProximalOffset)
    scale([scaleW,scale,scale]) DavidFingerProximal();
    translate(davidFingerDistalOffset) translate([0,+explode,0])
    scale([scaleW,scale,scale]) rotate([0,180,90]) DavidFingerDistal();
}
