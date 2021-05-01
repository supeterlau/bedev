#include <iostream>
using namespace std;

template <typename T>
T theMax(T x, T y) {
  return (x > y) ? x: y;
}

int main() {
  cout << theMax<int>(3, 7) << endl;
  cout << theMax<double>(3.0, 7.0) << endl;
  cout << theMax<char>('g', 'e') << endl;

  return 0;
}
