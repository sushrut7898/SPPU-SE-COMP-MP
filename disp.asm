section .data

section .bss

	buff resb 17

section .text

	global _start
	_start:
	mov rbx,0123456789abcdefh
	call disp

	mov rax,60
	syscall

	disp:
			push rax
			push rcx
			push rdx
			push rsi
			push rdi

			mov rsi,buff
			mov rcx,16
		l1:
			rol rbx,4
			mov al,bl
			and al,0fh
			cmp al,9
			jbe l2
			add al,7
		l2:
			add al,48
			mov byte[rsi],al
			inc rsi
			loop l1
			mov byte[rsi],10
		l3:
			mov rax,1
			mov rdi,1
			mov rsi,buff
			mov rdx,17
			syscall
			
			pop rdi
			pop rsi
			pop rdx
			pop rcx
			pop rax
			ret