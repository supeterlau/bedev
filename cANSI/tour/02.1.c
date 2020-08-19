#include <stdio.h>

int total = 0;
int sum(int, int);

int main() 
{
  printf("A C basic program \n");

  total = sum(1, 2);

  printf("Sum of two numbers: %d\n", total);

  return 0;
}

int sum(int a, int b)
{
  return a + b;
}
