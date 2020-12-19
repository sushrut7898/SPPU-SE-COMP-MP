section .data

	m1 db 'Enter 2-digit Hex number',10
	len1 equ $-m1
	m2 db 'The BCD equivalent is - ',10
	len2 equ $-m2

section .bss

	buff resb 5

section .text

	global _start
	_start:
			mov rax,1
			mov rdi,1
			mov rsi,m1
			mov rdx,len1
			syscall
			call acp
			mov al,bl
			mov ah,0
			mov rbx,0

		ll1:
			cmp al,64h
			jb ll2
			sub al,64h
			add bx,100h
			jmp ll1

		ll2:
			cmp al,0Ah
			jb ll3
			sub al,0Ah
			add bx,10h
			jmp ll2

		ll3:
			add bx,ax
			push rbx
			mov rax,1
			mov rdi,1
			mov rsi,m2
			mov rdx,len2
			syscall
			pop rbx
			call disp
			mov rax,60
			syscall

		acp:
			push rax
			push rcx
			push rdx
			push rsi
			push rdi
			mov rax,0
			mov rdi,0
			mov rsi,buff
			mov rdx,3
			syscall
			dec rax
			mov rcx,rax
			mov bl,0
			mov rsi,buff
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

		disp:
			push rax
			push rcx
			push rdx
			push rsi
			push rdi

			mov rsi,buff
			mov rcx,4
		l1:
			rol bx,4
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
			mov rdx,5
			syscall
			
			pop rdi
			pop rsi
			pop rdx
			pop rcx
			pop rax
			ret