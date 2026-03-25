section .data
    kernel_interrupt equ  0x80
    newline equ 0xa

    sys_exit equ 1
    sys_write equ 4
    stdin equ 0
    stdout equ 1

    msg1 db	'Hello, programmers!',0xA,0xD
    len1 equ $ - msg1

    msg2 db 'Welcome to the world of,', 0xA,0xD
    len2 equ $ - msg2

    msg3 db 'Linux assembly programming! '
    len3 equ $ - msg3


section .text
global _start
_start:

    mov eax,sys_write
    mov ebx,stdout
    mov ecx,msg1
    mov edx,len1
    int kernel_interrupt

    mov eax,sys_write
    mov ebx,stdout
    mov ecx,newline
    mov edx,1
    int kernel_interrupt

    mov eax,sys_write
    mov ebx,stdout
    mov ecx,msg2
    mov edx,len2
    int kernel_interrupt
  
    mov eax,sys_write
    mov ebx,stdout
    mov ecx,newline
    mov edx,1
    int kernel_interrupt

    mov eax,sys_write
    mov ebx,stdout
    mov ecx,msg3
    mov edx,len3
    int kernel_interrupt

    mov eax,sys_write
    mov ebx,stdout
    mov ecx,newline
    mov edx,1
    int kernel_interrupt    
    
    mov eax,sys_exit
    mov ebx,0
    int kernel_interrupt
