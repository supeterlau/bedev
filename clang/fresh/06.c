#include <stdio.h>

#define xheight 10000

int main()
{
  const int height = 100;
  const float number = 3.111;
  const char letter = 'A';
  const char str[10] = "XYZ";
  const char backslash = '\?';

  printf("value of height: %d \n", height);
  printf("value of number: %f \n", number);
  printf("value of letter: %c \n", letter);
  printf("value of str: %s \n", str);
  printf("value of backslash: %c \n", backslash);

  printf("value of xheight: %d \n", xheight);
}
