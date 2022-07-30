#!/usr/bin/python3.9

import collections
import sys

counts = collections.Counter()

with open(sys.argv[1], 'rt', encoding='utf8') as f:
    infile = f.readlines()

for x in infile:
    counts.update(x.lower().split())

format_counts = [f'{x[1]} {x[0]}\n' for x in counts.most_common()[::-1]]

with open('wcounts', 'wt', encoding='utf8') as f:
    f.writelines(format_counts)


