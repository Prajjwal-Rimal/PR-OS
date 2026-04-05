org 0x7C00

start: 

    cli                     ; clearing the interrupt
    xor ax,ax               ; xor operati0on to set the ax bit to 0
    mov ds,ax               ; seting the value of the data segment to 
    mov es,ax               ; setting the extra stack as 0
    mov ss,ax               ; setting the value of the stack segment to 0
    mov sp,0x7c00           ; moving the stackj poiinter to the loading address
    sti                     ; restarting the interrupts

    mov si,msghello         ; moving the source index to the message

loop_hello:                 ; loop to print hello lable
    lodsb                   ; loads the bytes into the al register from the message, ant then incrments the source index automatically
    cmp al,0                ; checks if the value currently in the al register is equals to 0
    je new_line             ; if the vcalue is equal to 0 then jump to the new_line lable
    mov ah, 0x0e            ; calling the bios teletype function 
    int 0x10                ; allows the character to be printed on the screen from the al register
    jmp loop_hello          ; jump back to the loop until the 0 condition, break condition is met

new_line:                   ; lable to print the new line
    mov al,0x0a             ; ascii instruction for new line in hexadecimal is 0x0a, also known as the line feed refer: https://ss64.com/ascii.html
    mov ah,0x0e             ; calling the biosteletype function to say we need to print a character
    int 0x10                ; interrupt to print th valure to the screen
    mov al,0x0d             ; tis is the carriage return value moves the cursor to the beginning of the line : refer https://ss64.com/ascii.html
    mov ah,0x0e             ; BIOSTELETYPE FUNCTION
    int 0x10                ; interrupt to print value to he screen
    
    mov si,msgworld         ; MOVING THE SOURCE INDEX TO THE NEXT WORD

loop_world:                 ; lable for the new loop to print the next string
    lodsb                   ; loads the bytes into the al register from the message then increment to the nmext value
    cmp al,0                ; compare the values in the al register to 0
    je load_stage_2         ; if value matches got to loading the stage 2 code
    mov ah, 0x0e            ; calling the bios teletypoe function
    int 0x10                ; calling the interrupt to print to the screen
    jmp loop_world          ; go back to the staring of this loop lable and repeat






; JUMP TO THE NEW MEMORY ADDRESS FOR THE STAGE 2 AND THROW AN ERROR IF NOT FOUND


load_stage_2:               ; lable for the second stage load 
    mov ah, 0x02            ; BIOS read sectors, saying get ready to read
    mov al, 8               ; number of sectors to read, 1 section is 512 bytes so read 4096 bytes
    mov ch, 0               ; 
    mov cl, 2               ; 
    mov dh, 0               ; 
    mov dl, 0x00            ; 
    mov bx, 0x8000          ; 
    int 0x13                ; interrupt that allows the bios to read based on the above parameters
    jc loop_exit            ; jump if read fails, the bios goes to an infinite loop instead of crashing if the disk can not be read


mov si, loadmsg             ; moving the source index to the load message

print_load:                 ; loop lable to print the message
    lodsb                   ; load a character from the messgae to the al register and the increment the source index
    cmp al,0                ; comparing the value of al with 0
    je jump_stage2          ; if the value is o then jump to the loading of the second stage
    mov ah,0x0e             ; bios teletype function to be loaded at ah register
    int 0x10                ; interrupt to print the character to the screen
    jmp print_load          ; repeat the loop till complete

jump_stage2:
    mov al,0x0a             ; line feeder/ new linw
    mov ah,0x0e             ; bios teletype function
    int 0x10                ; print interrupt
    mov al,0x0d             ; carriage return
    mov ah,0x0e             ; BIOSTELETYPE FUNCTION
    int 0x10                ; interrupt to print value to he screen
    jmp 0x0000:0x8000       ; actual jump segment offset memory location 


loop_exit:                  ; infinite loop to keep the bootloader running
    jmp $                   ; jump 4 means go back to the current memeory address again same as jmp loop exit


msghello db "hello",0               ; the first message
msgworld db "world",0               ; the second message 
loadmsg db "Stage 2 loaded!",0      ; third/debug message
times 510 - ($ - $$) db 0           ; filling the remainder bytes with 0
dw 0xAA55                           ; final boot signature 

