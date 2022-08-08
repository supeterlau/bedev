#include <stdio.h>
#include <string.h>

int modify(int, int[], char[]);

int main()
{
  int i, a = 20;
  int arr[5] = {10,20,30,40,50};
  char str[30] = "BestofErlang";

  printf("Before modify \n");
  printf("a = %d \n", a);

  for (i=0;i<5;i++) 
  {
    printf("arr[%d] = %d \n", i, arr[i]);
  }

  printf("char str[30] = %s \n", str);

  // a = modify(a, &arr[0], &str[0]);
  // 等效于上一句
  a = modify(a, arr, str);

  printf("After modify \n");
  printf("a = %d \n", a);

  for (i=0;i<5;i++) 
  {
    printf("arr[%d] = %d \n", i, arr[i]);
  }

  printf("char str[30] = %s \n", str);
  return 0;
}

int modify(int a, int *arr, char *str)
{
  a = a + 20;
  // 不是 *arr 
  // int *arr 不代表从 arr 中取得值，而是表示这是指针
  // 不是 int new_char[5] = *arr;
  arr[0] = arr[0] + 50;
  arr[1] = arr[1] + 50;
  arr[2] = arr[2] + 50;
  arr[3] = arr[3] + 50;
  arr[4] = arr[4] + 50;
  strcpy(str, "We will use Elixir");
  return a;
}
