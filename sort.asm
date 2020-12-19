section .data

	arr db 5,4,3,2,1

section .bss

	buff resb 10

section .text

	global _start:
	_start:

		mov rcx,4

	l0:
		mov rsi,arr
		mov rdx,4
	l1:
		mov al,byte[rsi]
		mov bl,byte[rsi + 1]
		cmp al,bl
		jb l2
		mov byte[rsi + 1],al
		mov byte[rsi],bl
	l2:
		inc rsi
		dec rdx
		jnz l1
		loop l0

		mov rsi,arr
		mov rdi,buff
		mov rcx,5

	l3:
		mov al,byte[rsi]
		and al,0fh
		add al,48
		mov byte[rdi],al
		inc rsi
		inc rdi
		mov byte[rdi]," "
		inc rdi
		loop l3
		mov byte[rdi],10

		mov rax,1
		mov rdi,1
		mov rsi,buff
		mov rdx,11
		syscall

		mov rax,60
		syscall
