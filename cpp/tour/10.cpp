/*
 * 10.cpp
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "10.h" */

#include <iostream>

using namespace std;

void func(void);

static int count_value = 11;

extern void show_count();

int main()
{
  while(count_value--) {
    func();
  }
  show_count();
  return 0;
}

void func(void)
{
  static int state = 5;
  state++;
  cout << "state is " << state;
  cout << " and count is " << count_value << endl;
}
