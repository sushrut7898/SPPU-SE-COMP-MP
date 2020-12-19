section .data
	msg db 10,"Enter your choice ",10,"1.Mean",10,"2.Variance",10,"3.Standard Deviation",10,"4.Exit",10
	msglen equ $-msg
	msg1 db "RESULT ::",10
	msglen1 equ $-msg1
	arr dd 100.0,100.0,200.0,200.0,100.0
	div1 dd 5
	mult dd 10000.0
	dec1 db '.'
	minus db '-'
	flag db 0
	zero db '0'
	done db 0
	tval dd 0

%macro rw 4				;macro	
	mov rax,%1	;display message1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro

section .bss
	ch1:	 	resb 2
	meanr:	 	resd 1
	meanb:		rest 1
	varr:		resd 1
	varb:		rest 1
	stdb:		rest 1		
	temp:		resb 1
	temp1:		resb 1
	opstr: 		resb 20

section .text
global _start
_start:
  upp:	rw 1,1,msg,msglen			;switch case
	rw 0,0,ch1,2
	cmp byte[ch1],31h
	jne xx
	call mean1
	rw 1,1,msg1,msglen1
	mov esi,meanb
	call display
	jmp upp
   xx:  cmp byte[ch1],32h
	jne xx2
	call var1
	rw 1,1,msg1,msglen1
	mov esi,varb
	call display
	jmp upp
  xx2:  cmp byte[ch1],33h
	jne xx3
	call stdd1
	rw 1,1,msg1,msglen1
	mov esi,stdb
	call display
	jmp upp
  xx3:  cmp byte[ch1],34h
	jne upp
	mov eax,1
	mov ebx,0
	int 80h
;---------------------------------------------------
mean1:  mov ecx,5			;calculate mean
	mov esi,arr
	fldz				;clear the top of stack
loop1:  fadd dword[esi]			;add byte pointed by esi to the top of stack
	add esi,4
	dec ecx
	jnz loop1
	fidiv dword[div1]		;divide by n i.e.,no. of elements
	fst dword[meanr]
	fmul dword[mult]
	fbstp [meanb]
	mov byte[done],1
	ret
;-----------------------------------------------------
 var1:	
	mov al,[done]
	cmp al,0
	jne calvar	
	call mean1

calvar: mov esi,arr
	mov dword[tval],0h
	mov cx,5
	finit
	fld dword[meanr]
loop2:	fld dword[esi]
	fsub st0,st1
	fmul st0
	fadd dword[tval]
	fstp dword[tval]
	add esi,04
	dec cx
	jnz loop2
	fld dword[tval]
	fidiv dword[div1]
	fst dword[varr]
	fmul dword[mult]
	fbstp [varb]  
	mov byte[done],2 
	ret
;----------------------------------------------------
stdd1:  mov al,[done]
	cmp al,2
	je calstd	
	call var1
calstd: fld dword[varr]
	fsqrt
	fmul dword[mult]
	fbstp [stdb] 
	ret
;------------------------------------------------------
display  :  mov ebp,10			;no of bytes to check, flag is already 0
	mov edi, opstr
	mov rcx,0			;counter for actual bytes to display
	add esi,9			;put pointer at the end
	mov al, byte[esi]
	cmp al,0			;sign check of result
	je again
	mov al,[minus]
	mov [edi],al
	inc edi
	inc rcx
	;rw 1,1,minus,1			;for negative number display -
	dec ebp
	dec esi
							again:	cmp byte[esi],00
							jne disp
							;je nxtb
							cmp byte[flag],0		;checking if already displyed a byte
							je nxtb
disp:
	mov al,byte[esi]
        shr al,4			;upper nibble
	mov [temp],al
	and al,0fh
	add al,30h
	mov [edi],al
	inc edi
	inc rcx
	mov al,byte[esi]
	and al,0fh			;lower nibble
	add al,30h
	mov [edi],al
	inc edi
	inc rcx
	mov byte[flag],1
 nxtb:  dec esi
	dec ebp
	cmp ebp,02
	jne xx11
	cmp byte[flag],0		;0 is on the LHS of dec pt 
	jne xx1
	mov al,[zero]
	mov [edi],al
	inc edi
	inc rcx
 xx1:
	mov al,[dec1]
	mov [edi],al
	inc edi
	inc rcx
	;rw 1,1,zero,1		;explicitly put 0 on LHS.
	;rw 1,1,dec1,1
 xx11:
  	cmp ebp,00
	jne again
	rw 1,1,opstr,rcx	
	ret
