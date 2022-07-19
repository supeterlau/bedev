segment .text 
	global _start 

_start:        ; 链接入口
	mov edx, len ; 保存 msg 长度
	mov ecx, msg ; 保存 msg 首字符地址
	mov ebx, 1   ; 设置 file descriptor 为 stdout 
	mov eax, 4   ; 设置系统调用函数编号 system call number 其中 4 表示 sys_write
	int 0x80     ; 调用 kernel 执行函数
	mov eax, 1   ; 设置调用编号 1 函数 sys_exit
	int 0x80

segment .data 
; 写入内存字符串
msg db 'Hello, Assembly Language', 0xa
; 计算 msg 占用空间
len equ $ - msg
