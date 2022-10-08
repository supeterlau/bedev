#include "Coordinate.h"
#include <iostream>

using namespace std;

Coordinate::Coordinate() {
  cout << "Coordinate: call constructor method" << endl;
}

Coordinate::~Coordinate() {
  cout << "Coordinate: call destructor method" << endl;
}

void Coordinate::say() {
  cout << "X: " << m_iX << " Y: " << m_iY << endl;
}
