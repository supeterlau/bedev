#include <iostream>

using namespace std;

int max(int, int);
void swap_via_p(int *x, int *y);
void swap_via_r(int &x, int &y);

int main() {
  int a1 = 100;
  int a2 = 200;
  int ret;

  ret = max(a1, a2);
  cout << "Max value: " << ret << endl;

  cout << "Before swap: " << endl;
  cout << "a1: " << a1 << " a2: " << a2 << endl;
  swap_via_p(&a1, &a2);
  cout << "After swap: " << endl;
  cout << "a1: " << a1 << " a2: " << a2 << endl;

  cout << "Before swap: " << endl;
  cout << "a1: " << a1 << " a2: " << a2 << endl;
  swap_via_r(a1, a2);
  cout << "After swap: " << endl;
  cout << "a1: " << a1 << " a2: " << a2 << endl;
  return 0;
}

int max(int num1, int num2) {
  return num1 > num2 ? num1 : num2;
}

void swap_via_p(int *num1, int *num2) {
  int temp;
  temp = *num1;
  *num1 = *num2;
  *num2 = temp;
}

void swap_via_r(int &num1, int &num2) {
  int temp;
  temp = num1;
  num1 = num2;
  num2 = temp;
}
