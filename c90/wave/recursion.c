/*
 * recursion.c
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "recursion.h" */

#include <stdio.h>

int fibonacci(int);

int main()
{
  int n, f;
  printf("Enter the number: \n");
  scanf("%d", &n);
  f = fibonacci(n);
  printf("fibonacci(%d) = %d\n", n, f);
  return 0;
}

int fibonacci(int n) {
  // 考虑用 custom map 加速
  // https://stackoverflow.com/questions/21958247/map-like-structure-in-c-use-int-and-struct-to-determine-a-value
  printf("Call fibonacci(%d)\n", n);
  if(n == 0 || n == 1)
    return n;
  else
    return fibonacci(n-1) + fibonacci(n-2);
}
