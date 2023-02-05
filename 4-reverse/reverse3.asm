section .data
        SYS_WRITE equ 1
        STD_OUT equ 1
        SYS_EXIT equ 60
        EXIT_SUC equ 0
        NL equ 10
        wrongArgsMes db "Expect only one arg - string to reverse", NL
        wrongArgsMesLen equ $ - wrongArgsMes
section .bss
        OUTPUT resb 12
section .text
global _start
_start:
        pop	rax
        cmp	rax, 2
        jne	.errorArgs
        
        add	rsp, 8
        pop	rax
        mov	rsi, rax
        mov	rcx, 0
        cld

.calcStrLen:
        cmp	byte [rsi], 0
        je	.exitStrLen
        lodsb
        push	rax
        inc	rcx
        jmp	.calcStrLen        
        
.exitStrLen:
        mov	rax, 0
        mov	rdi, 0

.reverseStr:
        cmp	rcx, 0
        je	.printRes
        pop	rax
        mov	[OUTPUT + rdi], rax
        dec	rcx
        inc	rdi
        jmp	.reverseStr

.printRes:
        mov	byte [OUTPUT + rdi], NL
        inc	rdi
        mov	rdx, rdi
        mov	rax, SYS_WRITE
        mov	rdi, STD_OUT
        mov	rsi, OUTPUT
        syscall
        jmp	.exit

.errorArgs:
        mov	rax, SYS_WRITE
        mov	rdi, STD_OUT
        mov	rsi, wrongArgsMes
        mov	rdx, wrongArgsMesLen
        syscall
        jmp	.exit
.exit:
        mov	rax, SYS_EXIT
        mov	rdi, EXIT_SUC
        syscall
