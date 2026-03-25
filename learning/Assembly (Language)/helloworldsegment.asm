segment .data
    msg db 'hello world',0xa    ;the message we need to print with new line
    len equ $ - msg

segment .text
global _start

_start:
    mov edx,len 
    mov ecx, msg
    
    mov eax,4 
    mov ebx,1
    int 0x80

    mov eax,1
    mov ebx,0
    int 0x80

