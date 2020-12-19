section .data

section .bss

	buff resb 3

section .text

	global _start
	_start:
			call acp
			mov al,bl
			mov rbx,0

		ll1:
			cmp al,10h
			jb ll2
			sub al,10h
			add bl,10
			jmp ll1

		ll2:
			add bl,al
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
			mov rcx,2
		l1:
			rol bl,4
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
			mov rdx,3
			syscall
			
			pop rdi
			pop rsi
			pop rdx
			pop rcx
			pop rax
			ret