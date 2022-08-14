// https://www.guru99.com/c-function-pointers.html

#include <stdio.h>

void swap(int *a, int *b);

int sum_array(int *a, int length);

int* build_arr();

void say_hi(int times);

int sum(int ls, int rs);
int sub(int ls, int rs);
int mult(int ls, int rs);
int div(int ls, int rs);

int cube (const void* num);

int compare(const void *, const void *);

// Main

int main() 
{
  // Pointers as Parameters
  int m = 25, n = 100;
  printf("Before swap: m # %d, n # %d \n", m, n);

  swap(&m, &n);
  printf("After swap: m # %d, n # %d \n", m, n);

  // Array as Parameters
  int numbers[5] = {100, 220, 77, 16, 99};
  printf("\nTotal sum # %d \n", sum_array(numbers, 5));

  // Return an Array
  int *new_arr;
  new_arr = build_arr();
  for (int i=0;i<5;i++)
  {
    printf("new_arr[%d]=%d \n", i, new_arr[i]);
  }

  // 指针函数
  // return_type (*function_name)(arguments)
  void (*fun_ptr)(int); // 函数声明
  fun_ptr = say_hi;
  fun_ptr(3);
  // 等同于
  fun_ptr = &say_hi;
  (*fun_ptr)(4);

  // Array of Function Pointers
  int x, y, choice, result;
  int (*op[4])(int, int);  // Function Pointer Array
  op[0] = sum;
  op[1] = sub;
  op[2] = mult;
  op[3] = div;
  printf("\nEnter two integer numbers: \n");
  scanf("%d %d", &x, &y);
  printf("\nEnter 0 to sum, 1 to subtract, 2 to multiply, 3 to divide: \n");
  scanf("%d", &choice);
  result = op[choice](x, y);
  printf("\nresult : %d\n", result);

  // Using void Pointers
  // void * 返回值表示返回任意类型
  // 如果参数不会变，可以声明为 const

  int x1, cube_int;
  x1 = 4;
  cube_int = cube(&x1);
  printf("%d cubed is %d \n", x1, cube_int);

  // Function Pointers as Arguments
  // 函数指针作为参数
  // void qsort(void *base, size_t num, size_t width, int (*compare)(const void *, const void *))

  // void *base : void pointer to array
  // size_t num : array 数量
  // size_t width : 元素大小
  // int(*compare(const void *, const void *)) : function pointer, two arguments and 两数相等 return 0，1<2 返回 <0，1>2 返回 >0 
  int sort_arr[5] = {54,345,63,4353,6};
  int arr_count, arr_width;
  arr_count = sizeof(sort_arr)/sizeof(sort_arr[0]);
  arr_width = sizeof(sort_arr[0]);
  qsort((void *)sort_arr, arr_count, arr_width, compare);
  for(int i=0;i<arr_count;i++)
  {
    printf("%d ", sort_arr[i]);
  }

  return 0;
}

void swap(int *a, int *b)
{
  int temp;
  temp = *a;
  *a = *b;
  *b = temp;
}

int sum_array(int *a, int count)
{
  int total = 0;
  for(int i=0;i<count;i++)
  {
    printf("\nArray pointer: %u", a);
    total += *a; a++;
    // total += a[i]; 
  }
  return total;
}

int* build_arr() {
  static int arr[5] = {12,13,14,15,16};
  // int arr[5] = {12,13,14,15,16};
  return arr;
}

void say_hi(int times)
{
  for(int i=0;i<times;i++)
  {
    printf("Hi time(%d) \n", i);
  }
}

int sum(int ls, int rs) { return ls + rs; }
int sub(int ls, int rs) { return ls - rs; }
int mult(int ls, int rs) { return ls * rs; }
int div(int ls, int rs) { if (rs != 0) return ls / rs; else return 0; }

int cube (const void *num)
{
  int result;
  // as it is a void pointer, we have to type cast it to an integer data type using a specific notation (* datatype) pointer
  result = (*(int *) num) * (*(int *) num) * (*(int *) num);
  return result;
}

int compare(const void *elem1, const void *elem2)
{
  if( (*(int *)elem1) == (*(int *)elem2) )
  {
    return 0;
  } else if ( (*(int *)elem1 < (*(int *)elem2))  )
    return -1;
  else
    return 1;
}
