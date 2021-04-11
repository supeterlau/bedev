/*
 * 03.14.cpp
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "03.h" */

#include <iostream>

using namespace std;

int main()
{
  int auks, bats, coots;
  auks = 19.99 + 11.99;
  bats = (int) 19.99 + (int) 11.99;
  coots = int (19.99) + int (11.99);

  cout << "auks = "
    << auks 
    << ", bats = "
    << bats
    << ", coots = "
    << coots
    << endl;

  char ch = 'z';
  cout << "ch is "
    << int (ch)
    << endl;
  cout << "static_cast<int>('Z') "
    << static_cast<int>('Z') << endl;
  return 0;
}
