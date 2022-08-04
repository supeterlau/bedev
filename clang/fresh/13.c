#include <stdio.h>

void increment(void);
void incr_static(void);

int main()
{
  for(int i = 0; i<5; i++) {
    increment();
    incr_static();
  }

  // extern
  extern int extern_y;
  printf("The value of y is %d \n", extern_y);

  // register
  register int reg_i;
  int arr[5];
  arr[0] = 10;
  arr[1] = 20;
  arr[2] = 30;
  arr[3] = 40;
  arr[4] = 50;
  for(reg_i=0;reg_i<5;reg_i++)
  {
    printf("Value of arr[%d] is %d \n", reg_i, arr[reg_i]);
  }

  return 0;
}

void increment(void)
{
  auto int i = 0;
  printf("[auto/default local] %d \n", i);
  i++;
}

void incr_static(void)
{
  static int i = 0;
  printf("[static] %d \n", i);
  i++;
}

int extern_y = 500;
