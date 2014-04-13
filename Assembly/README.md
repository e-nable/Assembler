e-NABLE : Assembly
==================

Command line tool that assembles parts from individual designs.

For STL files, it loads a component wrapper (in this directory) that loads the STL and performs required scaling,
translation, etc., to fit the component into the assembly. See CyborgLeftPalm.scad for an example.

For parametric designs, it loads the design as an <import> followed by calling the module that renders the part. See ../Cyborg_Beast/OpenSCAD Files/cyborgbeast07e.scad as an example.
