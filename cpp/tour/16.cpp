#include <iostream>

using namespace std;

double getAvg(double *arr, int size);

int * getRandom(int);

int main() {
  double balance[5] = {101.1, 102.2, 103.3, 104.4, 105.5};
  double *p;

  p = balance;

  cout << "Array value via pointer `p`" << endl;
  for (int i = 0;i < 5; i++) {
    cout << "*(p + " << i << ") : ";
    cout << *(p + i) << endl;
  }
  cout << endl;

  cout << "Array value via `balance` as address" << endl;
  for (int i = 0;i < 5; i++) {
    cout << "*(balance + " << i << ") : ";
    cout << *(balance + i) << endl;
  }
  cout << endl;

  cout << "pass array to function" << endl;
  cout << getAvg(balance, 5) << endl;
  cout << endl;

  cout << "return array from function" << endl;
  /* cout << getRandom(5) << endl; */
  /* cout << getRandom(5) << endl; */

  int *vs;
  /* int size = 6; */
  int size = 5;
  vs = getRandom(size);
  for (int i = 0;i<size;i++) {
    cout << "*(vs + " << i << "):";
    cout << *(vs + i) << endl;
  }

  return 0;
}

double getAvg(double *arr, int size) {
  double sum = 0;
  for (int i = 0; i < size;i++) {
    sum += arr[i];
  }
  return sum / size;
}

int * getRandom(int size) {
  // 可变数组 storage 不能是 static
  static int values[5];
  srand( (unsigned) time(NULL) );
  for (int i = 0;i<5;i++){
    int v = rand();
    values[i] = v;
    cout << "v: " << v << endl;
  }
  return values;
}
