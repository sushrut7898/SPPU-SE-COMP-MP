%macro display 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endm display

section .data
	a dd 4.0
	b dd 6.0
	c dd 2.0
	mulc dd 10000
	cntr db 10
	msg1 db "Root 1:"
	msg1len equ $-msg1
	msg2 db "Root 2:"
	msg2len equ $-msg2

section .bss
	ansp:rest 1
	ansn:rest 1
	flg:resb 1
	temp:resb 1
	temp1:resb 1
	root1 :resb 20
	root2:resb 20
	r1len:resb 1
	r2len:resb 1
	edp:resb 1

section .text
Global _start
_start:
	finit
	fld1
	fadd st0,st0
	fld dword[a]
	fmul st0,st1
	fld dword[c]
	fmul st0,st1
	fmul st0,st2
	fld dword[b]
	fmul st0,st0
	fsub st0,st1
	fsqrt
	fld dword[b]
	fchs
	fld st0
	fadd st0,st2
	fdiv st0,st4
	fimul dword[mulc]
	frndint
	fbstp [ansp]
	
	fsub st0,st1
	fdiv st0,st3
	fimul dword[mulc]
	frndint
	fbstp [ansn]
	
	mov esi,ansp
	add esi,9
	mov edi,root1
	mov byte[cntr],10
	call play
	mov al,[edp]
	mov byte[r1len],al
	display msg1,msg1len
	display root1,r1len

	mov esi,ansn
	add esi,9
	mov edi,root2
	mov byte[cntr],10
	call play
	mov al,[edp]
	mov byte[r2len],al
	display msg2,msg2len
	display root2,r2len

	mov rax,60
	mov edi,0
	syscall

play:
	mov byte[flg],0
	mov byte[edp],0
;--------------For determining sign--------------
		cmp byte[esi],00
		je positive
		mov byte[edi],2DH
		jmp nxt
	positive:mov byte[edi],2BH
	nxt:	dec esi
		inc edi
		inc byte[edp]
		dec byte[cntr]
;--------------For number-------------------
	loop:	cmp byte[flg],0
		jne dis1
		cmp byte[esi],00
		je nxtb
	dis1:	mov byte[flg],1

		mov al,byte[esi]
		shr al,4
		add al,30H
		mov [edi],al
		inc edi
		inc byte[edp]
		mov al,byte[esi]
		and al,0FH
		add al,30H
		mov [edi],al
		inc edi
		inc byte[edp]
		



		
	nxtb:	dec esi
		dec byte[cntr]
		cmp byte[cntr],02
		jne next
		cmp byte[flg],0
		jne dis
		mov byte[edi],0
		inc edi
		inc byte[edp]
		;display de,1
	dis:	mov byte[edi],2EH
		inc edi
		inc byte[edp]
	next:	cmp byte[cntr],0
		jne loop
	
		
	ret
	
