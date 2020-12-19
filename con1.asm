section .bss
	buff1 resb 21
	buff2 resb 11

section .text

	global _start
	_start:
			mov rax,0
			mov rdi,0
			mov rsi,buff1
			mov rdx,21
			syscall
			dec rax
			mov rcx,rax
			mov rdi,buff1
			add rdi,rax
			mov rax,0
			mov rdi,0
			mov rsi,buff2
			mov rdx,11
			syscall
			dec rax
			mov rbx,rax
			add rcx,rbx
			mov rsi,buff2

		l1:
			mov dl,byte[rsi]
			mov byte[rdi],dl
			inc rsi
			inc rdi
			dec rbx
			jnz l1

		l2:
			mov rax,1
			mov rdi,1
			mov rsi,buff1
			mov rdx,rcx
			syscall

			mov rax,60
			syscall
