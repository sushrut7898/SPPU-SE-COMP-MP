section .data

	a dw 1
	b dw 4
	c dw 4
	d dw 4
	e dw 2
	f dw 100
	m1 db "The 1st root is:",10
	len1 equ $-m1
	m2 db 10,"The 2nd root is:",10
	len2 equ $-m2

section .bss

	det resb 10
	dst resb 10
	rt1 resb 10
	rt2 resb 10
	buff resb 22

section .text

	global _start:
	_start:

		fild word[b]
		fmul st0,st0
		fild word[a]
		fimul word[c]
		fimul word[d]
		fsub
		fsqrt
		fbstp [dst]
		fimul word[f]
		fbstp [det]

		fldz
		fisub word[b]
		fiadd word[dst]
		fidiv word[a]
		fidiv word[e]
		fimul word[f]
		fbstp [rt1]

		fldz
		fisub word[b]
		fisub word[dst]
		fidiv word[a]
		fidiv word[e]
		fimul word[f]
		fbstp [rt2]

		mov rsi,rt1
		mov rdi,buff
		mov rcx,9
		add rsi,9

	l1:
		mov al,byte[rsi]
		mov rdx,2

	l2:
		rol al,4
		mov bl,al
		and bl,0fh
		add bl,48
		mov byte[rdi],bl
		inc rdi
		dec rdx
		jnz l2
		dec rsi
		loop l1

		mov byte[rdi],'.'
		mov al,byte[rsi]
		inc rdi

		mov rdx,2
	l3:	rol al,4
		mov bl,al
		and bl,0fh
		add bl,48
		mov byte[rdi],bl
		inc rdi
		dec rdx
		jnz l3
		dec rsi

		mov rax,1
		mov rdi,1
		mov rsi,m1
		mov rdx,len1
		syscall

		mov rax,1
		mov rdi,1
		mov rsi,buff
		mov rdx,22
		syscall

		mov rsi,rt2
		mov rdi,buff
		mov rcx,9
		add rsi,9

	l4:
		mov al,byte[rsi]
		mov rdx,2

	l5:
		rol al,4
		mov bl,al
		and bl,0fh
		add bl,48
		mov byte[rdi],bl
		inc rdi
		dec rdx
		jnz l5
		dec rsi
		loop l4

		mov byte[rdi],'.'
		mov al,byte[rsi]
		inc rdi

		mov rdx,2
	l6:	rol al,4
		mov bl,al
		and bl,0fh
		add bl,48
		mov byte[rdi],bl
		inc rdi
		dec rdx
		jnz l6
		dec rsi

		mov rax,1
		mov rdi,1
		mov rsi,m2
		mov rdx,len2
		syscall

		mov rax,1
		mov rdi,1
		mov rsi,buff
		mov rdx,22
		syscall

		mov rax,60
		syscall