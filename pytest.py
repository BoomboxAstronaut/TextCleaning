#!/usr/bin/env python3

import sys

with open(sys.argv[1], 'rt') as f:
    nums = f.readlines()
    nums = [int(x.strip('\n')) for x in nums]

results = []
for i, x in enumerate(nums[:-1]):
    if nums[i+1] - x < 128:
        results.append(f'{x}\n')

with open('pyresults.txt', 'wt') as f:
    f.writelines(results)

