#include <stdio.h>
#include <stdlib.h>

void display(int *ptr, int n) {
	for (int i = 0; i < n; i++) {
		printf("%d ", ptr[i]);
	}
}

int main() {
	int *ptr1, *ptr2;
	// char *ptr1, *ptr2;
	int i, j;

	i = 5;
	printf("Numbers of element: %d\n", i);
	ptr1 = (int*) malloc(i * sizeof(int));
	ptr2 = (int*) calloc(i, sizeof(int));
	// ptr1 = (char*) malloc(i * sizeof(char));
	// ptr2 = (char*) calloc(i, sizeof(char));
	if(ptr1 == NULL || ptr2 == NULL) {
		printf("Memory not allocated.\n");
		exit(0);
	} else {
		for(int ii = 0; ii<i; ii++) {
			ptr1[ii] = ii * 3;
		}
		printf("\nmalloc initial value: \n");
		display(ptr1, i);

		printf("\ncalloc initial value: \n");
		display(ptr2, i);

		i = 15;
		ptr1 = realloc(ptr1, i * sizeof(int));
		printf("\nrealloc up to : %d\n", i);
		display(ptr1, i);

		printf("\nFree malloc result.\n");
		free(ptr1);
		printf("Malloc successfully freed.\n");

		printf("Free calloc result.\n");
		free(ptr2);
		printf("Calloc successfully freed.\n");
	}
	return 0;
}
