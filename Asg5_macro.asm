
section .bss

%macro accept 2
	mov eax,3                   ;read
	mov ebx,0                   ;stdin/keyboard
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

%macro display 2
	mov eax,4			        ;print
	mov ebx,1                   ;stdout/screen
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

%macro fopen 1
	mov ebx,%1                  ;filename
	mov eax,5                   ;function to open
	mov ecx,0                   ;file access mode 0-R,1-w & 2-r/w
	int 80h
%endmacro

%macro fread 3
	mov eax,3                   ;read
	mov ebx,%1                  ;filehandle
	mov ecx,%2                  ;buf
	mov edx,%3                  ;buf_len
	int 80h
%endmacro

%macro fclose 1
	mov eax,6                   ;close
	mov ebx,%1                  ;file handle
	int 80h
%endmacro

%macro end 0
	mov eax,1
	int 80h
%endmacro
