
int foo(int x) {
  return x + 1;
}

int bar(int y) {
  return y * 2;
}

// int fibonacci(int nth) {
unsigned long long factorial(int nth) {
  unsigned long long f = 1;
  if(nth <= 0)
    return 0;
  else {
    for (int i = 1; i <= nth; ++i) {
      f *= i;
    }
    return f;
  }
}
