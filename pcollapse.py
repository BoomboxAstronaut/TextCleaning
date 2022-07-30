#!/sbin/env python
import collections
import sys

with open(sys.argv[1], 'rt') as fin:
    with open(sys.argv[2], 'wt') as fout:
        lc = 0
        rc = 0
        for x in fin:
            counts = collections.Counter(x)
            lc += counts['{']
            rc += counts['}']
            if lc == rc:
                lc = 0
                rc = 0
                fout.write(x)
            elif x == 'AWKRECORDBREAK\n':
                lc = 0
                rc = 0
                fout.write('\n' + x)
            else:
                fout.write(x.strip('\n') + ' ')

