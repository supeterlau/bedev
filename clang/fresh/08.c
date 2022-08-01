#include <stdio.h>

int main()
{
  int m = 40, n = 20;
  if(m == n)
  {
    printf("m equals n\n");
  } else 
    printf("m not equals n\n");

  int AND_opr, OR_opr, XOR_opr, NOT_opr, LS_opr, RS_opr;
  AND_opr = m & n;
  OR_opr = m | n;
  XOR_opr = m ^ n;
  NOT_opr = ~m;
  LS_opr = m << 2;
  RS_opr = m >> 2;

  printf("AND_opr value = %d\n", AND_opr);
  printf("OR_opr value = %d\n", OR_opr);
  printf("XOR_opr value = %d\n", XOR_opr);
  printf("NOT_opr value = %d\n", NOT_opr);
  printf("LS_opr value = %d\n", LS_opr);
  printf("RS_opr value = %d\n", RS_opr);

  printf("binary value of n = 0x%x\n", n);

  int *ptr, p;
  p = 500;
  ptr = &p;
  printf("value in ptr: %d\n", *ptr);

  return 0;
}
