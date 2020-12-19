; Program to switch form real mode to protected mode and display the
; values of GDTR, LDTR, IDTR, TR and MSW Registers

%macro print 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

SECTION .data
	msg1 	db "The value of GDTR = "
	msg1len equ $-msg1	
	msg2 	db "The value of IDTR = "
	msg2len equ $-msg2
	msg3 	db "Program to read and display the contents of GDTR, IDTR, LDTR, TR and MSW!",0ah
	msg3len equ $-msg3
	msg4	db "The value of LDTR = "
	msg4len equ $-msg4
	msg6	db "The value of TR = "
	msg6len equ $-msg6
        msg7	db "The value of MSW = "
	msg7len equ $-msg7
	nl	db 0Ah
	err1 db "Sorry cannot get GDTR and IDTR!!!"
	err1len equ $-err1	
	colon db ':'	
	newln db 0ah
	
SECTION .bss
	GDTRl: 	resw 1	
	GDTRb: 	resd 1
	IDTRl: 	resw 1
	IDTRb: 	resd 1
	LDTR:	resw 1
	digits: resb 8
	desc:	resq 1
        TR :  resw 1
        CR0_data: resd 1

SECTION .text
GLOBAL _start
_start:
	print msg3,msg3len
	sgdt [GDTRl]
	sidt [IDTRl]
	sldt [LDTR]
        str [TR]
        smsw [CR0_data]
;..............................................................................
	print msg1,msg1len
	mov edi,digits		;initialize pointer to the start of string
	mov esi,GDTRb
	mov cl,04		;GDTR base = 32 bits
	call convert

	print digits,8		; so string of 8 nibbles
	print colon,1

	mov esi,GDTRl
	mov edi,digits
	mov cl,02		;GDTR limit = 16 bits
	call convert
	print digits,4		; so string of 4 nibbles
	print newln,1

;................. same process for IDTR.................
	print msg2,msg2len
	mov edi,digits		;initialize pointer to the start of string
	mov esi,IDTRb
	mov cl,04		;GDTR base = 32 bits
	call convert

	print digits,8		; so string of 8 nibbles
	print colon,1

	mov esi,IDTRl
	mov edi,digits
	mov cl,02		;GDTR limit = 16 bits
	call convert

	print digits,4		; so string of 4 nibbles
	print newln,1
	
;...................................................................
	print msg4,msg4len
	mov edi,digits		;initialize pointer to the start of string
	mov esi,LDTR
	mov cl,02		;LDTR = 16 bits
				;points within GDT
	call convert

	print digits,4		; so string of 4 nibbles
	
         print newln,1
;------------------------------------------------------------------------------
        print msg6,msg6len
        mov esi,TR
	mov edi,digits
	mov cl,02		;GDTR limit = 16 bits
	call convert
	print digits,4		; so string of 4 nibbles
	print newln,1
;------------------------------------------------------------------------------------
        print msg7,msg7len
        mov esi,CR0_data	; display MSW
	mov edi,digits
	mov cl,04		
	call convert
	print digits,8		
	print newln,1

	mov eax,01		
	mov ebx, 00
	int 80h

;.........................end of the main program.........................................
;............writing procedure to convert values into string of ASCII ...............

convert:	
	mov edx,0
	mov dl,cl		;cl = no of bytes to convert
	dec edx			;largest offset = no. of bytes - 1
	add esi,edx
	
again:	
	mov al, byte[esi]	;get byte
	and al, 0F0h		; mask lower nibble
	shr al, 04h
	cmp al, 0ah
	jb add_30h
	add al, 37h
	jmp store
	
add_30h:
	add al, 30h

store:
	mov [edi],al
	inc edi
	
	mov al, byte[esi]
	and al, 0Fh
	cmp al, 0ah
	jb add_30h1
	add al,37h
	jmp store1
	
add_30h1:
	add al,30h

store1:
	mov [edi],al
	inc edi
	dec esi
	dec cl
	jnz again

ret

