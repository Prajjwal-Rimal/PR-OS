section .data
    initialmessage db 'printing 9 stars in assembly', 0xa   ; message with newline
    leninitialmessage equ $ - initialmessage                ; length of the initial message tells from the start($) to the end(-) of initial message
    stars times 9 db '*'                                    ; times 9 kind of defines an array of 9 db each filled with a *
    lenstars equ $ - stars                                  ; length of the stars to avoid hard coding values
    newline db 0xa                                          ; to manually insert newline where needed

section .text
global _start

_start:
    mov eax,4                   ; syscall for fd
    mov ebx,1                   ; fd stdout
    mov ecx,initialmessage      ; points to the message that needs to be written
    mov edx,leninitialmessage   ; telling that go till the end of the message
    int 0x80                    ; interrupt to call the kernel


    mov eax,4                   ; syscall for fd
    mov ebx,1                   ; fd stdout
    mov ecx,stars               ; points to the message that needs to be written
    mov edx,lenstars            ; telling that go till the end of the message
    int 0x80                    ; interrupt to call the kernel

    mov eax,4                   ;syscall for fd
    mov ebx,1                   ;syscall for stdout 
    mov ecx, newline            ; calling newline
    mov edx,1                   ; number of byte/s to write
    int 0x80                    ; calling the kernel           


    mov eax,1                   ; syscall for exit
    mov ebx,0                   ; exit code to show program was complete
    int 0x80                    ; interrupt to call the kernel
