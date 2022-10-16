#include <iostream>

using namespace std;

class Box {
	double duration;
	public:
	  // 只声明，不能初始化
	  // static int boxCount 0;
  	static int boxCount;
		double length;
		double breadth;
		double height;
		// constructor
		Box();
		Box(double len);
		// void setLength(double len);
		void setLength(double value); // OK
		double getLength(void);
		double calc_volumn() {
			return length * breadth * height;
		};
		friend void printDuration(Box box);
		void setDuration(double duration);
		static int getCount () { return boxCount; }
		~Box();
};

int Box::boxCount = 0;

void Box::setDuration(double value) {
	duration = value;
}

// error: duration is private
// void displayBoxDuration(Box box) {
// 	cout << "Duration of box: " << box.duration << endl;
// }

void printDuration(Box box) {
	cout << "Duration of box: " << box.duration << endl;
}

// 初始化函数没有返回值
Box::Box(void) {
	cout << "Created New Object" << endl;
	boxCount++;
}

// Box::Box(double len) {
// 	cout << "Created New Object with: Length " << len << endl;
// 	length = len;
// }

// 上边函数的简化形式

Box::Box(double len): length(len) {
	cout << "Created New Object with: Length " << len << endl;
	boxCount++;
}

// C::C( double a, double b, double c): X(a), Y(b), Z(c) {
// ....
// }

// setter getter

void Box::setLength(double value) {
	length = value;
}

double Box::getLength(void) {
	return length;
}

Box::~Box(void) {
	cout << "[Box] delete Object" << endl;
}

class Line {
	public:
		int getLength(void);
		Line(int len);
		Line(const Line &obj);
		~Line();
	private:
		int *ptr;
};

Line::Line(int len) {
	cout << "Normal constructor allocating ptr" << endl;
	ptr = new int;
	*ptr = len;
}

Line::Line(const Line &obj) {
	cout << "Copy constructor allocating ptr." << endl;
	ptr = new int;
	*ptr = *obj.ptr; // copy value
}

Line::~Line(void) {
	cout << "[Line] Freeing memory!" << endl;
	delete ptr;
}

int Line::getLength(void) {
	return *ptr;
}

void display(Line obj) {
	cout << "Length of line: " << obj.getLength() << endl;
}

inline int Max(int x, int y) { return (x > y) ? x : y; }

int main() {
	/*
	// Box box1;
	Box box1(30.0);
	Box box2;

	box1.length = 5.1;
	box1.breadth = 6.2;
	box1.height = 7.3;

	box2.length = 15.1;
	box2.breadth = 16.2;
	box2.height = 17.3;
	
	cout << "Volumn of box1: " << box1.calc_volumn() << endl;
	cout << "Volumn of box2: " << box2.calc_volumn() << endl;

	box1.setLength(99.9);
	cout << "[After] Volumn of box1: " << box1.calc_volumn() << endl;

	// Line

	Line line1(10);

	Line line2 = line1;

	cout << "Display line1" << endl;
	display(line1);
	cout << "Display line2" << endl;
	display(line2);

	cout << "End." << endl;
	*/

	/* Box *box = new Box(1); */
	Box box;
	box.setDuration(99.9);
	// displayBoxDuration(box);
	printDuration(box);
	cout << "Max (20, 30): " << Max(20,30) << endl;
	cout << "Total boxes: " << Box::boxCount << endl;
	Box box1;
	cout << "Total boxes: " << Box::getCount() << endl;
	return 0;
}
