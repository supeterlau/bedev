/*
 * variadic_func.cpp
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "variadic_func.h" */

#include <iostream>
#include <cstdarg>

using namespace std;

void simple_printf(const char* fmt...)
// c 风格 (const char* fmt, ...)
{
  va_list args;
  va_start(args, fmt);

  while (*fmt != '\0') {
    if(*fmt == 'd') {
      int i = va_arg(args, int);
      cout << i << '\n';
    } else if (*fmt == 'c') {
      int c = va_arg(args, int);
      cout << static_cast<char>(c) << '\n';
    } else if (*fmt == 'f') {
      double d = va_arg(args, double);
      cout << d << '\n';
    }
    ++fmt;
  }
  va_end(args);
}

int main()
{
  simple_printf("dcff", 3, 'A', 1.999, 43.3);
  return 0;
}
