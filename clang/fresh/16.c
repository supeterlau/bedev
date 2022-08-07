#include <stdio.h>

int main() 
{
  int *ptr, q;
  q = 50;
  ptr = &q;
  printf("ptr value: %d \n", *ptr);
  return 0;
}
