section .data
	fname db "temp.txt",00H

global buff
global cntr
extern far_count
 
section .bss
	buff : resb 1024
	fhandle: resq 1
	cntr : resw 1




section .text

global _start

	_start:
	mov rax,02
	mov rdi,fname
	mov rsi,02
	mov rdx,0777O
	syscall

	mov [fhandle],rax

	mov rax,0
	mov rdi,[fhandle]
	mov rsi,buff
	mov rdx,1024
	syscall	

	mov [cntr],ax

mov rax,03H
mov rdi,[fhandle]
syscall

	call far_count

mov rax,60
mov rdi,0
syscall

