section .data
	msg1 db "Enter String "
	len1 equ $-msg1
	msg3 db "Result is  "
	len3 equ $-msg3
	

section .bss
	len resb 1
        str1 resb 50
	digit resb 2
	str2 resb 50


%macro print 2
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

section .text
   global _start
_start :
    print msg1,len1
    read str1,49
    dec al
	mov byte[len], al
       call unpack
    
    print msg3,len3
    
    print digit,2

    call reverse
    print str2,[len] 
    call copy
    print str2,[len] 

    call upper
    print str2,[len]

    call lower
    print str2,[len]


mov eax,1
mov ebx,0
int 80h

unpack:
       mov ax,0
	mov al,[len]
	mov bl,10
	div bl
	mov esi,digit
	add al,30h
	mov byte[esi],al
	inc esi	
	add ah,30h
	mov byte[esi],ah
	ret
reverse:
        mov esi,str1
        mov edi,str2
        mov eax,0
        mov al,[len]
        add esi,eax
        mov cl,byte[len]
loop1:
        mov dl,byte[esi]
        mov byte[edi],dl
        dec esi
        inc edi
        dec cl
        jnz loop1
        mov dl,byte[esi]
        mov byte[edi],dl
        ret  

copy:
        mov esi,str1
        mov edi,str2
        mov eax,0
        mov cl,byte[len]
loop2:
        mov dl,byte[esi]
        mov byte[edi],dl
        inc esi
        inc edi
        dec cl
        jnz loop2
        mov dl,byte[esi]
        mov byte[edi],dl
        ret  

upper:
        mov esi,str1
        mov edi,str2
        mov cl,byte[len]
loop3:
        mov dl,byte[esi]
        sub dl,20h
        mov byte[edi],dl
        inc esi
        inc edi
        dec cl
        jnz loop3
        mov dl,byte[esi]
        mov byte[edi],dl
        ret 

lower:
        mov esi,str1
        mov edi,str2
        mov eax,0
        mov al,[len]
        mov cl,byte[len]
loop4:
        mov dl,byte[esi]
        add dl,20h
        mov byte[edi],dl
        inc esi
        inc edi
        dec cl
        jnz loop4
        mov dl,byte[esi]
        mov byte[edi],dl
        ret 
