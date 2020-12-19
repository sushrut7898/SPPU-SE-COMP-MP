
extern  filehandle,char,buf,abuf_len                   ;extern directive to include variables from other file

global far_proc                                        ;declare far_proc globally

%include "macro.asm"                                   ;include all macros

section .data

	nline db 10,10
	nline_len equ $-nline
	
	smsg db 10,"Number of spaces are : "
	smsg_len equ $-smsg
	
	nmsg db 10,"Number of new lines are : "
	nmsg_len equ $-nmsg
	
	cmsg db 10,"Number of character occurences are : "
	cmsg_len equ $-cmsg
	
section .bss

	scount resb 1
	ncount resb 1
	ccount resb 1
	vcount resb 1
	
section .text
	global _main
	
_main:

far_proc:                             ;define far_proc procedure

	xor eax,eax                      ;clear all bits of eax
	xor ebx,ebx                      ;reset ebx
	xor ecx,ecx
	xor esi,esi
	
	mov bl,[char]
	mov esi,buf                      ;point to first character
	mov ecx,[abuf_len]               ;initialize counter with actual buf length
	
up:
	mov al,[esi]                     ;mov one character into al
	
case_s:
	cmp al,20h                       ;compare for space
	jne case_n                       ;check next case if not equal
	inc byte[scount]                 ;increment scount if space present
	jmp next                         ;jump for next character
	
case_n:
	cmp al,0Ah                       ;compare for newline
	jne case_c
	inc byte[ncount]
	jmp next
	
case_c:                                      ;compare for given character
	cmp al,bl
	jne next
	inc byte[ccount]
	
next:
	inc esi                                 ;point to next character
	dec ecx                                 ;decrement counter
	jnz up                                  ;repeat comparisons
	
	display smsg,smsg_len
	mov eax,[scount]
	add al,30h                              ;convert original to ascii
	mov [scount],al
	display scount,1                        ;display space count
	
	display nmsg,nmsg_len
	mov eax,[ncount]
	add al,30h
	mov [ncount],al
	display ncount,1                       
	
	display cmsg,cmsg_len
	mov eax,[ccount]
	add al,30h
	mov [ccount],al
	display ccount,1                        ;display character count
	display nline,nline_len           
	
	fclose [filehandle]                     ;close the file
	ret                                     ;return from procedure
