#include <stdio.h>

int count;
extern void write_extern();

int main() {
	count = 150;
	write_extern();
	return 0;
}
