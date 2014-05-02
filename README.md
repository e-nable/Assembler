e-NABLE
=======

repository for OpenSCAD scripts (and referenced STL files) for e-NABLE project

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

Palm Style
- 1 Cyborg Beast
- 2 Cyborg Beast Parametric

Example
======
openscad -o preview.png -D Left1=66.47 -D Left2=64.04 -D  Left3=46.95 -D  Left4=35.14 -D  Left5=35.97 -D  Left6=27.27 -D  Left7=31.80 -D  Left8=40.97 -D  Left9=31.06 -D  Left10=147.5 -D Right1=62.67 -D Right2=65.62 -D  Right3=59.14 -D  Right4=48.78 -D  Right5=51.85 -D  Right6=16.4 -D  Right7=0 -D  Right8=72.52 -D  Right9=72.23 -D  Right10=230.6  -D part=0 -D fingerSelect=1 -D palmSelect=2 -D WristBolt=5.5 -D KnuckleBolt=3.3 -D JointBolt=3.3 -D ThumbBolt=3.3   e-NABLE/Assembly/Assembly.scad

Prerequisites
=========
OpenScad as ran on command line.

On a 'headless' server, you may need to set up a virtual container for the program to render into.

Xvfb :5 -screen 0 800x600x24 &
export DISPLAY=:5
