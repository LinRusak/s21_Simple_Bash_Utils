#include "s21_cat.h"

int main(int argc, char *argv[]) {
  FILE *fp;
  Flags flags = {false, false, false, false, false, false};

  char *short_options = "beEnstTv";
  struct option long_options[] = {{"number-nonblank", 0, NULL, 'b'},
                                  {"number", 0, NULL, 'n'},
                                  {"squeeze-blank", 0, NULL, 's'},
                                  {NULL, 0, NULL, 0}};
  int error = 0;

  int idx = 0;
  int res = 0;
  while ((res = getopt_long(argc, argv, short_options, long_options, &idx)) !=
         -1) {
    switch (res) {
      case 'b':
        flags.b = 1;
        break;
      case 'e':
        flags.e = 1;
        flags.v = 1;
        break;
      case 'E':
        flags.e = 1;
        break;
      case 'n':
        flags.n = 1;
        break;
      case 's':
        flags.s = 1;
        break;
      case 't':
        flags.t = 1;
        flags.v = 1;
        break;
      case 'T':
        flags.t = 1;
        break;
      case 'v':
        flags.v = 1;
        break;
      case '?':
        error = 1;
        break;
      default:
        error = 1;
        break;
    }
  }
  if (error) {
    printf("usage: cat [-benstuv] [file ...]\n");
    return 1;
  }

  if (argc == 1) {
    print_file(stdin, flags);
  } else {
    for (int i = 1; i < argc; i++) {
      fp = fopen(argv[i], "r");
      if (fp == NULL) {
        continue;
      }
      print_file(fp, flags);
      fclose(fp);
    }
  }

  return 0;
}

void print_file(FILE *fp, Flags flags) {
  char line[MAX_LINE_LENGTH];
  int line_num = 0;
  bool empty_line = false;

  while (fgets(line, MAX_LINE_LENGTH, fp) != NULL) {
    if (flags.s && is_empty(line)) {
      if (!empty_line) {
        empty_line = true;
        printf("\n");
      }
      continue;
    } else {
      empty_line = false;
    }

    if ((!is_empty(line)) && (flags.b)) {
      line_num++;
    } else if (flags.n) {
      line_num++;
    }
    print_line(line, line_num, flags, fp);
  }
}

void print_line(char *line, int line_num, Flags flags, FILE *fp) {
  char *p = line;
  int check = 0;
  if (flags.b && !is_empty(line)) {
    printf("%6d	", line_num);
  } else if (flags.n && !flags.b) {
    printf("%6d	", line_num);
  }
  while (*p != '\n') {
    if ((feof(fp) && *(p + 2) == '\n')) {
      break;
    }
    if (flags.v) {
      if ((*p >= 0) && (*p < 32) && (*p != '\n') && (*p != '\t')) {
        printf("^%c", (*p + 64));
        p++;
        continue;
      }
      if (*p == 127) {
        printf("^?");
        p++;
        continue;
      }
    }
    if (flags.t) {
      if (*p == 9) {
        printf("^I");
        p++;
        continue;
      }
    }
    if (*p == '\0') {
      check = 1;
      break;
    } else
      printf("%c", *p);
    p++;
  }
  if (flags.e) {
    if (*p == '\n') {
      printf("$");
    }
  }

  if (check == 0 && !feof(fp)) {
    printf("\n");
  }
}

bool is_empty(char *line) {
  int i = 0;
  while (line[i] != '\0') {
    if (line[i] != ' ' && line[i] != '\t' && line[i] != '\n') {
      return false;
    }
    i++;
  }
  return true;
}
