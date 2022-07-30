#!/usr/bin/env python

import sys

with open(sys.argv[1], 'rt') as f:
    lines = f.readlines()
lines = [int(x.strip('\n')) for x in lines]


breaks = []
blocks = []
for i, x in enumerate(lines):
    if i == 0:
        pass
    if x - lines[i-1] < 16:
        blocks.append(x)
    else:
        if len(blocks) > 8:
            breaks.append(blocks[0])
        blocks = []

if len(blocks) > 8:
    breaks.append(blocks[0])

for x in breaks:
    print(x)
    


