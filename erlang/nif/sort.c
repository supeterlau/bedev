#include <stdio.h>
#include <stdlib.h>

int cmp(const void *p, const void *q) {
  return (*(int*)p - *(int*)q);
}

void pArr(int arr[], int len) {
  printf("[ ");
  for(int i = 0; i < len; i++) 
    printf("%d ", arr[i]);
  printf("]\n");
}

int main() {
  int arr[] = {1,6,7,8,9,0,5};
  int len = sizeof(arr) / sizeof(arr[0]);
  printf("Before sort: \n");
  pArr(arr, len);
  qsort((void*)arr, len, sizeof(arr[0]), cmp);
  printf("\nAfter sort: \n");
  pArr(arr, len);
}
