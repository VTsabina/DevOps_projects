#include "cat_flag.h"

#include <stdio.h>
#include <string.h>

#include "../common/common.h"

void basecat(FILE* file, struct Flags ops) {
  int prev, ch;
  int line = 1;
  int empty_line_counter = 0;

  if ((ops.flag_b == 1) && (ops.flag_n == 1)) ops.flag_n = 0;

  for (prev = '\n'; (ch = fgetc(file)) != EOF; prev = ch) {
    if ((ops.flag_b == 1) && (prev == '\n')) {
      if (ch != '\n') {
        printf("%6d\t", line);
        line++;
      }
    }

    if ((ops.flag_s == 1) && (prev == '\n')) {
      if (ch == '\n')
        empty_line_counter++;
      else
        empty_line_counter = 0;
    }

    if ((ops.flag_n == 1) && (prev == '\n')) {
      if (ops.flag_s == 1) {
        if ((empty_line_counter <= 1)) {
          printf("%6d\t", line);
          line++;
        }
      } else {
        printf("%6d\t", line);
        line++;
      }
    }

    if (ops.flag_v == 1) {
      if ((ch != 9) && (ch != '\n')) {
        if ((ch >= 0) && (ch <= 31)) {
          printf("^");
          ch += 64;
        } else if ((ch >= 127) && (ch <= 159)) {
          if (ch > 127) {
            printf("^");
            ch -= 128;
          } else if (ch == 127) {
            printf("^");
            ch -= 64;
          }
        }
      }
    }

    if ((ops.flag_e == 1) && (ch == '\n') && (empty_line_counter <= 1))
      printf("$");

    if ((ops.flag_tab == 1) && (ch == '\t'))
      printf("^I");

    else if (empty_line_counter <= 1)
      printf("%c", ch);
  }
}