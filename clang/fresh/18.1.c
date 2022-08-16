#include <stdio.h>
#include <string.h>

// include student structure
#include "student.h"

int main()
{
  struct student record1 = {1, "Elixir", 91.1};

  struct student record2, *record3, *ptr1, record4;

  printf("\nRecords of STUDENT record1: \n");
  printf("  Id: %d \n  Name: %s\n  Percentage: %f\n",
      record1.id, record1.name, record1.percentage);

  // 方法1 直接赋值
  record2 = record1;

  printf("\nRecords of STUDENT record2: \n");
  printf("  Id: %d \n  Name: %s\n  Percentage: %f\n",
      record2.id, record2.name, record2.percentage);

  // 方法2 指针 memcpy
  ptr1 = &record1;
  // 初始化
  record3 = malloc( sizeof *ptr1 );
  // struct student *record3; 即 record3 是一个指针
  memcpy(record3, ptr1, sizeof(record1));
  printf("\nMEM size %ld\n", sizeof(record1));

  printf("\nRecords of STUDENT record3: \n");
  printf("  Id: %d \n  Name: %s\n  Percentage: %f\n",
      record3->id, record3->name, record3->percentage);

  // 方法 3 逐个赋值

  record4.id = record1.id;
  strcpy(record4.name, record1.name);
  record4.percentage = record1.percentage;

  printf("\nRecords of STUDENT record4: \n");
  printf("  Id: %d \n  Name: %s\n  Percentage: %f\n",
      record4.id, record4.name, record4.percentage);

  return 0;
}
