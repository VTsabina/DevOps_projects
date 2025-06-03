#include <getopt.h>
#include <stdio.h>
#include <string.h>

#include "../common/common.h"
#include "cat_flag.h"

int main(int argc, char* argv[]) {
  int name = 0;
  struct Flags ops = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

  for (int i = 0; i < argc; i++) {
    if (strcmp(argv[i], "--number-nonblank") == 0)
      argv[i] = "-b";
    else if (strcmp(argv[i], "--number") == 0)
      argv[i] = "-n";
    else if (strcmp(argv[i], "--squeeze-blank") == 0)
      argv[i] = "-s";
  }

  int rez = 0;

  while ((rez = getopt(argc, argv, "bnsveEtT")) != -1) {
    switch (rez) {
      case 'b':
        ops.flag_b = 1;
        break;
      case 'n':
        ops.flag_n = 1;
        break;
      case 's':
        ops.flag_s = 1;
        break;
      case 'v':
        ops.flag_v = 1;
        break;
      case 'e':
        ops.flag_e = ops.flag_v = 1;
        break;
      case 'E':
        ops.flag_e = 1;
        break;
      case 't':
        ops.flag_tab = ops.flag_v = 1;
        break;
      case 'T':
        ops.flag_tab = 1;
        break;
    }
  }
  for (int i = optind; i < argc; i++) {
    if ((name = getopt(argc, argv, "bnsevEtT")) == -1) {
      char* filename = argv[i];

      FILE* file = file_open(filename, ops);
      if (file != NULL) {
        basecat(file, ops);
        fclose(file);
      }
    }
  }
  return 0;
}