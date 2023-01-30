section .data
        mes    db "I Love Tania! "
        .len   equ $ - mes
        cnt    equ 0
        
section .text
global _start
_start:
        mov	rbx, 0
print:
        mov	rax, 1
        mov	rdi, 1
        mov	rsi, mes
        mov	rdx, mes.len
        syscall
        add	rbx, 1
        cmp	rbx, 1000
        jne	print
        
        mov	rax, 60
        mov	rdi, 0
        syscall

