#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../common/common.h"
#include "grep_flag.h"

int main(int argc, char *argv[]) {
  int filecounter = 0;
  struct Flags ops = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  int rez = 0;
  char **pattern = NULL;
  int pattern_counter = 0;
  optind = 1;
  int inx = 0;
  while ((rez = getopt_long(argc, argv, "e:ivclnhsf:o", NULL, &inx)) != -1) {
    switch (rez) {
      case 'e':
        pattern = realloc(pattern, sizeof(char *) * (pattern_counter + 1));
        pattern[pattern_counter++] = strdup(optarg);
        ops.flag_e = 1;
        break;
      case 'i':
        ops.flag_i = 1;
        break;
      case 'v':
        ops.flag_v = 1;
        break;
      case 'c':
        ops.flag_c = 1;
        break;
      case 'l':
        ops.flag_l = 1;
        break;
      case 'n':
        ops.flag_n = 1;
        break;
      case 'h':
        ops.flag_h = 1;
        break;
      case 's':
        ops.flag_s = 1;
        break;
      case 'f':
        ops.flag_f = 1;
        char *f_line = NULL;
        size_t f_len = 0;
        FILE *new_pattern = file_open(optarg, ops);
        if (new_pattern != NULL) {
          while ((getline(&f_line, &f_len, new_pattern)) != -1) {
            f_line[strcspn(f_line, "\n")] = 0;
            pattern = realloc(pattern, sizeof(char *) * (pattern_counter + 1));
            pattern[pattern_counter++] = strdup(f_line);
          }
          fclose(new_pattern);
        }
        free(f_line);
        break;
      case 'o':
        ops.flag_o = 1;
        break;
    }
  }
  if ((pattern_counter == 0) && (optind != argc)) {
    pattern = realloc(pattern, sizeof(char *) * (pattern_counter + 1));
    pattern[pattern_counter++] = strdup(argv[optind]);
    optind++;
  }

  for (int i = optind; i < argc; i++) {
    filecounter++;
  }
  for (int i = optind; i < argc; i++) {
    char *filename = argv[i];

    FILE *file = file_open(filename, ops);
    if (file != NULL) {
      basegrep(file, ops, pattern, filename, filecounter, pattern_counter);
      fclose(file);
    }
  }

  for (int i = 0; i < pattern_counter; i++) {
    free(pattern[i]);
  }
  free(pattern);
  return 0;
}