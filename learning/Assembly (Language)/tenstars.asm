section .data
    starsSeq times 10 db '*'
    lenStarSeq equ $ - starsSeq
    newline db 0xa

section .text
global _start
_start:

    mov eax,4
    mov ebx,1
    mov ecx,starsSeq
    mov edx,lenStarSeq
    int 0x80

    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,1
    int 0x80

    mov eax,1
    mov ebx,0
    int 0x80
