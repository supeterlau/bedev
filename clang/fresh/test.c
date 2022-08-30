#include <stdio.h>
#include <string.h>

int main () {
   char src[50];
   char dest[] = "This is destination";

   strcpy(src,  "This is source");
   // strcpy(dest, "This is destination");

   strcat(dest, src);

   printf("Final destination string : |%s| \n", dest);
   
   return(0);
}
