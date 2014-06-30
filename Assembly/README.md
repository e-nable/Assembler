e-NABLE : Assembly
==================

Command line tool that assembles parts from individual designs.

For STL files, it loads a component wrapper (in this directory) that loads the STL and performs required scaling,
translation, etc., to fit the component into the assembly. See CyborgLeftPalm.scad for an example.

For parametric designs, it loads the design as an <import> followed by calling the module that renders the part. See ../Cyborg_Beast/OpenSCAD Files/cyborgbeast07e.scad as an example.

Currently integrated designs are:

- Assembler source is https://github.com/e-nable/e-NABLE-Assembler
- Cyborg Beast http://www.thingiverse.com/thing:261462 by JorgeZuniga, verson 1.4 by Marc Petrykowski 
- Creo version of Cyborg Beast http://www.thingiverse.com/thing:340750 by Ryan Dailey
- Parametric Gauntlet from http://www.thingiverse.com/thing:270259 by David Orgeman
- Cyborg Beast Short Gauntlet (Karuna's Gauntlet) http://www.thingiverse.com/thing:270322 by Frankie Flood 
- Parametric Finger v2  http://www.thingiverse.com/thing:257544 by David Orgeman
