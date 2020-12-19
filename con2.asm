section .bss
buff1	resb 21

section .text

	global _start
	_start:
			mov rax,0
			mov rdi,0
			mov rsi,buff1
			mov rdx,21
			syscall
			dec rax
			push rax
			mov rsi,buff1
			add rsi,rax
			mov rax,0
			mov rdi,0
			mov rdx,20
			syscall
			dec rax
			pop rdx
			add rdx,rax

		l2:
			mov rax,1
			mov rdi,1
			mov rsi,buff1
			syscall

			mov rax,60
			syscall