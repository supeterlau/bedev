// Overloading

#include <iostream>
#include <cstring>
#include <string>

using namespace std;

class PrintData {
	public:
		void print(int value) {
			cout << "Printing int: " << value << endl;
		}
		void print(double value) {
			cout << "Printing double: " << value << endl;
		}
		void print(char* value) {
			cout << "Printing characters: " << value << endl;
		}
		void print(const char* value) {
			cout << "Printing characters: (with const) " << value << endl;
		}
};

class Box {
	public:
		double getVolume() {return length * breadth * height;}
		Box(){};
		Box(double l, double b, double h): length(l), breadth(b), height(h) {}
		Box operator+(const Box& b) {
			Box box;
			box.length = this->length + b.length;
			box.breadth = this->breadth + b.breadth;
			box.height = this->height + b.height;
			return box;
		}
	private:
		double length;
		double breadth;
		double height;
};

int main() {
	PrintData print;
	print.print(50);
	print.print(1.27);

	string s = "C++ Nice";
	char c[s.length() + 1];
	// char* c;
	strcpy(c, s.c_str());
	// print.print("C++ World");
	print.print(c);

	char* c1;
	string s1("C++ Nice 2");
	c1 = &s1[0];
	print.print(c1);

	string s2 = "C++ Nice 3";
	const char* c2 = s2.c_str();
	print.print(c2);

	Box box1(1.1,2.2,3.3);
	Box box2(1.2,3.4,5.6);

	Box box3;
	box3 = box1 + box2;
	cout << "box3 volume: " << box3.getVolume() << endl;
	return 0;
}
