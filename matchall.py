
import sys

with open(sys.argv[1], 'rt') as f:
    one = f.readlines()
one = set([x.strip('\n') for x in one])


with open(sys.argv[2], 'rt') as f:
    two = f.readlines()
two = set([x.strip('\n') for x in two])


with open(sys.argv[3], 'rt') as f:
    three = f.readlines()
three = set([x.strip('\n') for x in three])

temp = []

for x in one:
    if x in two:
        if x in three:
            temp.append(f'{x}\n')

with open("matched", 'wt') as f:
    f.writelines(temp)

















