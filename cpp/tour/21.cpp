#include <iostream>

using namespace std;

int main() {
  char str[] = "Try cin cout cerr clog";

  cout << "Out: " << str << endl;
  cerr << "Error: " << str << endl;
  clog << "Log: " << str << endl;
  return 0;
}
