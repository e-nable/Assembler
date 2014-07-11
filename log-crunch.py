#!/usr/bin/python

# reads log.txt, extracts parmeters, and writes to CSV file out.txt

import re

log = open("log.txt", "r")
out = open("out.txt", "w")

for line in log:
   if re.match("(.*)openscad(.*)", line):
      if line[0] == ' ':
         line = 'Z'+line;
      line = line.replace('  ',' ') # compress spaces
      line = line.replace('  ',' ') # compress spaces again
      line = line.replace(': ',' ') # strip trailing colon
      line = line.replace(' -D ',' ') # strip -D
      line = line.replace(' -o ',' ') # strip -o
      line = line.replace('echo " ','') # strip echo prefix/suffix
      line = line.replace('" \| batch','')
      line = line.replace('| batch','')
      line = line.replace('e-NABLE/Assembly/Assembly.scad','')
      line = line.replace('openscad','')
      line = line.strip()
      line = line.replace('  ',' ') # compress spaces (from where we removed a few things)
      line = line.replace('  ',' ') # compress spaces again
      line = line.replace(' ',',') # now make CSV
      line = line.replace('=',',') # now make CSV
      
      print line
      out.write(line)

log.close()
out.close()
