org 0x7c00                                              ; starting memory address
start:                                                  ; start lable
    cli                                                 ; clearing interrupts
    xor ax,ax                                           ; setting ax operation to 0 via xor operation
    mov ds,ax                                           ; setting the data stack to 0
    mov ss,ax                                           ; setting the stack segment to 0
    mov sp,0x7c00                                       ; setting the stack pointer to the starting language
    sti                                                 ; restarting the interrupts
    
    mov si,stage1msg                                    ; moving the source index to the first message


; LOOP TO PRINT THE FIRST MESSGAE
print_loop1:                                            ; loop to print the first messgae on the screen
    lodsb                                               ; load the byte from the si to al register then move to the next one
    cmp al,0                                            ; comparing if al=0 
    je new_line                                         ; if al=0 then go to the new line lable
    mov ah,0x0e                                         ; bios teletype function loaded into the ah register
    int 0x10                                            ; interrupt to print to the screen
    jmp print_loop1                                     ; repeat until 0 is encountered

; NEW LINE
new_line:                                               ; to print the newline
    mov al,0x0a                                         ; ascii value for line feed fuinction: linebereakl to print the message in another line
    mov ah,0x0e                                         ; bios teletype function
    int 0x10                                            ; printing to the screen
    mov al,0x0d                                         ; ascii value for the carriage return: ensures that the cursor is set to the beginning of the new line
    mov ah,0x0e                                         ; bios teletype function
    int 0x10                                            ; usdsed to print to the screen

    mov si,stage2msg                                    ; setting the source index to the second message

; LOOP TO PRINT THE SECOND MESSGAE
print_loop2:                                            ; loop to print the second messgae
    lodsb                                               ; loading from si into al and moving to the nect itrem
    cmp al,0                                            ; comparing the values of the al register with 0
    je bootloader_loop                                  ; jumping to the bootloader loop if the value matches 0
    mov ah,0x0e                                         ; bios teletype function
    int 0x10                                            ; to p[rint ht evalue in the al reguister to the screen
    jmp print_loop2                                     ; repeat until the condition is met

; LOOP TO KEEP THE BOOTLOADER RUNNING 
bootloader_loop:                                        ; bootloader loop 
    jmp $                                               ; jumping bacck to the current memory address i.e the bootloader_loop

    stage1msg db "STAGE 1 BOOTLOADER LOADED",0          ; the first messgae to print to the screen
    stage2msg db "SWITCHING TO STAGE 2",0               ; the second message to display on the screen

    times 510 - ( $- $$ ) db 0                          ; setting the remaining bits of the first stage to 0
    dw 0xaa55                                           ; final verification boot signature

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------
;COMPLETION OF THE FIST STAGE
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------
