#include "Coordinate.h"
#include <iostream>

#include <cstdlib>

using namespace std;

int main() {
  Coordinate *c1 = NULL;
  c1 = new Coordinate;
  Coordinate *c2 = new Coordinate();

  c1->m_iX = 100;
  c1->m_iY = 200;

  (*c2).m_iX = 101;
  (*c2).m_iY = 201;

  c1->say();
  c2->say();

  delete c1;
  c1 = NULL;
  delete c2;
  c2 = NULL;
  // system("pause");
  system("read");
  return 0;
}

