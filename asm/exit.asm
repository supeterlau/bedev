section .data

section .text
	global _start 

mov eax, 1
mov ebx, 4

int 0x80 
