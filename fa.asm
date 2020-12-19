section .data

section .bss

	buff resb 4

section .text

	global _start:
	_start:
			mov rax,1
			mov rcx,7	
		l1:
			mul rcx
			loop l1
			mov rdx,rax
			mov rsi,buff
			mov rcx,4

		l2:
			rol dx,4
			mov bl,dl

		l3:
			and bl,0fh
			cmp bl,9
			jbe l4
			add bl,7

		l4:
			add bl,48
			mov byte[rsi],bl
			inc rsi
			loop l2

			mov rax,1
			mov rdi,1
			mov rsi,buff
			mov rdx,4
			syscall

			mov rax,60
			syscall