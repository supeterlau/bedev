/*
 * func_pointer.c
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "func_pointer.h" */

/* function pointer */
/* float (*add)(); legal */
/* float *add();   illegal */

#include <stdio.h>

void display(void (*p)()) {
  for (int i=1;i<=5;i++) {
    p(i);
  }
}

void print_numbers(int num) {
  printf("=> %d\n",num);
}

int main()
{
  void (*p)(int);
  p = &print_numbers;
  printf("Result: \n");
  display(p);
  return 0;
}
