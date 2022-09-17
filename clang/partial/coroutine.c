/*
 * coroutine.c
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "coroutine.h" */

#include <stdio.h>

int read() {
  int i;
  for (i=0;i<10;i++){
    printf("Trace: %d\n", i);
    return i;
  }
  return i;
}

int switch_coroutine(int m, int n) {
  printf("control at range\n");
  static long long int i;
  static int state = 0;
  switch(state) {
    case 0:
      state = 1;
      for (i = m; i< n; i++) {
        return i;
    case 1:;
      }
  }
  state = 0;
  return 0;
}

int main()
{
  int i;
  i=switch_coroutine(1, 10);
  for (;i;) {
    printf("Control in main: %d\n", i);
    i=switch_coroutine(1, 10);
  }
  /* read(); */
  return 0;
}
