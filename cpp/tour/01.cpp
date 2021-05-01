#include <iostream>

using namespace std;

int main()
{
  cout << "Enter integer: " << endl;
  int value;
  cin >> value;

  if (value >= 0)
  {
    cout << "Get positive integer or zero" << endl;
    cout << "Double it : " << value * 2 << endl;
  }
  else
  {
    cout << "Get negative integer" << endl;
    cout << "Value is : " << value << endl;
  }
  return 0;
}
