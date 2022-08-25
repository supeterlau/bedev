#include <stdio.h>
#include <string.h>

int main()
{
  FILE *fp;
  char content[50];
  char fname[] = "tmp.c";

  printf("Opening the file tmp.c in write mode");

  fp = fopen(fname, "w");

  if(fp == NULL) {
    printf("Could not open file %s \n", fname);
    return -1;
  }
  printf("\nEnter some text from keyboard" \
      " to write to %s \n", fname);
  // this program uses gets(), which is unsafe
  while (strlen(gets(content)) > 0)
  {
    fputs(content, fp);
    fputs("\n", fp);
  }

  printf("Closing file %s \n", fname);
  fclose(fp);

  fp = fopen(fname, "r");
  if (fp == NULL)
  {
    printf("Could not open file %s \n", fname);
    return -1;
  }
  printf("Reading file %s \n", fname);
  while(fgets(content, 50, fp) != NULL)
    printf("%s", content);

  printf("Closing file %s \n", fname);
  fclose(fp);

  return 0;
}
