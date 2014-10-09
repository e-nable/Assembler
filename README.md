e-NABLE Assembler (AKA Hand-o-Matic)
=======

repository for OpenSCAD scripts (and referenced STL files) for e-NABLE Assembler project

Overall control flow is:

<img src="https://docs.google.com/drawings/d/1fMVuwL2IDA7K7xmZVibVewTpJstXPqoUx9exW6ODkQM/pub?w=960&amp;h=720">

This repository contains the Assembly.scad and it's dependencies, such as the STL files for all of the e-NABLE designs. These include:

- Assembly assembles parts from individual designs (below)
- Cyborg_Beast
- Parametric_Gauntlet
- Parametric Tensioner
- Parametric Knuckle Block
- David Finger
- Talon (placeholder)

Parameters
========
part
- 0 Assembled Model
- 1 Gauntlet
- 2 Palm
- 3 Finger Proximal (Near knuckle)
- 4 Finger Distal (Fingertip)
- 5 Thumb Proximal (Near knuckle)
- 6 Thumb Distal (Thumbtip)

Finger Style
- 1 Cyborg Beast
- 2 David
- 3 Creo Cyborg Beast

Palm Style
- 1 Cyborg Beast
- 2 Cyborg Beast Parametric
- 3 Creo Cyborg Beast

Example
======
openscad -o preview.png -D Left1=66.47 -D Left2=64.04 -D  Left3=46.95 -D  Left4=35.14 -D  Left5=35.97 -D  Left6=27.27 -D  Left7=31.80 -D  Left8=40.97 -D  Left9=31.06 -D  Left10=147.5 -D Right1=62.67 -D Right2=65.62 -D  Right3=59.14 -D  Right4=48.78 -D  Right5=51.85 -D  Right6=16.4 -D  Right7=0 -D  Right8=72.52 -D  Right9=72.23 -D  Right10=230.6  -D part=0 -D fingerSelect=1 -D palmSelect=2 -D WristBolt=5.5 -D KnuckleBolt=3.3 -D JointBolt=3.3 -D ThumbBolt=3.3   e-NABLE/Assembly/Assembly.scad

Prerequisites
=========
OpenScad as ran on command line. Download from openscad.org

On a 'headless' server, you may need to set up a virtual container for the program to render into. The code below is to be ran on the command line before you run the comand line openscad. It may not work on your server. A google search found this example, your system may need something else.

Xvfb :5 -screen 0 800x600x24 &
export DISPLAY=:5

See Also
=========
The e-NABLE Assembler is utilized by the e-NABLE Service Station (AKA Hand-o-Matic) at https://github.com/e-nable/Service-Station .
