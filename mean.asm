section .data

	me dd 13.9,15.9,17.9,19.9,21.9
	s dw 100
	t dw 5
	mean dd 0,0

section .bss

	r resb 3
	buff resb 5
	v resb 4
	sd resb 4

section .text

	global _start:
	_start:
			mov rsi,me
			mov rcx,5
			fldz

		l1:
			fadd dword[rsi]
			add rsi,4
			loop l1

			fidiv word[t]
			fst dword[mean]
			fild word[s]
			fmul
			fbstp [r]
			mov rsi,r
			mov rdi,buff
			mov rcx,4
			add rsi,3

		l2:
			mov al,byte[rsi]
			mov rdx,2

		l3:
			rol al,4
			mov bl,al
			and bl,0fh
			add bl,48
			mov byte[rdi],bl
			inc rdi
			dec rdx
			jnz l3
			dec rsi
			cmp	rcx,2
			jne	l10
			mov	byte[rdi],'.'
			inc	rdi
		l10:
			loop l2
			mov byte[rdi],10

			mov rax,1
			mov rdi,1
			mov rsi,buff
			mov rdx,12
			syscall

			fldz
			mov rsi,me
			mov rcx,5
		l4:
			fld dword[mean]
			fsub dword[rsi]
			fmul st0,st0
			fadd
			add rsi,4
			loop l4
			fidiv word[t]
			fild word[s]
			fmul
			fbstp [v]

			mov rsi,v
			mov rdi,buff
			mov rcx,2
			add rsi,1

		l5:
			mov al,byte[rsi]
			mov rdx,2

		l6:
			rol al,4
			mov bl,al
			and bl,0fh
			add bl,48
			mov byte[rdi],bl
			inc rdi
			dec rdx
			jnz l6
			dec rsi
			cmp	rcx,2
			jne	l11
			mov	byte[rdi],'.'
			inc	rdi
		l11:
			loop l5
			mov byte[rdi],10

			mov rax,1
			mov rdi,1
			mov rsi,buff
			mov rdx,6
			syscall

			fld dword[v]
			fsqrt
			fbstp [sd]

			mov rsi,sd
			mov rdi,buff
			mov rcx,2
			add rsi,1

		l7:
			mov al,byte[rsi]
			mov rdx,2

		l8:
			rol al,4
			mov bl,al
			and bl,0fh
			add bl,48
			mov byte[rdi],bl
			inc rdi
			dec rdx
			jnz l8
			dec rsi
			cmp	rcx,2
			jne	l12
			mov	byte[rdi],'.'
			inc	rdi
		l12:
			loop l7
			mov byte[rdi],10

			mov rax,1
			mov rdi,1
			mov rsi,buff
			mov rdx,6
			syscall

			mov rax,60
			syscall
