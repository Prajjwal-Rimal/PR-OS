org 0x7c00          ; start at the address 0x7c00
start:              ; main function/start function
    cli             ; disableing interrupts cli =(clear interrupts)
    xor ax,ax       ; comparing ax to ax since they will be the same the ouput in the ax register will be saved as 0, we could also do mov ax,0
    mov ds,ax       ; data segment has the value 0
    mov ss,ax       ; stack segment has the value 0
    mov sp,0x7c00   ; mobving the stack pointer to the address where the program starts from it will grow downwards not upwoards
    sti             ; starting the interrupts

    mov ah,0x0e     ; bios teletype function
                    ; it is part of the bios interrupt
                    ; allows the prnting of basic characters to the screen
                    ; calling ah,0x0e the bios will take a value from the al register and show it on the screen and jump to the new character
    mov al,'a'      ; 8 bits to show the value a, this is the character that the ah will print
    int 0x10        ; calling bios video interrupt

hang:               ; loop name
    jmp hang        ; always jump back to the start of the loop, and dont end

times 510 -($-$$) db '0'    ; fill with 0 upto 510 bytes and keep track of where we are
dw 0xaa55           ; final signing of the 512 bits of the bios
