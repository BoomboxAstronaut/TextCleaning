#!/usr/bin/env python
import collections
import sys

with open(sys.argv[1], 'rt') as f:
    temp = f.readlines()
temp = [x.strip('\n') for x in temp]

counts = collections.Counter(temp)
del temp

counts = sorted([(x[0], x[1]) for x in counts.items()], key=lambda x: x[1])
for x in counts:
    print(f'{x[1]} {x[0]}')

