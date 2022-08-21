#include <stdio.h>
#include <string.h>

typedef long long int LLI;

typedef struct version
{
  int commit;
  char msg[100];
  float score;
} vers;

int main()
{
  vers v;
  // vers *v_ptr;
  v.commit = 11000;
  strcpy(v.msg, "First commit");
  v.score = 101.102;
  printf("  Commit: %d \n", v.commit);
  printf("  Message: %s \n", v.msg);
  printf("  Score: %f \n", v.score);

  printf("\nStorage size of long long int data " \
      "type : %ld \n", sizeof(LLI));

  return 0;
}
