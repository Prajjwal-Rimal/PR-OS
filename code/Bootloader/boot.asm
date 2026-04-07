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
    je new_line_2                                       ; jumping to new line
    mov ah,0x0e                                         ; bios teletype function
    int 0x10                                            ; to p[rint ht evalue in the al reguister to the screen
    jmp print_loop2                                     ; repeat until the condition is met

; NEW LINE
new_line_2:                                             ; to print the newline
    mov al,0x0a                                         ; ascii value for line feed fuinction: linebereakl to print the message in another line
    mov ah,0x0e                                         ; bios teletype function
    int 0x10                                            ; printing to the screen
    mov al,0x0d                                         ; ascii value for the carriage return: ensures that the cursor is set to the beginning of the new line
    mov ah,0x0e                                         ; bios teletype function
    int 0x10                                            ; usdsed to print to the screen


    mov ah,0x02
    mov al,8
    mov ch,0
    mov cl,2
    mov dh,0
    mov dl,0x00
    mov bl,0x8000
    int 0x13
    jc loop_exit  


    mov si, loadVerificationMessage

; LOOP TO PRINT THE VERIFICATION MESSGAE
print_loop3:                                            ; loop to print the second messgae
    lodsb                                               ; loading from si into al and moving to the nect itrem
    cmp al,0                                            ; comparing the values of the al register with 0
    je jump_stage2                                       ; jumping to new line
    mov ah,0x0e                                         ; bios teletype function
    int 0x10                                            ; to p[rint ht evalue in the al reguister to the screen
    jmp print_loop3                                     ; repeat until the condition is met


new_line_stage2_jump:
    mov al,0x0a                                         ; line feeder/ new linw
    mov ah,0x0e                                         ; bios teletype function
    int 0x10                                            ; print interrupt
    mov al,0x0d                                         ; carriage return
    mov ah,0x0e                                         ; BIOSTELETYPE FUNCTION
    int 0x10                                            ; interrupt to print value to he screen
    jmp 0x0000:0x8000                                   ; actual jump segment offset memory location                                        ; usdsed to print to the screen


; LOOP TO KEEP THE BOOTLOADER RUNNING 
bootloader_loop:                                        ; bootloader loop 
    jmp $                                               ; jumping bacck to the current memory address i.e the bootloader_loop

    stage1msg db "STAGE 1 BOOTLOADER LOADED",0          ; the first messgae to print to the screen
    stage2msg db "SWITCHING TO STAGE 2",0               ; the second message to display on the screen
    loadVerificationMessage db "STAGE 2 LOADED.", 0     ; VERIFICATION MESSGAE AFTER STAGE 2 DISKIS read

    times 510 - ( $- $$ ) db 0                          ; setting the remaining bits of the first stage to 0
    dw 0xaa55                                           ; final verification boot signature

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------
;COMPLETION OF THE FIST STAGE
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------
