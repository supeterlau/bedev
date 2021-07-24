#include <iostream>

using namespace std;

int main() {
  int a1 = 100;
  int a2 = 200;

  switch(a1) {
    case 100:
      cout << "In Outer switch: " << endl;
      switch(a2) {
        case 200: 
          cout << "In Inner switch: " << endl;
      }
  }
  cout << "a1: " << a1 << endl;
  cout << "a2: " << a2 << endl;
  return 0;
}
