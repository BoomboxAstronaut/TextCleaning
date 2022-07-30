import multiprocessing
import sys
from tqdm import tqdm

def parse(sentence):
    tempstr = []
    for y in sentence.split(' '):
        if y not in accepted:
            tempstr.append(y)
    tempstr.append('\n')
    return " ".join(tempstr)

with open(sys.argv[1], 'rt') as f:
    accepted = f.readlines()
accepted = set([x.strip('\n') for x in accepted])

with open(sys.argv[2], "rt") as f:
    corpus = f.readlines()
corpus = set([x.strip('\n') for x in corpus])

with multiprocessing.Pool(processes=6) as p:
    cleaned = list(tqdm(p.imap_unordered(parse, corpus, chunksize=4096), total=len(corpus)))

with open(f'{sys.argv[2]}_f', "wt") as f:
    f.writelines(cleaned)


