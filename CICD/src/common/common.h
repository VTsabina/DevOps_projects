#ifndef COMMON_H
#define COMMON_H
#include <stdio.h>

struct Flags {
  int flag_b;
  int flag_tab;
  int flag_e;
  int flag_i;
  int flag_v;
  int flag_c;
  int flag_l;
  int flag_n;
  int flag_h;
  int flag_s;
  int flag_f;
  int flag_o;
};

FILE* file_open(char* filename, struct Flags ops);

#endif