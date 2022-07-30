#!/usr/bin/python3.9

import collections
import sys

def main():
    count = 0
    with open(sys.argv[1], 'rt', encoding='utf8') as f:
        infile = f.readlines()
        for x in infile:
            count += len(x.split())
    print(count)

if __name__ == '__main__':
    main()

