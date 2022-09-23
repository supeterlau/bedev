/*
 * pointer.c
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "pointer.h" */

#include <stdio.h>

void pp(int *p) {
  /* printf("Address of pointer: %x\n", *p); */
  printf("Address of pointer: %p\n", (void *)p);
}

void print_pointer() {
  int number = 50;
  int *p;
  p = &number;
  pp(p);
  /* printf("Address of pointer: %x\n", p); */
  /* printf("Address of pointer: %p\n", (void *)p); */
  printf("Value of pointer is %d\n", *p);
}

int add(int x, int y) {
  printf("Address of x: %p\n", (void *) &x);
  printf("Address of y: %p\n", (void *) &y);
  int z = x + y;
  printf("Address of z (add): %p\n", (void *) &z);

  return x + y;
}

typedef struct Pointer {
  int x;
  int y;
} Pointer;

void structp() {
  Pointer p;
  p.x = 100;
  p.y = 200;
  Pointer *sp = &p;
  printf("Via structure pointer x: %d\n", sp->x);
  printf("Via structure pointer y: %d\n", sp->y);

  // scanf("%s",&s1.name);
}

typedef struct PackedPad {
  char a;
  int b;
  char c;
}__attribute__((packed)) PackedPad;

typedef struct Pad {
  char a;
  int b;
  char c;
} Pad;

void arithmetic() {
  // increment
  int num = 50;
  int *pnum;
  pnum = &num;
  /* printf("Address of num: %u\n", pnum); */
  printf("Address of num: %p\n", (void *)pnum);
  pnum += 1; // add 4 bytes
  /* printf("incr Address of num: %u\n", pnum); */
  printf("incr\nAddress of num: %p\n", (void *)pnum);
  pnum += 3; // add 3 more
  printf("add 3*4bytes\nAddress of num: %p\n", (void *)pnum);

  // 遍历数组的原理
  int arr[5] = {100, 200, 300, 400, 500};
  int *parr = arr; // arr 是第一个元素指针
  int i;
  printf("Print array elements: \n");
  for(i = 0; i<5; i++) {
    printf("%d\n", *(parr+i));
  }


  // decrement 
  // addition
  // subtraction
  // comparison
}

void pointer_to_pointer() {
  int base[10] = {101, 102, 103,104,105,106};
  int *pbase[] = {base, base+1, base+2, base+3, base+4, base+5};
  int **ppbase = pbase;

  ppbase++;
  printf("%ld %ld %d\n", ppbase-pbase, *ppbase-base, **ppbase);
  printf("%ld\n", &(pbase[1])-pbase);
}
int main()
{
  printf("Address of main(): %p\n", (void *) main);

  printf("Address of add(): %p\n", (void *) add);

  int z = add(100, 200);
  printf("Address of z: %p\n", (void *) &z);
  /* printf("Gap: %d\n", (int) *&z - ) */

  /* print_pointer(); */

  /* structp(); */

  /* Pad pad1; */
  /* printf("Size of Pad structure: %lu\n", sizeof(pad1)); */
  /* PackedPad pad2; */
  /* printf("Size of Pad structure: %lu\n", sizeof(pad2)); */

  /* arithmetic(); */

  pointer_to_pointer();

  return 0;
}
