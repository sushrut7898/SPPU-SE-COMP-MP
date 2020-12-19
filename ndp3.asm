section .data

	r dw 5
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
	mov rcx,8
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
	inc	rdi
	loop l1

l3:
	mov al,'.'
	mov byte[rsi],al
	dec rsi
	inc rdi
	mov al,byte[rsi]
	mov rdx,2

l4:
	rol al,4
	mov bl,al
	and bl,0fh
	add bl,48
	mov byte[rdi],bl
	inc rdi
	dec rdx
	jnz l4
	dec rsi

	mov rax,1
	mov rdi,1
	mov rsi,buff
	mov rdx,19
	syscall
	mov rax,60
	syscall