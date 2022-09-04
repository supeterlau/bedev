#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ALLOC_SIZE 1000 // 10k

// static : invisible outside it
static char allocbuf[ALLOC_SIZE];
static char *allocp = allocbuf;

void convert() {
	int i;
	char *some = "A Long string to binary";
	int *result;

	printf("before convert: sizeof = %lu\n", sizeof(*some));
	for (i=0;i<8*strlen(some);i++) {
		result[i] = 0 != (some[i/8] & 1 << (~i & 7));
	}
	printf("after convert: sizeof = %lu\n", sizeof(*result));
}

char *alloc(int n)
{
	// first + total - current
	if(allocbuf + ALLOC_SIZE - allocp >= n) {
		// return allocp;
		allocp += n;
		return allocp - n;
	} else 
		return 0;
}

void afree(char *p)
{
	if (p >= allocbuf && p < allocbuf + ALLOC_SIZE)
		allocp = p;
}

void tinyalloc()
{
	// C 的 pointer array address_arithmetic 保持一致性
	// if no more room, alloc return 0
	// if have enough room, return pointer point to next free area

}

void print_char(char c) 
{
	for (int i = 7;i>=0;--i)
	{
		putchar( (c & (1 << i)) ? '1' : '0' );
	}
	putchar('\n');
}

int main()
{
	// "8" -> 8
	int i = 8;
	printf("~i = %d\n", ~i);
	printf("~i & 7 = %d\n", ~i & 7);
	printf("1 << (~i & 7) = %d\n", 1 << (~i & 7));

	char ch = '8';
	printf("char %c : %d\n", ch, ch);
	/* char number[9]; // 8 + '\0' */
	/* itoa(ch, number, 2); */

	/* printf("number %c to: %s\n", ch, number); */
	print_char(ch);
  // 00111000
	// ord('8') = 56
	// int("00111000",2)

	/* convert(); */

	/* tinyalloc(); */
	return 0;
}
