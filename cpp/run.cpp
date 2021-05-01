#include <iostream>

using namespace std;

class Run
{
public:
  // 构造函数 参数初始化表
  Run(int i = 0) : j(i)
  {
    cout << "Run(" << i << ")" << endl;
  }
  ~Run()
  {
    cout << "~Run(" << j << ")" << endl;
  }
  int j;
};

int add(int x, int y)
{
  return x + y;
}

int main()
{
  Run x(100);
  Run y(200);
  cout << add(3, 5) << endl;
  return 0;
}
