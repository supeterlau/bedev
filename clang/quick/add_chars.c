#include <stdio.h>
#include <string.h>

int main() {
	char text[] = "HelloWorld";
	int idx;
	int sum = 0;
	for(idx = 0; idx < strlen(text); idx++) {
		sum += text[idx];
	}
	printf("sum of chars: %d\n", sum);
	return 0;
}
