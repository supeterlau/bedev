#include <stdio.h>
#include <stdlib.h>

typedef struct Node_s {
	int data;
	struct Node_s* left;
	struct Node_s* right;
} Node;

int main() {
	Node node1;
  // = malloc(sizeof(Node));
	node1.data = 100;
	printf("value of node1: %d\n", node1.data);

	Node *node2;
	node2 = malloc(sizeof(Node));
	// or
	// Node *node2, node2_v;
	// node2 = &node2_v;
	node2->data = 200;
	printf("value of node2: %d\n", node2->data);
	return 0;
}
