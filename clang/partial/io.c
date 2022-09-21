#include <stdio.h>

int main() {
  FILE *fp;
  char buff[255];

  fp = fopen("./compile", "r");

  // 从文件中读取内容，到第一个 space 结束
  fseek(fp, 5, SEEK_SET);
  printf("cur: %d#END#", SEEK_CUR);

  fscanf(fp, "%s", buff);
  printf("1 : %s\n", buff);

  fgets(buff, 255, (FILE*)fp);
  printf("2: %s\n", buff);

  fgets(buff, 255, (FILE*)fp);
  printf("3: %s\n", buff);

  fclose(fp);
  return 0;
}
