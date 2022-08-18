#include <stdio.h>

struct student
{
  int id1;
  int id2;
  char a;
  char b;
  float percentage;
};

int main() 
{
  struct student record1 = {111,222,'Z', 'X', 19.9};

  printf("Size of structure in bytes: %d \n", sizeof(record1));

  printf("\nAddress of id1           = %u", &record1.id1);
  printf("\nAddress of id2           = %u", &record1.id2);
  printf("\nAddress of a             = %u", &record1.a);
  printf("\nAddress of b             = %u", &record1.b);
  // 空缺 2 bytes : structure padding
  printf("\nAddress of percentage    = %u \n", &record1.percentage);

}
