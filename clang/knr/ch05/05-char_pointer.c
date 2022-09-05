#include <stdio.h>

void strcopy0(char *s, char *t)
{
	int i;
	i = 0;
	// '\0' != '0' != 0
	while((s[i] = t[i]) != '\0')
		i++;
}

void strcopy1(char *s, char *t)
{
	while ((*s = *t) != '\0') {
		s++;
		t++;
	}
}

void strcopy2(char *s, char *t)
{
	// while((*s++ = *t++) != '\0')
	while (*s++ = *t++)
		;
}

// 标准库的 strcopy 返回 target string

int strlen(char *s)
{
	char *p = s;
	while (*p != '\0') {
		p++;
	}
	return p - s;
}

int main()
{
  /* char amsg[] = "C Pointer"; */
  /* char *pmsg = "C Pointer"; */

	char *message = "rudimentary";
	printf("message length: %d\n", strlen(message));
	return 0;
}
