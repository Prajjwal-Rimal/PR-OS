; if this portion is placesd in the stage 2 kernel the linker has a hard time to find this code
; and ity is also for code cleanliness
; the kernel bootloader doesnt see the kernel.asm file at all int he second stage bootloader we added 
; the 1 mb jump and the kernel and then we made this file and a linker file which starts at 1 mb so the 
; linker file loads the kernel asm fiile at 1 mb


[bits 32]

global _start

extern kernel_main              ; informing the assembler about the kernel main function 

_start:

    
    call kernel_main            ; this finds the kernel main function and then transitions to the assembly code
    jmp $                       ; making sure the cpu jumps and stays at the curerent memory address/line