#ifndef GREP_FLAG_H
#define GREP_FLAG_H
#include <regex.h>
#include <stdio.h>

#include "../common/common.h"

struct Node {
  char *str;
  struct Node *next;
};

struct Node *init_list();
struct Node *Add(struct Node *head, char *line);
void clean_list(struct Node *head);

void basegrep(FILE *file, struct Flags ops, char **pattern, char *filename,
              int filecounter, int pattern_counter);
int make_pattern(regex_t *expr, char *pattern, char *line, struct Flags ops);
void cflagcheck(int filecounter, struct Flags ops, char *filename,
                int linecounter, char *line, int get, int *printed_line,
                int v_check, regex_t expr);
void printname(int filecounter, struct Flags ops, char *filename);
int v_check_func(char *line, char **pattern, int pattern_counter,
                 struct Flags ops);
int f_add(char **pattern, struct Flags ops, int pattern_counter,
          char *filename);

#endif