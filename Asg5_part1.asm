
extern far_proc                                     ;using extern directive to include procedures from other files

global  filehandle,char,buf,abuf_len                ;declare variables globally

%include "macro.asm"                                ; include all macros

section .data

	nline db 10
	nline_len equ $-nline
	
	filemsg db 10,"Enter the filename : "
	filemsg_len equ $-filemsg
	
	charmsg db 10,"Enter the character to search : "
	charmsg_len equ $-charmsg
	
	errmsg db 10,"Error opening the file",10
	errmsg_len equ $-errmsg
	
section .bss
	
	buf resb 1024
	buf_len equ $-buf                          ;initial buf length
	
	filename resb 50
	char resb 2
	abuf_len resb 1                            ;actual buf length
	filehandle resb 1
	
section .text
	global _start
	
_start:

	display filemsg,filemsg_len
	accept filename,20
	dec eax
	mov byte[filename+eax],0                     ;blankk char to be appended at the end
	
	fopen filename                               ;open the file
										;return file handle on success
	test eax,eax                                 ;on failure check sign
	js Error								;if sign is set its error
	
	mov [filehandle],eax                         ;save file handle
	
	fread [filehandle],buf,buf_len               ;read file contents in buf
	mov [abuf_len],eax                           ;save actual buf length
	
	display charmsg,charmsg_len
	accept char,2
	
	call far_proc                                ;call to far_proc in another file
	jmp down 
		
Error: display errmsg,errmsg_len

down: end                                         ;terminate
