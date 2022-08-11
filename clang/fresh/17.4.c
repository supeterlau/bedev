#include <stdio.h>

#include <math.h>

int main() 
{
  float i = 0.25;

  float sin_i = sin(i);
  float sinh_i = sinh(i);
  float cos_i = cos(i);
  float cosh_i= cosh(i);
  float tan_i = tan(i);
  float tanh_i = tanh(i);
  float log_i = log(i);
  float log10_i = log10(i);
  float exp_i = exp(i);

  printf("sin(%f): %f \n", i, sin_i);
  printf("sinh(%f): %f \n", i, sinh_i);
  printf("cos(%f): %f \n", i, cos_i);
  printf("cosh(%f): %f \n", i, cosh_i);
  printf("tan(%f): %f \n", i, tan_i);
  printf("tanh(%f): %f \n", i, tanh_i);
  printf("log(%f): %f \n", i, log_i);
  printf("log10(%f): %f \n", i, log10_i);
  printf("exp(%f): %f \n", i, exp_i);
  printf("exp(16): %f \n", exp(16));
  printf("exp(2): %f \n", exp(2));  // e 的 2 次方

  return 0;
}
