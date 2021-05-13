/*
 * 11.cpp
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "11.h" */

#include <iostream>

using namespace std;

int main()
{
  int value = 21;
  int state;
  cout << "Line 0 - Value of value is : " << value << endl;
  state = value++;
  cout << "Line 1 - Value of value++ is : " << state << endl;

  cout << "Line 2 - Value of value is : " << value << endl;

  state = ++value;
  cout << "Line 3 - Value of ++value is : " << state << endl;
  cout << "Line 4 - Value of value is : " << value << endl;
  return 0;
}
