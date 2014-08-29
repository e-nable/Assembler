#!/bin/sh

# loop parts

for p in $(seq 1 6); do

# loop gauntlets

for g in $(seq 1 2); do

# loop finger designs

for f in $(seq 1 2); do

# loop palm selection

for a in $(seq 1 4); do

   # skip palm 2

   if test "${a}" != "2";  then

   # loop left/right hand

   for h in $(seq 0 1); do

      echo "Test hand ${h} palm ${a} finger ${f} gauntlet ${g} part ${p}"
      date
      echo
      echo

     /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o part-h${h}-a${a}-f${f}-g${g}-${p}.stl -D Left1=0 -D Left2=0 -D  Left3=0 -D  Left4=0 -D  Left5=0 -D  Left6=0 -D  Left7=0 -D  Left8=0 -D  Left9=0 -D  Left10=0 -D Right1=0 -D Right2=0 -D  Right3=0 -D  Right4=0 -D  Right5=55 -D  Right6=0 -D  Right7=0 -D  Right8=55 -D  Right9=71 -D  Right10=0 -D prostheticHand=${h} -D gauntletSelect=${g} -D fingerSelect=${f} -D palmSelect=${a} -D Padding=5 -D WristBolt=0 -D KnuckleBolt=0 -D JointBolt=0 -D ThumbBolt=0 -Dpart=${p} /Users/laird/src/e-NABLE-Assembler/Assembly/Assembly.scad
   echo

   done

   fi

done

done

done

done