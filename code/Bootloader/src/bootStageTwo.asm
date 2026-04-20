; STAGE 2
org 0x8000                                          ; start address for the second stage bootloader , padding of 512 bytes from stage 1

; CONSTANTS 
    newline equ 0x0a
    carriageReturn equ 0x0d 
    teletype_function equ 0x0e
    printInterrupt equ 0x10 
;    biosSystemInterrupt equ 0x15
;    a20SupportStatus equ 0x2403
;    a20Gatestatus equ 0x2402
;    a20gateenable equ 0x2401W


; STACK AND INTERRUPTS
start:                                              ; setting up fresh segments for the stack
    cli                 
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ax, 0x9000
    mov ss, ax                                      ; ss can not be directly assigned a vlaue, do it via the ax register
    mov sp, 0x0000                                  ; stack pointer is set to the maximum it can go just before the reserved memory
                                                    ; stack grows downwards
    sti

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
;enable_a20:
;    mov     ax, a20SupportStatus                    ; checking if bios supports a20 gate by default, placing the query function in the ax register
;    int     biosSystemInterrupt                     ; bios system interrupt to querry for the function
;    jc      a20_not_supported                       ; checkking for the value in the jump cary flag if the value is 1 show an error, if 0x15 is not supported it is set as 1
;     test    ah, ah                                  ; checking if the ah register is 0 or not through a logical AND; important to check as there are 3 responses a bios may submit
;     jnz     a20_not_supported                       ; if logical AND does not return a 0 throw an error, sets ZF=1 if AH is 0, jump if not zero = jump if AH != 0.

;     mov     ax, a20Gatestatus                       ; querying for the gate status for a20
;     int     biosSystemInterrupt                     ; bios system interrupt to query for the function
;     jc      a20_not_enabled                         ; if the carry flag is set jump to the error 
;     test    ah, ah                                  ; if ah valur is 1 then its an error
;     jnz     a20_not_enabled                         ; if value is 1 jump to the error
;     test    al, al                                  ;if al value is 1 then a20 is on if 0 then it is off
;     jnz     a20_activated                           ; if al is on jump to activated
;                                                     ; ah is the value for bios and al is the response

;     mov     ax, a20gateenable                       ; Activate A20 gate
;     int     biosSystemInterrupt                     ; bios system interrupt to query for the function
;     jc      a20_not_enabled                         ; if the carry flag is set then the activation failed and fo to the error message
;     test    ah, ah                                  ; if ah is 1 then it failed
;     jnz     a20_not_enabled                         ; if failed go to the error messgae


; a20_not_supported:                                   ; jump to infinite loop
;     jmp stage2_loop

; a20_not_enabled:                                    ; jump to infinite loop
;     jmp stage2_loop
    
; a20_activated:                                      ; a20 activated si, message, and loop
;     mov si,a20ActivatedMessage
; a20_activated_print:
;     lodsb                   
;     cmp al,0                
;     je stage2_loop
;     mov ah, teletype_function            
;     int printInterrupt                
;     jmp a20_activated_print  

; A20 using system control port A 
; found on most newer computers
;https://wiki.osdev.org/A20_Line#Fast_A20_Gate
enable_a20:
    in al, 0x92                                       ; in reads data from the hardware i/o port to a cpu register
                                                      ; reading flom the port number 0x92 and storing it in the register al
    or al, 2                                          ; performing a bitwise operator with al and 2
                                                      ; this sets the second bit from the right 1 without changing the value of other bits
    out 0x92, al                                      ; writes the value from al register to the hardware port
                                                      ; so it is duet o ibm pc design language where keyboard port was used to enable a20 line by modify the value of ports around it an a widely used port was 0x92
    jmp protected_mode_setup


; DEFINING THE GDT TABLE
gdt_start:

    dq 0x0000000000000000                           ; defining the value for a null segment

    dw 0xffff                                       ; maximum limit of the segment 4 gb
    dw 0x0000                                       ; lower base value
    db 0x00                                         ; middle base value
    db 0x9a                                         ; access right
    db 0xcf                                         ; flag  and the the upper limit limit
    db 0x00                                         ; higher base value
                                                    ; so the base is 0x00000000
                                                    ; the lower limit for the segment is 0xffff
                                                    ; the upper limit of the segment is 0xf
                                                    ; the flag for this section is 1100
                                                    ; combining the flag and limit to a byte we get 0x1100f or 0x11001111
                                                    ; in acess byte 00: is kernel, 01(drivers) & 10(services) are rarely used, 11 is for userspace
                                                    ; the acess byte is an hexadecimal value for thhe binary value 10011010
    dw 0xffff                                       
    dw 0x0000
    db 0x00
    db 0x92
    db 0xcf
    db 0x00
                                                    ; everything is the same besifdes the acess byte its value is 10010010
gdt_end:

; TELLING THE CPU HOW LARGE THE GDT TABLE IS POINTER TO THE TABLE
; gdt descriptor assumes the size of the table is always size-1
gdt_descriptor:
    dw gdt_end - gdt_start - 1                      ; size of gdt -1
    dd gdt_start                                    ; starting address if the gdt


; FAR JUMP TO THE PROTECTED MODE
 protected_mode_setup:
    cli
    lgdt [gdt_descriptor]                           ; load the gdt table
    mov eax, cr0                                    ; reading the value of the control register
    or eax, 1                                       ; setting the right most bit to one
    mov cr0, eax                                    ; setting the value of the control register to the updated value
    ; cr0 is the cpus main mode control registerit contains flags about how the processor behaves
    ; watch https://www.youtube.com/watch?v=BQGbBCqUGCc
    ; right most bit setting it to 1 enables the protection a20_not_enabled
    ; tells the cpu that we are in protected mode now
    ; cr0 is not the ony control register there are more registers that do various jobs
    
    jmp 0x08:protected_mode


; without declaring bits 32 we get the folowing error
; ./src/bootStageTwo.asm:157: warning: word data exceeds bounds [-w+number-overflow]
; ./src/bootStageTwo.asm:157: warning: word data exceeds bounds [-w+number-overflow]

[bits 32]
protected_mode:                                     ; setting the stack for the protected mode
    mov ax, 0x10
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x9ffff
    mov esp, ebp
    mov dword [0xb8000], 0x07200750   ;


stage2_loop:                                        ; infinite loop to stop the bootloader from crashing
    jmp $                   


; MESSAGES
stage2LoadMessage db "ENTERED STAGE 2",0
; a20ActivatedMessage db "A20 ACTIVATED",0