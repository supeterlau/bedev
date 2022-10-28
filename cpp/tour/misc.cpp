// https://www.tutorialspoint.com/cplusplus/cpp_exceptions_handling.htm
// https://www.tutorialspoint.com/cplusplus/cpp_dynamic_memory.htm
// https://www.tutorialspoint.com/cplusplus/cpp_templates.htm
// https://www.tutorialspoint.com/cplusplus/cpp_preprocessor.htm

// STL

#include <iostream>
#include <exception>
#include <vector>
#include <cstdlib>
#include <string>
#include <stdexcept>

using namespace std;

double division(int a, int b) {
	if (b == 0 ) {
		throw "Division by zero condition";
	}
	return a / b;
}

struct MiscException: public exception {
	const char* what() const throw () {
		return "Misc Custom Exception.";
	}
};

// Dynamic Memory Allocation
class Box {
	public:
		Box() {
			cout << "Constructor called!" << endl;
		}
		~Box() {
			cout << "Destructor called!" << endl;
		}
};

// Template

template <typename T>
inline T const& get_max(T const& a, T const&b) {
	return a < b ? b : a;
}

template <class T>
class Stack {
	private:
		vector<T> elems;
	public:
		void push(T const&);
		void pop();
		T top() const;
		bool empty() const {
			return elems.empty();
		}
};

template <class T>
void Stack<T>::push (T const& elem) {
	elems.push_back(elem);
}

template <class T>
void Stack<T>::pop () {
	if (elems.empty()) {
		throw out_of_range("Stack<>::pop(): empty stack");
	}
	elems.pop_back();
}

template <class T>
T Stack<T>::top () const {
	if (elems.empty()) {
		throw out_of_range("Stack<>::pop(): empty stack");
	} return elems.back();
}

#define PI 3.1415926

// gcc -E test.cpp > test.p

#define MIN(a, b) (((a)<(b)) ? a : b)

// ifndef NULL
// define NULL 0
// endif

// if 0
#ifdef DEBUG
cerr <<"Variable x = " << x << endl;
#endif

#define MKSTR( x ) #x

#define CONCAT(x, y, z) x ## y ## z

int main() {
	try {
		cout << "division(10, 2): " << division(10, 2) << endl;
		// floating point exception
		cout << "division(10, 0): " << division(10, 0) << endl;
	} catch (const char* msg) {
		cerr << msg << endl;
	}

	try {
		throw MiscException();
	} catch (MiscException& e) {
		cout << "Caught MiscException" << endl;
		cout << e.what() << endl;
	}

	Box* boxArray = new Box[10];
	delete []boxArray;

	int ii = 30;
	int ji = 50;
	cout << "get_max(ii,ji): " << get_max(ii, ji) << endl;

	double id = 300.3;
	double jd = 500.5;
	cout << "get_max(id, jd): " << get_max(id, jd) << endl;

	// #include <string>
	string is = "Ecosystem";
	string js = "App";
	cout << "get_max(is,js): " << get_max(is, js) << endl;

	try {
		Stack<int> intStack;
		Stack<string> strStack;

		intStack.push(49);
		cout << "Get top of intStack: " << intStack.top() << endl;

		strStack.push("Big");
		cout << "Get top of strStack: " << strStack.top() << endl;
		strStack.pop();
		strStack.pop();
	} catch (exception const& ex) {
		cerr << "Exception: " << ex.what() << endl;
		// return -1;
	}

	cout << "Value of PI: " << PI << endl;

	int min_i = 100;
	int min_j = 300;
	cout << "MIN(min_i, min_j): " << MIN(min_i, min_j) << endl;

	cout << MKSTR(BOOM) << endl;

	int xyz = 10000;
	cout << CONCAT(x, y, z) << endl;
	return 0;
}

