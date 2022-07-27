#include <stdio.h>

int main()
{
  char ch = 'Z';
  char str[30] = "C language is case sensitive";
  float flt = 10.123;
  int number = 2020;
  double dbl = 20.0987654321;
  
  printf("Character is %c \n", ch);
  printf("String is %s \n", str);
  printf("Float value is %f \n", flt);
  printf("Double value is %lf \n", dbl);
  printf("Integer value is %d \n", number);
  printf("Octal value is %o \n", number);
  printf("Hexadecimal value is %x \n", number);

  return 0;
}
