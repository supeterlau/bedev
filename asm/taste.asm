global _start ; 入口函数

section .data
  query_string : db "Enter a character: "
  query_string_len : equ $ - query_string
  out_string : db "You have input: "
  out_string_len : equ $ - out_string

section .bss
  in_char: resw 4

section .text

_start:
  mov rax, 0x2000004 ; syscall 参数 表示 write
  mov rdi, 1 ; 代表 stdout
  mov rsi, query_string ; rsi 获取字符 
  mov rdx, query_string_len ; rdx 获取长度
  syscall

  mov rax, 0x2000003 ; syscall 参数 表示 read
  mov rdi, 0 ; 代表 stdin
  mov rsi, in_char
  mov rdx, 2 ; 从内核读取 2 字节 字符和回车
  syscall

  mov rax, 0x2000004 ; 打印输入值
  mov rdi, 1
  mov rsi, out_string
  mov rdx, out_string_len
  syscall

  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, in_char
  mov rdx, 2 ; 2 字节 第二个是回车
  syscall 

  mov rax, 0x2000001 ; syscall 参数 表示退出 syscall
  mov rdi, 0
  syscall
