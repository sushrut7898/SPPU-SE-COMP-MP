%macro print_msg 2
	mov EAX,4
	mov EBX,1
	mov ECX,%1
	mov EDX,%2
	int 80h
%endmacro

%macro read 2
	mov EAX,3
	mov EBX,2
	mov ECX,%1
	mov EDX,%2
	int 80h
%endmacro

section .data
	msg1 db 0ah,"Enter number: ",0aH
	len1 equ $-msg1
	msg2 db 0ah,"Addition is: ",0aH
	len2 equ $-msg2
	errmsg db 0ah,"Invalid input!",0ah
	len3 equ $-errmsg

section .bss
	no resb 9		;8 digit number + enter key
	arr resd 2
	num resd 1
	len resb 1
	cnt resb 1

section .text
global _start
_start:

	mov byte[cnt],5
	mov EDI,arr
input1:	
        print_msg msg1,len1
	read no,9
	dec AL
	mov [len],AL
	mov ESI,no
	mov dword[num],0
up:
	mov ECX,0
	mov CL,byte[ESI]
	cmp CL,30H
	JB error1
	CMP CL,46H
	JA error1
	cmp CL,3AH			;if below numeric value ie 0-9
	JB sub30
	cmp CL,41H
	JB error1
	sub CL,37H
	JMP pack
error1:	print_msg errmsg,len3
	ret
sub30:	sub CL,30H
pack:	mov EBX,dword[num]			
	shl EBX,4
	ADD EBX,ECX
	mov dword[num],EBX			;change
	inc ESI
	dec byte[len]
	JNZ up
	mov [EDI],EBX
	ADD EDI,4
	dec byte[cnt]
	JNZ input1

	mov byte[cnt],5
	mov EAX,0
        mov EDI,arr
	
label22 :
        add EAX,[EDI]
	add EDI,4
	dec byte[cnt]
JNZ label22

	mov [num],EAX
	print_msg msg2,len2 				;display
	mov EAX,[num]
	mov EDX,EAX
	mov EBX,0F0000000h	;Start with extra 0. since Value starting with Alphabet is considered as variable name
	mov ESI,no
	mov CL,28
	mov byte[len],8

output1:and EAX,EBX
	shr EAX,CL
	cmp AL,10
	JB add30
	ADD AL,07h

add30:	add AL,30h

	mov byte[ESI],AL
   inc ESI
	mov EAX,EDX				;Reinitialize number back to EAX
	shr EBX,4
	sub CL,4
	dec byte[len]
	JNZ output1

;Now after all iterations no holds the complete number ready for display

	print_msg no,8

;endcall
mov EAX,1
mov EBX,0
int 80h 
