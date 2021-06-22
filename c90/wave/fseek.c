/*
 * fseek.c
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "fseek.h" */

#include <stdio.h>

int main()
{
  FILE *fp;
  fp = fopen("./readme.txt", "w+");
  fputs("Using fseek", fp);
  fseek(fp, 7, SEEK_SET);
  fputs("JavaVM", fp);
  fclose(fp);
  return 0;
}
