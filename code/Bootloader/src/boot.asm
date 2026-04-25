org 0x7c00                                              ; starting memory address

start:                                                  ; start lable
    cli                                                 ; clearing interrupts
    xor ax,ax                                           ; setting ax operation to 0, using xor save a byte
    mov ds,ax                                           ; setting the data segment to 0
    mov es,ax                                           ; setting the extra segment to 0
    mov ss,ax                                           ; setting the stack segment to 0
    mov sp,0x7c00                                       ; setting the stack pointer to the starting address
    sti                                                 ; restarting the interrupts

; the first implementation set bx as 0x8000 though it was supposed to work i think due to the segment and offset addressing it was reading data from the wrong location
; hence this is why i think it was booting through the hardisk also os devs guides theat es:bx
; https://wiki.osdev.org/Disk_access_using_the_BIOS_(INT_13h)
;bios in int 0x13 dies segment and offset adressing based on es:bx

; reading stage 2 from the disk
    mov ah,0x02                                         ; bios read sector, telling the bios to rread from the specified source
    mov al,8                                            ; number of sections to read from the dis, each section is of 512 bytes
    mov ch,0                                            ; specifying which ring of the disk should the data be read from
    mov cl,2                                            ; specifying the section to be read from, sections start from 1 not 0 all the way to 63
    mov dh,0                                            ; which plate to read from, which head to read from
    mov dl,0x80                                         ; specifing the type of drive 0x00 is floppy disk , 0x80 is hard disk, 0x01 is floppy disk 2
    mov bx,0x0800                                       ; read and write location, bios sees this and starts reading from this location
    mov es,bx                                           ; data cant be loaded directly into the es segment
    mov bx,0x0000
    int 0x13                                            ; interrupt that lets the bios read the file from the above parameters
    jc bootloader_loop                                  ; if failed to read the disk go to the inifnite loop instead of crashing


stage2_jump:
    jmp 0x0000:0x8000                                   ; actual jump segment offset memory location


; LOOP TO KEEP THE BOOTLOADER RUNNING 
bootloader_loop:                                        ; bootloader loop 
    jmp $                                               ; jumping back to the current memory address i.e the bootloader_loop

    times 510 - ( $- $$ ) db 0                          ; setting the remaining bits of the first stage to 0
    dw 0xaa55                                           ; final verification boot signature
