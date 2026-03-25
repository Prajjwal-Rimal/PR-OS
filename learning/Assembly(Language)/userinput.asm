section .data
    userMsg db 'Please enter a number: '    ; asking the user to enter a number 
    lenUserMsg equ $ - userMsg              ; the length of the user messgage
    dispMsg db 'You have entered: '         ; displaying the message of the use
    lenDispMsg equ $ - dispMsg              ; length of the message of the message to display
    newline db 0xa                          ; newline code

section .bss
    usernum resb 5                          ; reserve 5 bytes for the usernum

section .text
global _start

_start:

    mov eax,4                               ; syscall 4 for fd
    mov ebx,1                               ; STDOUT fd
    mov ecx,userMsg                         ; go to the memory location of userMsg
    mov edx,lenUserMsg                      ; stay till the length of the message
    int 0x80                                ; calling the kernel

    mov eax,3                               ;syscall for read from the input
    mov ebx,0                               ; to read from the key board may work with 2 as well
    mov ecx,usernum                         ; moving the register to the beginning of the uninitialized register
    mov edx,5                               ; the size of the input
    int 0x80                                ; syscall to call the kernel

    mov eax,4                               ;syscall 4 for fd
    mov ebx,1                               ; stdout fd
    mov ecx,dispMsg                         ; start of the memory location of dispmsg
    mov edx,lenDispMsg                      ; till the end of the dispmsg
    int 0x80                                ; interrupt to call the kernel

    mov eax,4                               ; syscall 4 for fd
    mov ebx,1                               ; stdout via 1 in fd
    mov ecx,usernum                         ; go to the beginning of the usernum
    mov edx,5                               ; the next 5 bits
    int 0x80                                ; interrupt to call the kernel        

    mov eax,4                               ; syscall 4 gfor fd
    mov ebx,1                               ;stdout
    mov ecx, newline                        ; calling new line
    mov edx,1                               ; size of newline
    int 0x80                                ; interrupt to call the kernel

    mov eax,1                               ; syscall for exit
    mov ebx,0                               ; exit code
    int 0x80                                ; interrupt to call the kernel
