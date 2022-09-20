// https://www.cprogramming.com/tutorial/function-pointers.html

#include <stdio.h>

void welcome(char *name)
{
  printf("Welcome, %s\n", name);
}

void have_fun(char *name)
{
  printf("Have fun, %s\n", name);
}

void use_fptr(void (*fptr)(char *), char *name)
{
  fptr(name);
}

int main()
{
  void (*fptr)(char *);
  char *name = "Ritchie";

  fptr = &welcome;
  use_fptr(fptr, name);

  fptr = &have_fun;
  use_fptr(fptr, name);
  return 0;
}
