#include <stdio.h>
#include <stdlib.h>  // setenv() getenv() putenv()

void run();

int a = 10, b = 20, c = 30, d = 40;

int main()
{
  int m = 22, n = 44;
  printf("\nvalues: m = %d and n = %d", m, n);

  printf("\nAccessed from main function:\n");
  printf("values: a = %d, b = %d, c = %d, d = %d", a,b,c,d);

  run();

  setenv("FILE", "/usr/bin/env", 50);
  printf("\nFILE = %s\n", getenv("FILE"));
  putenv("FILE=/usr/bin/newenv");
  printf("After modifying, FILE = %s\n", getenv("FILE"));

  return 0;
}

void run()
{
  int x = 50, y = 80;
  printf("\nvalues : x = %d and y = %d", x, y);
  printf("\nAccessed from run function:\n");
  printf("values: a = %d, b = %d, c = %d, d = %d", a,b,c,d);
}

