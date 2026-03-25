; debug the following 
;section .data
;msg db 'Hi'
;
;section .text
;global _start
;
;_start:
;    mov eax, 4
;    mov ebx, 1
;    mov ecx, msg
;    mov edx, 2
;    int 0x80
;
;    mov eax, 1
;    int 0x80



; solution
section .data
msg db 'Hi',0xa
len equ $ - msg

section .text
global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
