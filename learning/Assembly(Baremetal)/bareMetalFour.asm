org 0x7c00                  ; telling the cpu to start from this location
start:                      ; main function of the program
    cli                     ; this is to clear the interrupts during stack setup
    xor ax,ax               ; setting the ax bit to 0 xor operation takes 2 bit instead of 3 taken by mov, plus it is the fastest way to set a registe to 0
    mov ds,ax               ; setting data segment to 0
    mov ss,ax               ; setting stack to 0
    mov sp,0x7c00           ; setting stack pointer to the load address
    sti                     ; setting up the interrupts again

    mov si, msg             ; si is the source index register basically tells hey look at this location for the data you trying to find

print_loop:                 ; print loop start and lable
    lodsb                   ; loads the first character stored in the al register and then moves to the next one
    cmp al,0                ; cmp compare the values and checks if the character in al is equals to 0 
    je done                 ; if the message has a 0 in the end then then je (jump if equal) goes to the done loop 

    mov ah,0x0e             ; using tele type print function
    int 0x10                ; int 0x10 prints one character from the al register and prints it 
                            ; we are using a 16 bit system so that is why it is like ah register stores the command and al does the value instead of using the entire register as ax
        
    jmp print_loop          ; this is an loop until the je condition is met if our msg does not have the last byte 0 it would be an infinite loop

done:                       ; this is the new infinite loop
    jmp $                   ; jmp $ makes it so that the loop always jumps to the current instruction in the memory same as done : jmp done

msg db " hello world",0     ; the message to print with the last byte as 0

times 510 - ($-$$) db 0     ; populating the remaining bits with 0 value not the string 
dw 0xaa55                   ; verification bits for the bios
