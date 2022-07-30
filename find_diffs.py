"""
Find the differences in 2 inputs and create 3 files
inboth: words found in both
in1o: words found in 1 only
in2o: words found in 2 only
"""

import sys

with open(sys.argv[1], 'rt') as f:
    temp1 = f.readlines()
temp1 = set([x.strip('\n') for x in temp1])

with open(sys.argv[2], 'rt') as f:
    temp2 = f.readlines()
temp2 = set([x.strip('\n') for x in temp2])

temp3 = []
temp4 = []
temp5 = []

if len(sys.argv) > 3 and sys.argv[3] == 'c':
    temp2d = {x.split(' ')[1]: x.split(' ')[0] for x in temp2}
    temp2 = {x.split(' ')[1] for x in temp2}

for x in temp1:
    if x in temp2:
        #In both
        temp3.append(f"{x}\n")
    else:
        #In 1 but not 2
        temp4.append(f"{x}\n")

for x in temp2:
    if x not in temp1:
        #In 2 but not 1
        temp5.append(f"{x}\n")

if len(sys.argv) > 3 and sys.argv[3] == 'c':
    temp3 = [x.strip('\n') for x in temp3]
    temp3 = [f'{temp2d[x]} {x}\n' for x in temp3]
    temp5 = [x.strip('\n') for x in temp5]
    temp5 = [f'{temp2d[x]} {x}\n' for x in temp5]

with open(f'inboth', 'wt') as f:
    f.writelines(temp3)

with open("in1o", "wt") as f:
    f.writelines(temp4)

with open(f'in2o', 'wt') as f:
    f.writelines(temp5)

