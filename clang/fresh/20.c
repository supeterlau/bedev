#include <stdio.h>
#include <string.h>

union book
{
  char name[20];
  char subject[20];
  float score;
} book1;

int main()
{

  // union book record1;
  // union book record2;

  strcpy(book1.name, "SICP");
  strcpy(book1.subject, "Programming");
  // book1.score = 111.11;

  printf("  Name : %s \n", book1.name);
  printf("  Subject: %s \n", book1.subject);
  // printf("  Score: %f \n", book1.score);

  return 0;
}
