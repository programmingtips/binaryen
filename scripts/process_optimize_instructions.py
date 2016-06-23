#!/usr/bin/python

import os, sys

root = os.path.dirname(os.path.dirname(__file__))

infile  = os.path.join(root, 'src', 'passes', 'OptimizeInstructions.wast')
outfile = os.path.join(root, 'src', 'passes', 'OptimizeInstructions.wast.processed')

out = open(outfile, 'w')

for line in open(infile):
  out.write('"' + line.strip() + '"\n')

out.close()

