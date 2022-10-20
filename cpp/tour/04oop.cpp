/* #include <iostream> */

/* using namespace std; */

/* int main() { */
/* 	return 0; */
/* } */

#include <iostream>

using namespace std;

class Adder {
	public:
		Adder(int i = 0) {
			total = i;
		}
		void addNum(int number) {
			total += number;
		}

		int getTotal() {
			return total;
		}
	private:
		int total;
};

int main() {
	Adder adder;
	adder.addNum(100);
	adder.addNum(200);
	adder.addNum(300);
	cout << "Total: " << adder.getTotal() << endl;
	return 0;
}
