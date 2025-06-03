#include "grep_flag.h"

#include <regex.h>
#include <stdio.h>
#include <stdlib.h>

#include "../common/common.h"

void basegrep(FILE *file, struct Flags ops, char **pattern, char *filename,
              int filecounter, int pattern_counter) {
  regex_t expr;
  char *line = NULL;
  size_t len = 0;
  int get = 0;
  int rez;
  int linecounter = 0;
  int counter = 0;
  int match = 0;
  int printed_line;

  while ((get = getline(&line, &len, file)) != -1) {
    printed_line = 0;
    int v_check = 0;
    int counted = 0;

    if (ops.flag_n == 1) {
      linecounter++;
    }
    for (int i = 0; i < pattern_counter; i++) {
      rez = make_pattern(&expr, pattern[i], line, ops);
      if (ops.flag_v == 0) {
        if (rez == 0) {
          if (ops.flag_l == 1)
            match = 1;
          else {
            if (counted == 0) {
              counter++;
              counted = 1;
            }
            cflagcheck(filecounter, ops, filename, linecounter, line, get,
                       &printed_line, v_check, expr);
          }
        }
      } else {
        if (rez == 1) {
          if (ops.flag_l == 1)
            match = 1;
          else {
            v_check = v_check_func(line, pattern, pattern_counter, ops);
            if ((v_check == 0) && (counted == 0)) {
              counter++;
              counted = 1;
            }
            cflagcheck(filecounter, ops, filename, linecounter, line, get,
                       &printed_line, v_check, expr);
          }
        }
      }
      regfree(&expr);
    }
  }

  if (ops.flag_c == 1) {
    printname(filecounter, ops, filename);
    if (filecounter > 1) {
      if (ops.flag_l == 1)
        printf("%d\n", match);
      else
        printf("%d\n", counter);
    } else {
      if (ops.flag_l == 1)
        printf("%d\n", match);
      else
        printf("%d\n", counter);
    }
  }

  if (match == 1) {
    printf("%s\n", filename);
  }

  free(line);
}

int make_pattern(regex_t *expr, char *pattern, char *line, struct Flags ops) {
  int rez;
  if (ops.flag_i == 1)
    rez = regcomp(expr, pattern, REG_ICASE);
  else
    rez = regcomp(expr, pattern, 0);

  rez = regexec(expr, line, 0, 0, 0);

  return rez;
}

void cflagcheck(int filecounter, struct Flags ops, char *filename,
                int linecounter, char *line, int get, int *printed_line,
                int v_check, regex_t expr) {
  if (ops.flag_c == 0) {
    if ((*printed_line == 0) && (v_check == 0)) {
      printname(filecounter, ops, filename);
      if ((ops.flag_n == 1) && (v_check == 0)) printf("%d:", linecounter);
      if ((ops.flag_o == 1) && (ops.flag_v == 0)) {
        regmatch_t pmatch[1];
        int col = 0;
        char *ptr = line;
        while ((col = regexec(&expr, ptr, 1, pmatch, 0)) == 0) {
          for (int i = pmatch->rm_so; i < pmatch->rm_eo; i++) {
            printf("%c", ptr[i]);
          }
          printf("\n");
          ptr += pmatch[0].rm_eo;
        }
      } else if (v_check == 0) {
        for (int i = 0; i < get; i++) {
          printf("%c", line[i]);
        }
        if (line[get - 1] != '\n') printf("\n");
      }
      *printed_line = 1;
    }
  }
}

void printname(int filecounter, struct Flags ops, char *filename) {
  if ((filecounter > 1) && (ops.flag_h == 0)) printf("%s:", filename);
}

int v_check_func(char *line, char **pattern, int pattern_counter,
                 struct Flags ops) {
  int rez;
  regex_t expr;
  int result = 0;
  for (int i = 0; i < pattern_counter; i++) {
    rez = make_pattern(&expr, pattern[i], line, ops);
    regfree(&expr);
    if (rez == 0) result = 1;
  }
  return result;
}