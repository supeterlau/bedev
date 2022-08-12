#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main()
{
  char ch;

  printf("Enter any character \n");
  scanf("%c", &ch);
  printf("\nGet %c \n", ch);
  printf("\nTo Uppercase %c \n", toupper(ch));
  printf("\nTo Lowercase %c \n", tolower(ch));
  if(isalpha(ch))
  {
    printf("\nEntered character is alphabetic\n");
  } else
    printf("\nEntered character is not alphabetic\n");

  int idx;
  char *arr = (char *) malloc(5 * sizeof(char));
  printf("Values before memset \n");
  for(idx=0;idx<5;idx++)
  {
    printf("    arr[%d] = %d \n", idx, arr[idx]);
  }

  memset(arr, 3, 5 * sizeof(char));

  printf("Values after memset \n");

  for(idx=0;idx<5;idx++)
    printf("    arr[%d] = %d \n", idx, arr[idx]);

  free(arr);

  // memchr()
  char *ptr;
  char str[] = "Erlang";
  ptr = (char *) memchr (str, 'a', strlen(str));

  if(ptr != NULL)
    // 内存地址操作
    printf("ptr %ld, str %ld, Found character 'a' at " \
        "position %ld. \n", ptr, str, ptr-str+1);
  else
    printf("Not found character 'a'. \n");

  printf("rand() : %d \n", rand());

  printf("Delay 5000 ms \n");
  // delay(5000);
  printf("After Delay 5000 ms \n");
  return 0;
}
