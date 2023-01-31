section .data
        SYS_WRITE equ 1
        STD_IN    equ 1
        SYS_EXIT  equ 60
        NL        equ 10
        WRONG_ARGS_MES db "Must be two arguments", NL
        WAMES_len equ $ - WRONG_ARGS_MES
        ASCII_DIFF_CHAR_NUM equ 48

section .text
global _start
_start:
        pop	rcx
        cmp	rcx, 3
        jne	.argsError

        add	rsp, 8
        pop	rsi
        call	.str_to_int

        mov	r10, rax
        pop	rsi
        call	.str_to_int
        mov	r11, rax

        add	r10, r11
        mov	rax, r10
        mov	r12, 0
        push	NL              ;add \n
        jmp	.int_to_str

        jmp	.exit
        
        
.str_to_int:
        mov	rax, 0
        mov	rcx, 10
.str_to_int.next:        
        cmp	[rsi], byte 0
        je	.str_to_int.ret
        mov	bl, [rsi]
        sub	bl, ASCII_DIFF_CHAR_NUM
        mul	rcx
        add	rax, rbx
        inc	rsi
        jmp	.str_to_int.next
.str_to_int.ret:
        ret

.int_to_str:
        mov	rdx, 0
        mov	rbx, 10
        div	rbx
        add	rdx, ASCII_DIFF_CHAR_NUM
        push	rdx
        inc	r12
        cmp	rax, 0x0
        jne	.int_to_str
        jmp	.print

.print:
        mov	rax, r12
        inc	rax             ;for additional \n
        mov	r12, 8
        mul	r12

        mov	rdx, rax
        mov	rax, SYS_WRITE
        mov	rdi, STD_IN
        mov	rsi, rsp
        syscall
        jmp	.exit

.argsError:
        mov	rax, SYS_WRITE
        mov	rdi, STD_IN
        mov	rdx, WAMES_len
        mov	rsi, WRONG_ARGS_MES
        syscall
        jmp	.exit
        
.exit:
        mov	rax, SYS_EXIT
        mov	rdi, 0
        syscall
