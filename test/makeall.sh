#!/bin/sh

# three parameters, integers: gauntlet, fingers, and palm.
# then one list of all other OpenSCAD command options

o = $1

# loop parts

for p in $(seq 1 6); do

      echo "Generate part ${p}"
      date
      echo
      echo

     /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o part-${p}.stl ${o} -D part=${p} /Users/laird/src/e-NABLE-Assembler/Assembly/Assembly.scad

   echo

done