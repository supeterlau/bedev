#include <stdio.h>
#include <inttypes.h>

// extern int maxofthree(int, int, int);
int64_t maxofthree(int64_t, int64_t, int64_t);

int main() {
  printf("Max of [1, -4, -7] %lld\n", maxofthree(1, -4, -7));
  printf("Max of [10, -4, -7] %lld\n", maxofthree(10, -4, -7));
  printf("Max of [-1, -4, -7] %lld\n", maxofthree(-1, -4, -7));
  printf("Max of [1, 4, 7] %lld\n", maxofthree(1, 4, 7));
  return 0;
}
