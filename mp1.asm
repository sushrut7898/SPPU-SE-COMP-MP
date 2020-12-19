section .data

section .bss

	buff resb 2

section .text

	global _start:
	_start:
		pop rbx
		add bl,48
		mov rsi,buff
		mov byte[rsi],bl
		inc rsi
		mov byte[rsi],10

		mov rax,1
		mov rdi,1
		mov rsi,buff
		mov rdx,2
		syscall

		pop rsi
		;pop rsi
		mov rax,1
		mov rdi,1
		mov rdx,3
		syscall		
		mov rax,60
		syscall