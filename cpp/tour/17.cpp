#include <iostream>

using namespace std;

int main() {
  // char greeting01[6] = {'H', 'E', 'L', 'L', 'O', '\0'};
  char greeting01[5] = {'H', 'E', 'L', 'L', 'O'};
  char greeting02[] = "Computer";
  cout << "Greeting01 ";
  cout << greeting01 << endl;
  cout << "Greeting02 ";
  cout << greeting02 << endl;

  char greeting03[10];
  int len;
  strcpy(greeting03, greeting01);
  cout << "strcpy(): greeting03 = " << greeting03 << endl;

  strcat(greeting03, greeting01);
  cout << "strcat(greeting01, greeting02) " << greeting03 << endl;
  cout << "strlen(greeting03) " << strlen(greeting03) << endl;

  // string class type

  string word01 = "physical";
  string word02 = "hierarchal";
  string word03;
  int word_len;

  word03 = word01;
  cout << "Word03 : " << word03 << endl;

  word03 = word01 + " " + word02;
  cout << "word01 + word02: " << word03 << endl;
  cout << "word03.size() : " << word03.size() << endl;
  return 0;
}
