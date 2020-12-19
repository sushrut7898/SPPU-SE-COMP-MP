section .data

	r dw 10
	s dw 100

section .bss

	a resb 10
	buff resb 19

section .text

	global _start:
	_start:
	fild word[r]
	fmul st0,st0
	fldpi
	fmul
	fild word[s]
	fmul
	;fimul [s]
	fbstp [a]

	mov rsi,a
	mov rdi,buff
	mov rcx,9
	add rsi,8

l1:
	mov al,byte[rsi]
	mov rdx,2

l2:
	rol al,4
	mov bl,al
	and bl,0fh
	add bl,48
	mov byte[rdi],bl
	inc rdi
	dec rdx
	jnz l2
	dec rsi
	cmp	rcx,2
	jne	l10
	mov	byte[rdi],'.'
	inc	rdi
l10:
	loop l1

	mov rax,1
	mov rdi,1
	mov rsi,buff
	mov rdx,19
	syscall
	mov rax,60
	syscall