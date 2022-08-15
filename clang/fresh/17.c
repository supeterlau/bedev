#include <stdio.h>

float square( float x );

void swap(int a, int b);

void swap_ref(int *a, int *b);

int main() 
{
  float m, n;
  printf("Enter some number for caculate square \n");
  scanf("%f", &m);
  n = square(m);
  printf("Square of given number %f is %f \n", m, n);

  // call by value
  int a = 111, b = 222;
  printf("Before swap \na = %d \nb = %d \n", a, b);
  swap(a, b);
  printf("After swap \na = %d \nb = %d \n", a, b);
  
  printf("Before swap by ref \na = %d \nb = %d \n", a, b);
  swap_ref(&a, &b);
  printf("After swap by ref \na = %d \nb = %d \n", a, b);

  return 0;
}

float square(float x)
{
  return x * x;
}

void swap(int a, int b)
{
  int tmp;
  tmp = a;
  a = b;
  b = tmp;
  printf("Inside swap \na = %d \nb = %d \n", a, b);
}

void swap_ref(int *a, int *b)
{
  int tmp;
  tmp = *a;
  *a = *b;
  *b = tmp;
  printf("Inside swap_ref \na = %d \nb = %d \n", *a, *b);
}
