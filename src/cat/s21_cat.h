#ifndef CAT_H
#define CAT_H

#include <getopt.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE_LENGTH 1024

typedef struct {
  bool b;
  bool e;
  bool n;
  bool s;
  bool t;
  bool v;
} Flags;

// int parse_params(int argc, char **argv, char *short_options,
//               struct option long_options[], config *conf);

void print_file(FILE *fp, Flags flags);

void print_line(char *line, int line_num, Flags flags, FILE *fp);

bool is_empty(char *line);

#endif