section .data
hello: db 'From asm', 10
helloLen: equ $-hello

section .text
global _say_hi ; 对应 C 中 say_hi

_say_hi:
; mov rax,4 ; system call: write()
; mov rbx,1 ; STDOUT
; mov rcx,hello
; mov rdx,helloLen

mov rax, 0x2000004 ; write
mov rdi, 1; stdout
mov rsi, hello
mov rdx, helloLen
syscall

xor rdi, rdi ; exit code 0
syscall

; int 0x80
; int 80h
ret
