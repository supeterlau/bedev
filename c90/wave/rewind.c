/*
 * rwind.c
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "rwind.h" */

#include <stdio.h>
/* MS-DOS */
/* #include <conio.h> */

int main()
{
  FILE *fp;
  char c;
  /* clrscr(); */
  fp = fopen("./compile", "r");
  c=fgetc(fp);
  while(c != EOF) {
    printf("%c\n", c);
    c=fgetc(fp);
  }

  rewind(fp);

  c=fgetc(fp);
  while(c != EOF) {
    printf("%c\n", c);
    c=fgetc(fp);
  }
  fclose(fp);
  /* getch(); */

  return 0;
}
