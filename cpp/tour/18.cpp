#include <iostream>

using namespace std;

void getSeconds(unsigned long *p);
double getAverage(int *arr, int size);
int * getRandom();

const int MAX = 3;

int main() {
  int var1;
  char var2[10];

  cout << "Address of var1 variable: ";
  cout << &var1 << endl;

  cout << "Address of var2 variable: ";
  // cout << &var2 << endl;
  cout << var2 << endl << endl;

  int var3 = 20;
  int *pvar3;
  pvar3 = &var3;

  cout << "Value of var3 variable: ";
  cout << var3 << endl;

  cout << "Address stored in pvar3 variable: ";
  cout << pvar3 << endl;

  *pvar3 = 200;

  cout << "Value of *pvar3 variable: ";
  cout << *pvar3 << endl;

  int var4[MAX] = {10, 100, 100};
  int *pvar4;
  pvar4 = var4;
  for(int i = 0; i < MAX; i++) {
    cout << "Address of var4[" << i << "] = ";
    cout << pvar4 << endl;
    cout << "Value of var[" << i <<"] = ";
    cout << *pvar4 << endl;

    pvar4++;
  }
  /* *(var + 2) = 500; */

  unsigned long sec;
  getSeconds( &sec );
  cout << "Number of seconds: " << sec << endl;

  int balance[5] = {100, 2, 3, 18, 40};
  double avg;
  avg = getAverage( balance, 5 );
  cout << "Average value is: " << avg << endl;

  // Return Pointer from Functions
  int *random;
  random = getRandom();
  for (int i=0;i<10;i++) {
    cout << "*(random + " << i << ") : ";
    cout << *(random+i) << endl;
  }
  return 0;
}

void getSeconds(unsigned long *p) {
  *p = time(NULL);
  return;
}

double getAverage(int *arr, int size) {
  int i, sum=0;
  double avg;
  for(i=0;i<size;++i) {
    sum += arr[i];
  }
  avg = double(sum) /size;
  return avg;
}

int * getRandom() {
  static int r[10];

  srand((unsigned)time(NULL));

  for(int i = 0;i<10;++i) {
    r[i] = rand();
    cout << r[i] << endl;
  }
  return r;
}
