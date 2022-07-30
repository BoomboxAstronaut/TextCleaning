"""
Input a list removal list and a primary list
Remove all input 1 words from input 2
"""
import sys


with open(f'{sys.argv[1]}', 'rt') as f:
    temp1 = set(f.readlines())

with open(f'{sys.argv[2]}', 'rt') as f:
    temp2 = set(f.readlines())

temp2.difference_update(temp1)

with open(f'{sys.argv[2]}_r', 'wt') as f:
    f.writelines(temp2)

