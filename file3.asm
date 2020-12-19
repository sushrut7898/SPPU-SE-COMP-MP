section .data

section .bss

	buff resb 5000
	ct resq 1

section .text

	global _start:
	_start:

		pop rdi
		pop rdi
		pop rdi

		mov rax,2
		mov rsi,0
		syscall

		mov rdi,rax
		mov rax,0
		mov rsi,buff
		mov rdx,5000
		syscall

		mov qword[ct],rax
		pop rdi

		mov rax,2
		mov rsi,65
		mov rdx,180h
		syscall

		mov rdi,rax
		mov rax,1
		mov rsi,buff
		mov rdx,qword[ct]
		syscall

		mov rax,60
		syscall