section .data
    msg db 'Hello World', 0xa   ;string to be printed
                                ;db defines the bytes
                                ; 0xa is for new line character
    len equ $ - msg             ; length of the string
                                ; equ defines constant
                                ;$ for current memory address
                                ; basically saying the current length of the memory is constant for the text above

section .text
global _start                   ; must be declared for the linker

_start:                         ; tells where the program starts
    mov edx,len                 ; message length into edx register
    mov ecx,msg                 ; message to write
                                ; pointer to the message
    mov ebx,1                   ; file descriptor
    mov eax,4                   ; system call fro write
    int 0x80                    ; interrupt calling the kernel, and then execute the syscall

    mov eax,1                   ; exit system call
    mov ebx,0                   ; exit system call message
    int 0x80                    ; kernel system call

