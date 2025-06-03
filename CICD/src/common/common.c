#include "common.h"

#include <stdio.h>
FILE *file_open(char *filename, struct Flags ops) {
  FILE *file = fopen(filename, "r");
  if (file == NULL) {
    if (ops.flag_s == 0) perror("s21");
  }

  return file;
}