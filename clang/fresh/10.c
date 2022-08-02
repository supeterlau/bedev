#include <stdio.h>

int main()
{
  int init = 3;
  switch(init) 
  {
    case 1:
    printf("Value is 1 \n");
    break;
    case 2:
    printf("Value is 2 \n");
    break;
    case 3:
    printf("Value is 3 \n");
    break;
    default:
    printf("Value is not 1,2,3 \n");
  }

  int idx;
  for(idx=1; idx<10; idx++) 
  {
    if (idx == 6)
    {
      printf("\nComing out of loop when idx is 6\n");
      break;
    }

    if (idx == 2 || idx == 3)
    {
      printf("Skipping %d from display use continue\n", idx);
      continue;
    }
    printf("idx is %d\n", idx);
  }

  // goto
  int new;
  for (new = 0; new < 10; new++)
  {
    if(new == 5)
    {
      printf("We use goto whe new is 5");
      goto FIVE;
    }
    printf("new is %d\n", new);
    BACK:
      printf("Back in loop new is %d\n", new);
  }
  printf("This line is skipped?");
  FIVE: 
    printf("\nInside label name FIVE\n");
    printf("\nInside label name FIVE\n");
    goto BACK;
  return 0;
}
