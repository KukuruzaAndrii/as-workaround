section .data
message:
        db	 "Hello, world", 10
.len: equ $ - message
        
section .text
global _start
_start:
        
        mov	rax, 1
        mov	rdi, 1
        mov	rsi, message
        mov	rdx, message.len 
        syscall
        
        mov	rax, 60
        mov	rdi, 0
        syscall
