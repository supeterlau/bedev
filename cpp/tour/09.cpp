/*
 * 09.cpp
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

#include <iostream>
using namespace std;

/* #include "09.h" */

#define LENGTH 10
#define WIDTH 50
#define NEWLINE '\n'

int main() {
  
  cout << "Hello\tWorld\n\n";

  int area;
  area = LENGTH * WIDTH;
  cout << area;
  cout << NEWLINE;
  return 0;
}
