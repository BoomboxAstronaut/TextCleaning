#!/usr/bin/python3.9

import sys
import re

def main():
    wdct = {}
    n_corpus = 2140768671
    rex = re.compile(f'(?<= ){sys.argv[1]}(?= |$)')

    with open('wcounts', 'rt', encoding='utf8') as f:
        infile = f.readlines()
        for x in infile:
            x = x.split()
            wdct[x[1]] = int(x[0])

    with open('collocs1', 'rt', encoding='utf8') as f:
        collocs = f.readlines()

    def calc_p_colloc(occs: int, w1: str, w2: str) -> float:
        try:
            mu = (wdct[w1] / n_corpus) * (wdct[w2] / n_corpus)
        except IndexError:
            return 0
        colloc_mean = occs / n_corpus
        return (colloc_mean - mu) / ((((1 - colloc_mean) * colloc_mean) / n_corpus) ** 0.5)

    def get_sig_collocs(word: str) -> None:
        rex = re.compile(f'(?<= ){word}(?= |$)')
        match_targets = [x for x in collocs if re.search(rex, x)]
        for x in match_targets:
            x = x.lower().split()
            pval = calc_p_colloc(int(x[0]), x[1], x[2])
            if pval > 100:
                print(f"{' '.join(x)} {int(pval)}")

    while True:
        print('Word?')
        inp = input()
        get_sig_collocs(inp)


if __name__ == '__main__':
    main()

