#include <stdio.h>

int main() 
{
  int idx;

  for (idx=0;idx<10;idx++)
  {
    printf("[for] idx is %d\n", idx);
  }

  idx = 0;
  while(idx < 10)
  {
    printf("[while] idx is %d\n", idx);
    idx++;
  }

  idx = 1;
  do 
  {
    printf("[do-while] idx is %d\n", idx);
    idx++;
  } while(idx <= 5 && idx >=2);
}
