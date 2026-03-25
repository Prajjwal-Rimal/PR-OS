org 0x7c00          ; this is the address where bios loads the bootloader it is an ibm set standard everyone follows this in a bios system
start:              ; programs start kind of like the main function
    cli             ; clearing the interrupts needed to set up the interrupts properly, done as a precausion so interups do not interrupt the bios, when the stack is setting up
    mov ax,0        ; setting ax to 0
    mov ds,ax       ; setting data segment to 0
    mov ss,ax       ; setting stack segment to 0
    mov sp,0x7c00   ;setting the stack pointer to ta safe region so it doe not clash with the bootloader and uses the free memory it goes down wards from 0x7c00 and not up 
                    ; we cant directly assign o to the segment register 
                    ; 0x7C00 → 0x7DFF is the address for the first 512 bytes of the bootloade
    sti             ; this starts the interrupts
                    ; we do this cause when we start cpu registers may contain garbage data so setting all ogf them to 0 manually is better
hang:               ; lable saying that each time come back here and execute it 
    jmp hang        ; infinite loop to stop the cpu safely, and each iteration goes to the hang lable
                    ; padding bootloader to 512 bytes
    times 510-($-$$) db 0
                    ;$ means from the current memory address
                    ;$$ start of the ciurrent section
                    ;like a minus operation 510 - (current - start )
                    ;510 - ($-$$) denotes the number of bytes we need to fill up
    dw 0xaa55       ; boot signature required by bios it is a standard, bios searches for it
                    ; if bios sees this then it is bootable else it is not
                    ; this must come in the last 2 bytes of the bootsector
                    ; a;ways reserve the last 2 bytes (offset 510,511) for this address 
