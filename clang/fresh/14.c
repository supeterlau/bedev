#include <stdio.h>

int main()
{
  int arr[5] = {10,20,30,40,50};
  // int arr[5] = {0}; 初始化为 0
  // int arr[0] = 10; 逐个初始化
  // int arr[1] = 20; 
  for (int i=0;i<5;i++)
  {
    printf("arr[%d] : %d \n", i, arr[i]);
  }

  int arr2[2][2] = { 11,22,33,44 };

  for(int i=0;i<2;i++)
  {
    for(int j=0;j<2;j++)
    {
      printf("arr2[%d][%d] : %d \n", i, j, arr2[i][j]);
    }
  }

  int codes[] = {123,124,125,126,230,231,232};
  printf("Sizeof codes[]: %d \n", (int) sizeof(codes));
  printf("Length of codes[]: %d \n", (int) (sizeof(codes) / sizeof(codes[0])));
  return 0;
}
