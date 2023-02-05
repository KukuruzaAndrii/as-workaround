section .data
        SYS_WRITE equ 1
        STD_OUT equ 1
        SYS_EXIT equ 60
        EXIT_SUC equ 0
        NL db 10
        INPUT db "hello world"

section .bss
        OUTPUT resb 12
section .text
global _start
_start:
        mov	rsi, INPUT
        mov	rcx, 0
        cld	
        mov	rdi, $ + 15
        call	.calcStrLen
        mov	rax, 0
        mov	rdi, 0
        jmp	.reverseStr

.calcStrLen:
        cmp	byte [rsi], 0
        je	.exitStrLen
        lodsb
        push	rax
        inc	rcx
        jmp	.calcStrLen
.exitStrLen:
        push	rdi
        ret
.reverseStr:
        cmp	rcx, 0
        je	.printRes
        pop	rax
        mov	[OUTPUT + rdi], rax
        dec	rcx
        inc	rdi
        jmp	.reverseStr

.printRes:
       


        mov	rdx, rdi
        mov	rax, SYS_WRITE
        mov	rdi, STD_OUT
        mov	rsi, OUTPUT
        syscall
        
        mov	rax, SYS_EXIT
        mov	rdi, 0
        syscall
