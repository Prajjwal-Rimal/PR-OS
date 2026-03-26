org 0x7c00                  ;start address of the program
start:                      ; start lable main function
    cli                     ; clearing the interrupt
    xor ax,ax               ; xor operati0on to set the ax bit to 0
    mov ds,ax               ; seting the value of the data segment to 
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
    lodsb                   ; loads the bytes into the al register from the messsage then increment to the nmext value
    cmp al,0                ; compare the values in the al register to 0
    je loop_exit            ; if value matches got ot the infinite loop
    mov ah, 0x0e            ; calling the bios teletypoe function
    int 0x10                ; calling the interrupt to print to the screen
    jmp loop_world          ; go back to the staring of this loop lable and repeat


loop_exit:                  ; infinite loop to keep the bootloader running
    jmp $                   ; jump 4 means go back to the current memeory address again same as jmp loop exit

msghello db "hello",0
msgworld db "world",0
times 510 - ($-$$) db 0
dw 0xaa55                   ; bios last 2 bytes signature



; register never have fixed roles same for hexadecma vcalues, everything is just nummers their meaning depend on how we define them
