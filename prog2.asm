section .data
	msg1 db "The number of blank spaces is :"
	str1len equ $-msg1
	msg2 db 0AH,"The number of lines is :"
	str2len equ $-msg2
	msg3 db 0AH,"Enter the character :"
	str3len equ $-msg3
        msg4 db "Number of times the character has occurred :"
	str4len equ $-msg4

section .bss
	blankspa: resb 3
	lines: resb 3
	temp: resb 2
	characters: resb 3

extern cntr
extern buff
global far_count

section .text

far_count:
;BLANKSPACES------------------------------------
	mov cx,00H
	mov esi,buff
	mov bx,[cntr]
	mov dl,20H
again:		
		mov al,[esi]
		cmp al,dl
		jne noincre
		inc cx
noincre:	inc esi
		dec bx
		jnz again

	mov esi,blankspa 
	mov ax,cx 
	mov dl,10 
	div dl 
        add al,30H 
	mov [esi],al 
	inc esi 
	add ah,30H 
	mov [esi],ah

; print macro
	mov rax,1               
	mov rdi,1
	mov rsi,msg1
	mov rdx,str1len
	syscall
	
	mov rax,1          
	mov rdi,1	
	mov rsi,blankspa
	mov rdx,2
	syscall

;LINES-------------------------------------------

	mov cx,00H
	mov esi,buff
	mov bx,[cntr]	
	mov dl,0AH
again1:		
		mov al,[esi]
		cmp al,dl
		jne noincre1
		inc cx
noincre1:	inc esi
		dec bx
		jnz again1
	
	mov esi,lines
	mov ax,cx 
	mov dl,10 
	div dl 
	movzx ax,al 
	add ax,30H 
	mov [esi],ax 
	inc esi 
	mov ax,cx 
	mov dl,10 
	div dl 
	mov bx,00H 
	mov bl,ah 
	mov ax,bx 
	add ax,30H 
	mov [esi],ax

	mov rax,1               
	mov rdi,1
	mov rsi,msg2
	mov rdx,str2len
	syscall
	
	mov rax,1          
	mov rdi,1	
	mov rsi,lines
	mov rdx,2
	syscall

;CHARACTER-----------------------------------

	mov rax,1               
	mov rdi,1
	mov rsi,msg3
	mov rdx,str3len
	syscall

	mov rax,0
	mov rdi,0
	mov rsi,temp
	mov rdx,2
	syscall

	mov cx,00H
	mov esi,buff
	mov bx,[cntr]	
	mov dl,[temp]
again2:		
		mov al,[esi]
		cmp al,dl
		jne noincre2
		inc cx
noincre2:	inc esi
		dec bx
		jnz again2
	
	mov esi,characters
	mov ax,cx 
	mov dl,10 
	div dl 
	movzx ax,al 
	add ax,30H 
	mov [esi],ax 
	inc esi 
	mov ax,cx 
	mov dl,10 
	div dl 
	mov bx,00H 
	mov bl,ah 
	mov ax,bx 
	add ax,30H 
	mov [esi],ax

	mov rax,1               
	mov rdi,1
	mov rsi,msg4
	mov rdx,str4len
	syscall
	
	mov rax,1          
	mov rdi,1	
	mov rsi,characters
	mov rdx,2
	syscall


ret

