/*
 * 12.cpp
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "12.h" */

#include <iostream>

using namespace std;

int main()
{
  int init = 20;
  // while loop
  while(init < 35) {
    cout << "---> " << init << endl;
    init++;
  }

  init = 20;
  for (; init > 10; init--) {
    cout << "for loop: ---> " << init << endl;
  }

  init = 20;
  do {
    cout << "do-while loop: ---> " << init << endl;
    init++;
  } while( init < 25 );

  for(int m = 0; m < 10; m=m+2) {
    for(int n = 0; n < 10; n=n+3) {
      cout << "break: before test m+n = " << m+n << endl;
      if(m+n == 10) {
        break;
      }
      cout << "break: m+n = " << m+n << endl;
    }
  }

  for(int m = 0; m < 10; m=m+2) {
    for(int n = 0; n < 10; n=n+3) {
      cout << "continue: before test m+n = " << m+n << endl;
      if(m+n == 10) {
        continue;
      }
      cout << "continue: m+n = " << m+n << endl;
    }
  }

  init = 20;
BLUE:do {
       if ( init == 25 ) {
         init++;
         goto BLUE;
       }
       cout << "goto: ---> " << init << endl;
       init++;
     } while( init < 30 );

  for(int m = 0; m < 10; m=m+2) {
    for(int n = 0; n < 10; n=n+3) {
      if(m+n == 10) {
        cout << "m+n = " << m+n << endl;
        goto stop;
      }
    }
  }
stop:
  cout << "EXIT nested loop" << endl;

  for (;;) {
    cout << "Infinite loop" << endl;
    break;
  }
  return 0;

}
