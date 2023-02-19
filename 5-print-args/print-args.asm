section .data
        SYS_WRITE equ 1
	STD_OUT   equ 1
	SYS_EXIT  equ 60
	EXIT_SUCC equ 0
        
	NEW_LINE db 0xa
section .text
global _start
_start:
        ;1. dont need to save rbx, rcx, rdx
        ;2. arguments already on stack:
        ;...
        ;argv[1]   <- rsp + 16
        ;argv[0]   <- rsp + 8
        ;argc      <- rsp
        call	.printCountArgs ;3.
        ;4. though we dont pass local args, we need to remove argc from stack
        add	rsp, 8

        ;1. dont need to save rbx, rcx, rdx
        ;2. no params
        call	.printNL

.printArgsloop:
        cmp	byte [rsp], 0
        je	.exit
        call	.printArg
        call	.printNL
        add	rsp, 8
        jmp	.printArgsloop

.printCountArgs:
        push	rbp             ;1.
        mov	rbp, rsp
        ;2. mem for local var - argc
        sub	rsp, 8
        mov	rbx, rsp        ;store addres of loc var to rbx
        ;3. callee-saved
        push	rdi
        push	rsi
	;-- actuall func
        mov	rcx, [rbp + 16]  ;argc to local
        add	rcx, 48          ;conv to char
        mov	[rbx], rcx  ;put to local var
        ; print
        ; 1) dont need save rbx,rcx,rdx
        ; 2) push args to stack
        push	1               ;count of chars
        push	rbx             ;adress of buf
        call	.print
        ;4) remove parametr from stack
        add	rsp, 16         ;2 params (count of chars and addres of buf)

        ;4. dont need return rax
        ;5. restore call-svd
        pop	rsi
        pop	rdi
        ;6. dealocate local
        mov	rsp, rbp
        ;7 restore caller rbp
        pop	rbp
        
        ret

.printNL:
        push	rbp
        mov	rbp, rsp
        ; 2. no need mem for local
        ; 3. calle-saved
        push	rdi
        push	rsi
        ;--push args to stack
        push	1
        push	NEW_LINE
        call	.print
        ; remove params
        add	rsp, 16
        
        ;4. dont need return rax
        ;5. restore call-svd
        pop	rsi
        pop	rdi
        ;6. dealocate local
        mov	rsp, rbp
        ;7 restore caller rbp
        pop	rbp
        ret

.printArg:
        push	rbp             ;1.
        mov	rbp, rsp
        ; 2. dont need loc var
        ; 3. calle-saved
        push	rdi
        push	rsi
        ; -- act func
        ; dont need save rbx, rcx, rdx
        ; push arg to stack
        push	qword [rbp + 16]
        ; calc str len
        call	.strlen

        ; push args to stack
        push	rax              ;strlen
        push	qword [rbp + 16] ;argv[i]
        call	.print
        ; remove params
        add	rsp, 16

        ;4 dont need return rax
        ;5 restore call-saved
        pop	rsi
        pop	rdi
        ;6 dont need dealoca local
        mov	rsp, rbp
        ;7
        pop	rbp
        ret

.strlen:
        push	rbp             ;1.
        mov	rbp, rsp
        ; 2. no need local var
        ; 3. calle-saved
        push	rdi
        push	rsi
        ;--actually func
        mov	rax, 0          ;char count
        mov	rcx, [rbp + 16] ;argv[i] to local
.strlen.loop:
        cmp	byte [rcx], 0   ;check if str ends
        je	.strlen.ret
        inc	rax
        inc	rcx
        jmp	.strlen.loop
.strlen.ret:
        ;5 restore call-saved
        pop	rsi
        pop	rdi
        ;6 dont need dealoca local
        mov	rsp, rbp
        ;7
        pop	rbp
        ret

.print:
        push	rbp             ;1.
        mov	rbp, rsp
        ; 2. no need loc vars
        ; 3. calle-saved
        push	rdi
        push	rsi
        ;-- actually func
        mov	rax, SYS_WRITE
        mov	rdi, STD_OUT
        mov	rsi, [rbp + 16]
        mov	rdx, [rbp + 24]
        syscall
        ;4 dont need return rax
        ;5 restore call-saved
        pop	rsi
        pop	rdi
        ;6 dont need dealoca local
        mov	rsp, rbp
        ;7
        pop	rbp
        ret

.exit:
        mov	rax, SYS_EXIT
        mov	rdi, EXIT_SUCC
        syscall
