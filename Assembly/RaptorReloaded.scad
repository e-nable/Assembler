//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//
//      Raptor Reloaded
//
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
// 
// unused STL files
// 
// raptor_reloaded_right_palm.stl
// raptor_reloaded_right_palm_support.stl
//
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

//DrawHandRaptorReloaded();

module DrawHandRaptorReloaded(CBscale, CBscaleW, CCBscale, CCBscaleW, EHscale, EHscaleW, scale, scaleW, explode=0, flare=0, mount=0, gauntlet=1) {
    echo("DrawHandRaptor()");
    echo("raptorGauntletType", raptorGauntletType);

    mirror([prostheticHand, 0, 0])
        DrawRaptorReloadedGauntlet();
}

module DrawRaptorReloadedGauntlet() {
    echo("DrawRaptorGauntlet()");

    color("blue")
    scale([scaleW, scale, scale])
    union()
    {
        import("../RaptorReloaded/raptor_reloaded_gauntlet.stl");
        if (gauntletSupport)
            import("../RaptorReloaded/raptor_reloaded_gauntlet_support.stl");
    }
    
    for(i=[0:1]) {
        DrawRaptorReloadedHingePin(i);
        DrawRaptorReloadedHingeCap(i);
    }
    DrawRaptorReloadedRetentionClip();
    DrawRaptorReloadedTensioner();
    DrawRaptorReloadedPalm();
}

module DrawRaptorReloadedHingePin(i=0) {
    translate(wristControl) 
    scale([scaleW, scale, scale])
    rotate(180*i, [0, 0, 1])
    color("white") 
    import("../RaptorReloaded/raptor_reloaded_wrist_pin.stl");
}

module DrawRaptorReloadedHingeCap(i=0) {
    translate(wristControl)
    scale([scaleW, scale, scale])
    rotate(180*i, [0, 0, 1])
    color("white") 
    import("../RaptorReloaded/raptor_reloaded_wrist_pin_cap.stl");
}

module DrawRaptorReloadedRetentionClip() {
    color("red")
    scale([scaleW, scale, scale])
    import("../RaptorReloaded/raptor_reloaded_retention_clip.stl");
}

module DrawRaptorReloadedTensioner() {
    color("red") 
    scale([scaleW, scale, scale])
    import("../RaptorReloaded/raptor_reloaded_tensioner.stl");
    
    for(i=[0:4])
        DrawRaptorReloadedTensionerPin(i);
}

module DrawRaptorReloadedTensionerPin(i=0) {
    translate([-i*6*scaleW, 10, 0])
    scale([scaleW, scale, scale])
    color("white")
    import("../RaptorReloaded/raptor_reloaded_tensioner_pin.stl");
}

module DrawRaptorReloadedPalm() {
    mirror([prostheticHand,0,0])
    scale([scaleW, scale, scale])
    color("blue")
    union()
    {
        import("../RaptorReloaded/raptor_reloaded_left_palm.stl");
        if (palmSupport)
            import("../RaptorReloaded/raptor_reloaded_left_palm_support.stl");
    }
    
    for (i=[0:1])
        DrawRaptorReloadedKnucklePin(i);
    DrawRaptorReloadedThumbPin();

    scale([scaleW, scale, scale])
    for(i=[0:4])
        if (i<4)
            translate(knuckleControl) 
            translate([-fingerSpacing*scaleW*(i-1.55)*0.6, -19*scale, -2*scale])
            DrawRaptorReloadedProximal(i);
        else
            mirror([prostheticHand,0,0])
            translate([30*scaleW, 30*scale, 0*scale]) 
            rotate(thumbRotate)
            DrawRaptorReloadedProximal(i);
}

module DrawRaptorReloadedKnucklePin(i=0) {
    translate(knuckleControl) 
    translate([-i*0*scaleW, 62*i+84*(i-1)*scale, 0*scale]) 
    scale([scaleW, scale, scale])
    rotate(180*i, [0, 0, 1])
    color("white")
    import("../RaptorReloaded/raptor_reloaded_knuckle_pin.stl");
}

module DrawRaptorReloadedThumbPin() {
    mirror([prostheticHand, 0, 0]) 
    scale([scaleW, scale, scale])
    rotate(-13, [0, 1, 0])
    rotate(90, [0, 0, 1])
    rotate(thumbRotate)
    color("white") 
    import("../RaptorReloaded/raptor_reloaded_thumb_pin.stl");
}

module DrawRaptorReloadedProximal(i=0) {
    color("white")
    import("../RaptorReloaded/raptor_2.0_proximal.stl");
    
    DrawRaptorReloadedFingerPin();
    DrawRaptorReloadedFingerTip();
}

module DrawRaptorReloadedFingerPin() {
    translate([0, 22.5, -1.5])
    rotate(90, [0, 0, 1])
    color("white")
    import("../RaptorReloaded/raptor_2.0_finger_pin.stl");
}

module DrawRaptorReloadedFingerTip() {
    translate([0, 22.5, 0])
    rotate(180, [0, 1, 0])
    color("red")
    import("../RaptorReloaded/raptor_2.0_fingertip.stl");
}
