#include <stdio.h>
#include <stdarg.h>

// num 表示后边参数个数
int add(int num, ...);

int main()
{
  printf("First function call = " \
      "%d \n", add(2, 3,4));
  printf("Second function call = " \
      "%d \n", add(4, 6,7,8,9,111));
  return 0;
}

int add(int num, ...) 
{
  va_list valist;
  int sum = 0;
  int i;

  va_start(valist, num);
  for(i=0;i<num;i++)
  {
    sum += va_arg(valist, int);
  }
  va_end(valist);
  return sum;
}
