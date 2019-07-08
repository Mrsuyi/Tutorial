#include <stdio.h>

#define VA_ARGS1(vars...) printf(vars)
#define VA_ARGS2(first, ...) \
  printf(first, __VA_ARGS__)  // this cannot handle empty args
#define VA_ARGS3(first, ...) printf(first, ##__VA_ARGS__)

int main() {
  VA_ARGS1("%d\n%d\n", 100, 200);
  // VA_ARGS2("empty");
  VA_ARGS3("%d\n%d\n", 300, 400);

  return 0;
}
