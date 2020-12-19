section .data

section .bss

	buff resb 8
	buff2 resb 5000

section .text

	global _start:
	_start:
		pop rbx
		pop rdi
		pop rdi
		mov rax,2
		mov rsi,0		;read/write status
		syscall

		mov rcx,2
		mov rsi,buff

	l1:
		rol al,4
		mov bl,al

	l2:
		and bl,0fh
		cmp bl,9
		jbe l3
		add bl,7

	l3:
		add bl,48
		mov byte[rsi],bl
		inc rsi
		loop l1
		mov byte[rsi],10
		push rax

		mov rax,1
		mov rdi,1
		mov rsi,buff
		mov rdx,9
		syscall

		pop rdi

		mov rax,0
		mov rsi,buff2
		mov rdx,5000
		syscall

		add rsi,rax
		mov byte[rsi],10
		inc rax

		mov rdx,rax
		mov rax,1
		mov rdi,1
		mov rsi,buff2
		syscall

		mov rax,60
		syscall