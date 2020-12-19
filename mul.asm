section .data

	msg1 db 'Enter choice...'
	len1 equ $-msg1

section .bss

	buff1 resb 8
	buff2 resb 5
	cho resb 2
	
section .text

		global _start
		_start:
		mov rax,1
		mov rdi,1
		mov rsi,msg1
		mov rdx,len1
		syscall
		mov rax,0
		mov rdi,0
		mov rsi,cho
		mov rdx,2
		syscall
		cmp byte[cho],31h
		call acp
		mov al,bl
		call acp
		mov cl,bl
		mov rsi,buff1
		mov ah,0
		mov bx,0
		mov dl,8
		mov dh,0
		;cmp al,0
		;je l6
		;cmp cl,0
		;je l6
		
	l1:
		ror cl,1
		jnc l2
		add bx,ax
		
	l2:
		shl ax,1
		dec dl
		jnz l1

	l3:	
		rol bx,4
		mov al,bl
		and al,0fh
		cmp al,9
		jbe l4
		add al,7
		
	l4:
		add al,48
		mov byte[rsi],al
		inc rsi
		dec cl
		jnz l3
	
	l5:
		mov rax,1
		mov rdi,1
		mov rsi,buff1
		mov rdx,4
		syscall
		mov ax,60
		syscall
		
	acp:
			push rax
			push rcx
			push rdx
			push rsi
			push rdi
			mov rax,0
			mov rdi,0
			mov rsi,buff2
			mov rdx,3
			syscall
			dec rax
			mov rcx,rax
			mov bl,0
			mov rsi,buff2
		lab1:
			mov al,byte[rsi]
			cmp al,57
			jbe lab2
			sub al,7
			
		lab2:
			sub al,48
			shl bl,4
			add bl,al
			inc rsi
			loop lab1
			pop rdi
			pop rsi
			pop rdx
			pop rcx
			pop rax
			ret

	saa:
			