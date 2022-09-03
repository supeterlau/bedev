#include <stdio.h>
#include <ctype.h>

#define BUFSIZE 100

char buf[BUFSIZE];
int bufidx = 0;

int getch(void) 
{
	return (bufidx > 0) ? buf[--bufidx] : getchar();
}

void ungetch(int c) 
{
	if (bufidx >= BUFSIZE)
		printf("ungetch: too many characters\n");
	else
		buf[bufidx++] = c;
}

int getint(int *pn)
{
	int c, sign;

	while (isspace(c = getch()))
		;
	if (!isdigit(c) && c != EOF && c != '+' && c != '-') {
		ungetch(c);
		return 0;
	}
	sign = (c == '-') ? -1 : 1;
	if (c == '+' || c == '-') 
		c = getch();
	for(*pn = 0; isdigit(c); c = getch())
		// 进位
		*pn = 10 * *pn + (c - '0');
	*pn = *pn * sign;
	if (c != EOF)
		ungetch(c);
	return c;
}

int main()
{
	int *pn;

	// while (getint(pn) != EOF) {
	// 	printf("get int: %d\n", *pn);
	// }

	printf("End (EOF): %d\n", getint(pn));
	printf("get int: %d\n", *pn);
	return 0;
}
