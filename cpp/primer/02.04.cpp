/*
 * 02.04.cpp
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "02.h" */

#include <iostream>
#include <cmath>

using namespace std;

int main()
{
  double area;
  cout << "Enter house area:";
  cin >> area;
  double side;
  side = sqrt(area);
  cout << "Square "
    << side
    << " feet to the side" << endl;
  cout << "Good" << endl;
  return 0;
}
