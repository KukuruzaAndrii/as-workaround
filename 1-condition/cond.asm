section .data
corr: db "sum is 150", 10
.len: equ $ - corr
incorr: db "sum is not 150", 10
.len: equ $ - incorr
n1: equ 100
n2: equ 50

        
section .text
global _start
_start:
        mov	rax, n1
        mov	rbx, n2
        add	rax, rbx
        cmp	rax, 150
        je	.printeq
        jne	.printneq
        

.printneq:
        mov	rax, 1
        mov	rdi, 1
        mov	rsi, incorr
        mov	rdx, incorr.len 
        syscall
        jmp	.exit

.printeq:
        mov	rax, 1
        mov	rdi, 1
        mov	rsi, corr
        mov	rdx, corr.len 
        syscall
        jmp	.exit


.exit:
        mov	rax, 60
        mov	rdi, 0
        syscall

