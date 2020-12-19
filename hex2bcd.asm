%macro disp 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 80h
%endmacro

%macro read 2
mov eax,3
mov ebx,2
mov ecx,%1
mov edx,%2
int 80h
%endmacro

section .data
msg1 db 10, "Enter hexadecimal nos : "
len1 equ $-msg1
msg2 db 10,"The BCD equivalent is : "
len2 equ $-msg2
nwline db 10
cnt db 8
errm db 0ah,"Invalid input!",0ah
len3 equ $-errm
eflag db 0

section .bss
no resb 9
len resb 1
hnum resd 1
bnum resd 1
;len1 resb 1

section .text
global _start
_start:
	
	disp msg1, len1
	read no,9
	dec al  	; to remove enter key counter
	mov [len],al	; store length
	mov dword[hnum], 00	;accept a hex number
	call pack       ; pack individual digits to make a no. 
	
	call convert	; convert into BCD
	cmp byte[eflag],1
	je exit
	disp msg2,len2
	call disp_num	; display
	jmp exit

exit:
	disp nwline,1
	mov eax,1
	mov ebx, 0
	int 80h

pack:
	mov esi,no    
label1: 
	mov ebx,0
	mov bl,byte[esi]
	cmp bl,30H   	; jump on below if number 0 - 9 
	jb err1
	cmp bl,46H    	; alphabet 46H ==> F
	ja err1
	cmp bl,3AH
	jb valid1
	cmp bl,41H
	jb err1
	sub bl,37H   	;  no is between  A to F 
	jmp pack1
valid1:  
	sub bl, 30H	
pack1:   
	mov edx,dword[hnum]
	shl edx, 4    	;  same like mul by 16
	add edx, ebx
	mov [hnum], edx
	inc esi
	dec byte[len]
	jnz label1
	jmp myret
err1:
	disp errm, len3   
	mov byte[eflag],1
myret:
ret

; divide by 10 iterations to seperate decimal digits
convert:
    	mov cl,0
   	mov ax,word[hnum]	;dx:ax = 32 bit numerator
	mov dx,word[hnum+2]
   	mov bx,10
again : div bx		;16 bit denominator (division)
      	push dx		; dx = remainder
      	inc cl
     	mov dx,0
     	cmp ax,0
    	jne again
   	mov [cnt],cl
   	;print msg3,len3
	;mov dword[bnum],0
	mov ebx,0
next: 	mov eax,0
	pop ax;
       	shl ebx,4
	add ebx,eax
        dec byte[cnt]
        jnz next
	mov dword[bnum],ebx
ret

; display hexadecimal number style
disp_num:
	mov esi,no
        mov ebx,0F0000000h
        mov eax,dword[bnum]
        mov cl,28 
        mov ch,08

        mov edx,eax
back1:  and eax,ebx
        shr eax,cl
        cmp al,10
        jb add301
        add al,07
add301: add al,30h
        mov byte[esi],al
        inc esi
        mov eax,edx
        shr ebx,04
        sub cl,04
        dec ch
        jnz back1
        disp no,8
ret
