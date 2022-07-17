            global  _start  

            section .text

_start:     mov     rax, 1 ; 写入的系统调用
            mov     rdi, 1 ; file handle 1 即标准输出
            mov     rsi, message ; 输出的字符串地址
            mov     rdx, 13 ; 输出字符串 bytes 数
            syscall ; 调用写入指令
            mov     rax, 60 ; 退出的系统调用
            xor     rdi, rdi ; 退出返回值 0
            syscall ; 调用退出指令

            section .data
message:    db      "Hello World", 10