section .data

	file db "txt.text",0
	msg db 10,"No. of lines is:- "
	msglen equ $-msg

section .bss

	buff resb 5000
	buff2 resb 8

section .text

	global _start:
	_start:

		mov rax,2
		mov rdi,file
		mov rsi,0		;read/write status
		syscall
		
		mov rax,0
		mov rdi,3
		mov rsi,buff
		mov rdx,5000
		syscall

		mov rcx,rax
		mov bl,1
		mov rsi,buff

	l1:
		cmp byte[rsi],10
		jne l2
		inc bl

	l2:
		inc rsi
		loop l1

		mov rcx,2
		mov rsi,buff2

	l3:
		rol bl,4
		mov al,bl

	l4:
		and al,0fh
		cmp al,9
		jbe l5
		add al,7

	l5:
		add al,48
		mov byte[rsi],al
		inc rsi
		loop l3

		mov rax,1
		mov rdi,1
		mov rsi,msg
		mov rdx,msglen
		syscall

		mov rax,1
		mov rdi,1
		mov rsi,buff2
		mov rdx,8
		syscall

		

		mov rax,60
		syscall