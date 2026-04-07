; STAGE 2
org 0x8000                                          ; start address for the second stage bootloader , padding of 512 bytes from stage 1

; CONSTANTS 
    newline equ 0x0a
    carriageReturn equ 0x0d 
    teletype_function equ 0x0e
    printInterrupt equ 0x10 


; STACK AND INTERRUPTS
start:                                              ; setting up fresh segments for the stack
    cli                 
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ax, 0x9000
    mov ss, ax                                      ; ss can not be directly assigned a vlaue, do it via the ax register
    mov sp, 0x9FFF                                  ; stack pointer is set to the maximum it can go just before the reserved memory
                                                    ; stack grows downwards from 0x9fff to 0x9000: giving it 4096 bytes for stack, inclusive

    mov si,stage2LoadMessage                                

print_message_1:                                    ; loop to print the message
    lodsb                   
    cmp al,0                
    je stage2_loop         
    mov ah, teletype_function            
    int printInterrupt                
    jmp print_message_1  

; ENABLE A20

; DEFINE GDT

; FAR JUMP TO THE PROTECTED MODE AND THE KERNEL

stage2_loop:                                        ; infinite loop to stop the bootloader from crashing
    jmp $                   


; MESSAGES
stage2LoadMessage db "ENTERED STAGE 2",0