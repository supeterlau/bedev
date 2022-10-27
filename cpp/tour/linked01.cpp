#include <iostream>

using namespace std;

class Node
{
  public:
    int data;
    Node* next;
};

void push(Node** head_ref, int new_data)
{
  Node* new_node = new Node();
  new_node->data = new_data;
  new_node->next = (*head_ref);
  (*head_ref) = new_node;
}

int getCount(Node* head)
{
  int count = 0;
  Node* current = head;
  while(current != NULL)
  {
    count++;
    current = current->next;
  }
  return count;
}

int main() {
  Node* head = NULL;

  push(&head, 100);
  push(&head, 300);
  push(&head, 50);
  push(&head, 90);
  cout << endl << "Count of nodes is " << getCount(head) << endl;
  return 0;
}
