#include <stdio.h>
#include <string.h>

int main()
{
  char str[20] = {'f', 'r','e','s','h','\0'};

  printf("str : %s \n", str);

  char target[20] = "C tutorial";

  strcat(target, str);

  printf("Target + str = %s \n", target);

  return 0;
}
