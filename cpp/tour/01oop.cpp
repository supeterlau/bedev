#include <iostream>

using namespace std;

class Shape {
	public:
		void setWidth(int w) {width = w;}
		void setHeight(int h) {height = h;}
	protected:
		int width;
		int height;
};

class Cost {
	public:
		int getCost(int area) {return area * 6;}
};

class Rectangle: public Shape, public Cost {
	public:
		int getArea() {return (width * height);}
};

int main(void) {
	Rectangle rect;
	rect.setWidth(50);
	rect.setHeight(80);
	cout << "Area: " << rect.getArea() << endl;
	cout << "Area Cost: " << rect.getCost(rect.getArea()) << endl;
	return 0;
}
