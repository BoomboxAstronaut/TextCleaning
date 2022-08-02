#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

/* 
 * Split a text file into a number of different files
 *
 * ARGS: Filename, # of splits, # of lines in source file 
*/

int out_writer (FILE *inf, FILE *ouf, int total_lines) {
    int ltrack = 0;
    char lbuf[8192];

    while (ltrack < total_lines) {
        fgets(lbuf, 8192, inf);
        fputs(lbuf, ouf);
        ltrack += 1;
    }
    return 0;
}

int main (int argc, char* argv[]) {

    char split[32];
    char lines[32];
    memcpy(split, argv[2], 32);
    memcpy(lines, argv[3], 32);

    while (*argv[2]) {
        if (isdigit(*argv[2]++) == 0) {
            printf("Invalid input for number of splits\n");
            return 1;
        }
    }
    while (*argv[3]) {
        if (isdigit(*argv[3]++) == 0) {
            printf("Invalid input for input line count\n");
            return 1;
        }
    }

    int splits = atoi(split);
    int lcount = atoi(lines);
    int split_point = lcount / splits;
    char outname[128];
    FILE *infile = fopen(argv[1], "r");

    if (infile == NULL) {
        printf("File not found\n");
        return 1;
    }
    if (splits > lcount) {
        printf("File split # greater than input lines\n");
        return 1;
    }
    if (splits == 0 || lcount == 0) {
        printf("Line count and number of splits can not be 0\n");
        return 1;
    }

    for (int i = 0; i < splits; i += 1) {

        sprintf(outname, "%s_%d", argv[1], i+1);
        FILE *outfile = fopen(outname, "w");

        if (i == splits - 1) {
            split_point = split_point + (lcount - (split_point * splits));
        }

        out_writer(infile, outfile, split_point);
        fclose(outfile);
    }

    fclose(infile);
    return 0;
}


