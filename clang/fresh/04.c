#include <stdio.h>
#include <limits.h>

int main() 
{
  int a;
  char b;
  float c;
  double d;

  printf("Storage size for int data type: %ld \n", sizeof(a));
  printf("Storage size for char data type: %ld \n", sizeof(b));
  printf("Storage size for float data type: %ld \n", sizeof(c));
  printf("Storage size for double data type: %ld \n", sizeof(d));

  // enum example
  enum MONTH
  {
    Jan = 0,
    Feb,
    Mar
  };
  enum MONTH month = Mar;
  if(month == 0)
    printf("Value of Jan");
  else if(month == 1)
    printf("Month is Feb");
  if(month == 2)
    printf("Month is March");
}
