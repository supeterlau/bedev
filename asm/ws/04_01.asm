section .text 
	global _start 

_start:
  mov ax, 0x123
	mov bx, 0x456
	add ax, bx
	add ax, ax

	; mov ax, 0x4c00
	; int 0x21 ; DOS 
	mov ax, 1
	int 0x80 ; Linux
