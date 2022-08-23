#include <stdio.h>

#define letter 'A'
#define COMMIT 10101
#define test 100

#pragma startup start
#pragma exit exit

int main()
{
  printf("value of letter: %c \n", letter);

#ifdef COMMIT
  printf("COMMIT is defined, value of COMMIT is: %d \n", COMMIT);
#else
  printf("COMMIT is not defined \n");
#endif

#undef COMMIT

#ifndef COMMIT
  printf("COMMIT is not defined \n");
#else
  printf("COMMIT defined: %d \n", COMMIT);
#endif

#if(test == 100)
  printf("Add if a == 100 \n");
#else
  printf("Add if a not equal to 100 \n");
#endif

  return 0;
}

void start()
{
  printf("\nCalled before main\n");
}

void exit()
{
  printf("\nCalled before end of main\n");
}
