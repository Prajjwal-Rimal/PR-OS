; STAGE 2
org 0x8000                                          ; start address for the second stage bootloader , padding of 512 bytes from stage 1

; CONSTANTS 
    newline equ 0x0a
    carriageReturn equ 0x0d 
    teletype_function equ 0x0e
    printInterrupt equ 0x10 
    biosSystemInterrupt equ 0x15
    a20SupportStatus equ 0x2403
    a20Gatestatus equ 0x2402
    a20gateenable equ 0x2401


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
    je new_line
    mov ah, teletype_function
    int printInterrupt
    jmp print_message_1


new_line:                                           ; to print the newline
    mov al,newline
    mov ah,teletype_function
    int printInterrupt
    mov al,carriageReturn
    mov ah,teletype_function
    int printInterrupt
    jmp enable_a20

; https://wiki.osdev.org/A20_Line
; https://www.ctyme.com/intr/int-15.html
; jnz stands for jump if not zero
enable_a20:
    mov     ax, a20SupportStatus                    ; checking if bios supports a20 gate by default, placing the query function in the ax register
    int     biosSystemInterrupt                     ; bios system interrupt to querry for the function
    jc      a20_not_supported                       ; checkking for the value in the jump cary flag if the value is 1 show an error, if 0x15 is not supported it is set as 1
    test    ah, ah                                  ; checking if the ah register is 0 or not through a logical AND; important to check as there are 3 responses a bios may submit
    jnz     a20_not_supported                       ; if logical AND does not return a 0 throw an error, sets ZF=1 if AH is 0, jump if not zero = jump if AH≠0.

    mov     ax, a20Gatestatus                       ; querying for the gate status for a20
    int     biosSystemInterrupt                     ; bios system interrupt to query for the function
    jc      a20_not_enabled                         ; if the carry flag is set jump to the error 
    test    ah, ah                                  ; if ah valur is 1 then its an error
    jnz     a20_not_enabled                         ; if value is 1 jump to the error
    test    al, al                                  ;if al value is 1 then a20 is on if 0 then it is off
    jnz     a20_activated                           ; if al is on jump to activated
                                                    ; ah is the value for bios and al is the response

    mov     ax, a20gateenable                       ; Activate A20 gate
    int     biosSystemInterrupt                     ; bios system interrupt to query for the function
    jc      a20_not_enabled                         ; if the carry flag is set then the activation failed and fo to the error message
    test    ah, ah                                  ; if ah is 1 then it failed
    jnz     a20_not_enabled                         ; if failed go to the error messgae


a20_not_supported:                                   ; a20 not supported si, message, and loop
    mov si,a20NotSupportedMessage
a20_not_supported_print:
    lodsb                   
    cmp al,0                
    je stage2_loop         
    mov ah, teletype_function            
    int printInterrupt                
    jmp a20_not_supported_print  

a20_not_enabled:                                    ; a20 not enabled si, message, and loop
    mov si,a20NotEnabledMessage
a20_not_enabled_print:
    lodsb                   
    cmp al,0                
    je stage2_loop         
    mov ah, teletype_function            
    int printInterrupt                
    jmp a20_not_enabled_print  

    
a20_activated:                                      ; a20 activated si, message, and loop
    mov si,a20ActivatedMessage
a20_activated_print:
    lodsb                   
    cmp al,0                
    je stage2_loop
    mov ah, teletype_function            
    int printInterrupt                
    jmp a20_activated_print  

; DEFINE GDT

; FAR JUMP TO THE PROTECTED MODE AND THE KERNEL

stage2_loop:                                        ; infinite loop to stop the bootloader from crashing
    jmp $                   


; MESSAGES
stage2LoadMessage db "ENTERED STAGE 2",0
a20NotSupportedMessage db "A20 IS NOT SUPPORTED",0
a20NotEnabledMessage db  "A20 IS NOT ENABLED",0
a20ActivatedMessage db "A20 ACTIVATED",0