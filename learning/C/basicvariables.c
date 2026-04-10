#include <stdio.h>

int main() {
  int a = 3;
  float b = 4.5;
  double c = 5.25;
  float sum;

  sum = a+b+c;

  // %f is is a specifier saying that sum is a floating point number and to treat it as such
  printf("The sum of a, b, and c is %f.", sum);
  return 0;
}