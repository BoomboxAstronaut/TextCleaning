import collections
import sys



with open(sys.argv[1], 'rt') as fin:
    with open(sys.argv[2], 'wt') as fout:
        saved = []
        max_count = 0
        for x in fin:
            line = x.strip('\n')
            saved.extend(line)
            counts = collections.Counter(saved)
            if counts['{'] == counts['}'] or line == 'AWKRECORDBREAK' or max_count > 256:
                saved.append('\n')
                fout.writelines("".join(saved))
                saved.clear()
                max_count = 0
            else:
                max_count += 1
                continue



