#!/usr/bin/python3.9

import collections
import sys


def main():
    assert sys.argv[2] in ['2', '3'], 'Enter 2 or 3 in second argument for colloc width'
    counts = collections.Counter()

    with open(sys.argv[1], 'rt', encoding='utf8') as f:
        if sys.argv[2] == '3':
            while f:
                x = f.readlines(65536)
                if not x:
                    break
                x = [y.lower() for y in x]
                for y in x:
                    y = y.split()
                    if len(y) < 3:
                        continue
                    for i, z in enumerate(y[:-2]):
                        counts[f'{z} {y[i+1]}'] += 1
                        counts[f'{z} {y[i+1]} {y[i+2]}'] += 1

        elif sys.argv[2] == '2':
            while f:
                x = f.readlines(65536)
                if not x:
                    break
                x = [y.lower() for y in x]
                for y in x:
                    y = y.split()
                    if len(y) < 2:
                        continue
                    for i, z in enumerate(y[:-1]):
                        counts[f'{z} {y[i+1]}'] += 1
    
    counts = [f'{x[1]} {x[0]}\n' for x in counts.most_common()[::-1]]
    with open(r'collocs', 'wt', encoding='utf8') as f:
        f.writelines(counts)

if __name__ == '__main__':
    main()
