#include <iostream>

using namespace std;

void swap(int& x, int& y);

double& setValue(int i);

double vals[] = {1.1,2,2};

int main() {
  double d = 100.1;

  double& d2 = d;

  cout<<"Value of d: " << d<<endl;
  cout<<"Value of ref d2: " << d2<<endl;

  d = 200.1;
  cout<<"Value of d: " << d<<endl;
  cout<<"Value of ref d2: " << d2<<endl;

  d2 = 300.1;
  cout<<"Value of d: " << d<<endl;
  cout<<"Value of ref d2: " << d2<<endl;

  int n = 100;
  int m = 10;
  int mn = n ^ m;
  cout << "Value of m xor n " << mn << endl;
  mn = mn ^ m;
  cout << "Value of m xor n " << mn << endl;
  int x = 5^6^6;
  cout << "Value of 5 ^ 6 ^ 6 " << x << endl;
  x = 5^6^5;
  cout << "Value of 5 ^ 6 ^ 5 " << x << endl;

  // pass refs
  int p = 111;
  int q = 222;
  cout << "Before swap p: " << p << endl;
  cout << "Before swap q: " << q << endl;
  swap(p, q);
  cout << "After swap p: " << p << endl;
  cout << "After swap q: " << q << endl;

  // retrun refs

  cout << "Before set value" << endl;
  for (int i = 0;i<2;i++) {
      cout << "vals[" << i << "]:";
      cout << vals[i] << endl;
  }
  setValue(0) = 10.1;
  setValue(1) = 20.2;
  cout << "After set value" << endl;
  for (int i = 0;i<2;i++) {
      cout << "vals[" << i << "]:";
      cout << vals[i] << endl;
  }
  return 0;
}

void swap(int& x, int& y) {
  y = y^x;
  x = y^x; 
  y = y^x;
  return;
}

double& setValue(int i) {
  return vals[i];
}
