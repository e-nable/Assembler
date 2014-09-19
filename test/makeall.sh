#!/bin/sh

# three parameters, integers: gauntlet, fingers, and palm.
# then one list of all other OpenSCAD command options, like this:

# ./makeall.sh "-D Left1=0 -D Left2=0 -D  Left3=0 -D  Left4=0 -D  Left5=0 -D  Left6=0 -D  Left7=0 -D  Left8=0 -D  Left9=0 -D  Left10=0 -D Right1=0 -D Right2=0 -D  Right3=0 -D  Right4=0 -D  Right5=55 -D  Right6=0 -D  Right7=0 -D  Right8=55 -D  Right9=71 -D  Right10=0 -D prostheticHand=0 -D gauntletSelect=1 -D fingerSelect=1 -D palmSelect=1 -D Padding=5 -D WristBolt=0 -D KnuckleBolt=0 -D JointBolt=0 -D ThumbBolt=0"

# pipe output to a log file if you want

o = $1

# loop parts

for p in $(seq 1 10); do

      echo "Generate part ${p}"
      date
      echo

     /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o part-${p}.stl ${o} -D part=${p} /Users/laird/src/e-NABLE-Assembler/Assembly/Assembly.scad

   echo

done