org 0x7c00
start:
    cli
    xor ax,ax
    mov ds,ax
    mov ss,ax
    mov sp,0x7c00
    sti

    mov ah,0            ;KEYBOARD INTERRUPT FUNCTION, the value is automatically stored in al
    int 0x16            ;interrupt to wait for the input from the keyboard

    mov ah,0x0e         ;FUNCTION FOR PRINTING TEXT TO THE SCREEN TELE TYPE FUNCTION
    int 0x10            ; bios video interrupt to print the character

hang:
    jmp hang            ; infinite loop


times 510 - ($-$$) db '0'
dw 0xaa55
