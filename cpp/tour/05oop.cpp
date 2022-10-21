#include <iostream>

using namespace std;

class Shape {
	public:
		virtual int getArea() = 0;
		void setWidth(int w) { width = w; }
		void setHeight(int h) {height = h;}
	protected:
		int width;
		int height;
};

class Rectangle: public Shape {
	public:
		int getArea() {
			return (width * height);
		}
};

class Triangle: public Shape {
	public:
		int getArea() {
			return (width * height) / 2;
		}
};

int main() {
	Rectangle rect;
	Triangle tri;

	rect.setWidth(50);
	rect.setHeight(60);
	cout << "Total Rectangle area: " << rect.getArea() << endl;

	tri.setWidth(50);
	tri.setHeight(60);
	cout << "Total Triangle area: " << tri.getArea() << endl;

	return 0;
}

