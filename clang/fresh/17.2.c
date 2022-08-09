#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
  printf("argc: %d \n", argc);
  if(argc != 5)
  {
    printf("Arguments count not equal to 5");
    return 1;
  }

  printf("Program name: %s \n", argv[0]);
  printf("1st arg: %s \n", argv[1]);
  printf("2nd arg: %s \n", argv[2]);
  printf("3rd arg: %s \n", argv[3]);
  printf("4th arg: %s \n", argv[4]);
  printf("5th arg: %s \n", argv[5]);
  return 0;
}
