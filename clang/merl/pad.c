#include <stdio.h>
#include <limits.h>
#include <stdint.h>

// for int: 4 byte 

typedef struct Students {
	char a; // 1 byte
	char b; // 1 byte
	int c;  // 4 bytes
} Student;

// a 占 1 byte 
// 余下 3 bytes 无法放下 int 
// int 跳过 3 bytes 占用下一个 4 byte
typedef struct Students1 {
	char a; // 1 byte
	// int c;  // 4 bytes
	// uint8_t c;
	// uint64_t d;
	uint32_t c;
	char b; // 1 byte
} Student1;

struct A {
	int i;
	struct B *p;
};

struct B {
	long l;
	char *s[0];
};

typedef struct {
	int i;
	struct B *p;
} C;

union int_or_char {
	int a;
	char b;
} var;

int main() {
#ifdef __x86_64
printf("x86 f64()\n");
#else
#ifdef _M_AMD64
printf("amd f64()\n");
#else
printf("f32()\n");
#endif
#endif
printf("Size of %10s: %18lu\n", "int", sizeof(int));
printf("Size of %10s: %18lu\n", "uint64_t", sizeof(uint64_t));
	Student student;
	// 8 bytes
	printf("Sizeof student: %lu\n", sizeof(student));

	Student1 student1;
	// 12 bytes int
	// 16 bytes uint64_t
	// 3 uint8_t
	// 32 uint8_t + uint64_t
	// uint32_t 32位 : 12 / 64位 : 6 
	printf("Sizeof student1: %lu\n", sizeof(student1));

	// struct 序列化

	// union
	// The size of the union is based on the size of the largest member of the union
	var.a = 66;
	printf("a = %d\n", var.a);
	printf("b = %d\n", var.b);
	printf("b = %c\n", var.b);

	C varc;
	varc.i = 999;
	printf("varc.i : %d\n", varc.i);
	return 0;
}
