; STAGE 2
org 0x8000                                          ; start address for the second stage bootloader , padding of 512 bytes from stage 1

; STACK AND INTERRUPTS
start:                                               ; setting up fresh segments for the stack
    cli                 
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ax, 0x9000
    mov ss, ax                                       ; ss can not be directly assigned a vlaue, do it via the ax register
    mov sp, 0x0000                                   ; stack pointer is set to the maximum it can go just before the reserved memory
    sti

    mov ah,0x02
    mov al,10
    mov ch,0
    mov cl,10
    mov dh,0
    mov dl,0x80
    mov bx,0x1000
    mov es,bx
    mov bx, 0x0000
    int 0x13                   

;https://wiki.osdev.org/A20_Line#Fast_A20_Gate
enable_a20:
    in al, 0x92                                       ; in reads data from the hardware i/o port to a cpu register
                                                      ; reading flom the port number 0x92 and storing it in the register al
    or al, 2                                          ; performing a bitwise operator with al and 2
                                                      ; this sets the second bit from the right 1 without changing the value of other bits
    out 0x92, al                                      ; writes the value from al register to the hardware port
                                                      ; so it is duet o ibm pc design language where keyboard port was used to enable a20 line by modify the value of ports around it an a widely used port was 0x92
    jmp protected_mode_setup


; DEFINING THE GDT TABLE
gdt_start:

    dq 0x0000000000000000                             ; defining the value for a null segment

    ; code segment
    dw 0xffff                                         ; maximum limit of the segment 4 gb
    dw 0x0000                                         ; lower base value
    db 0x00                                           ; middle base value
    db 0x9a                                           ; access right
    db 0xcf                                           ; flag  and the the upper limit limit
    db 0x00                                           ; higher base value
                                                      ; so the base is 0x00000000
                                                      ; the lower limit for the segment is 0xffff
                                                      ; the upper limit of the segment is 0xf
                                                      ; the flag for this section is 1100
                                                      ; combining the flag and limit to a byte we get 0x1100f or 0x11001111
                                                      ; in access byte 00: is kernel, 01(drivers) & 10(services) are rarely used, 11 is for userspace
                                                      ; the access byte is an hexadecimal value for thhe binary value 10011010
    ; data segment
    dw 0xffff                                       
    dw 0x0000
    db 0x00
    db 0x92
    db 0xcf
    db 0x00
                                                      ; everything is the same besides the access byte its value is 10010010
gdt_end:

                                                      ; TELLING THE CPU HOW LARGE THE GDT TABLE IS POINTER TO THE TABLE
                                                      ; gdt descriptor assumes the size of the table is always size-1
gdt_descriptor:
    dw gdt_end - gdt_start - 1                        ; size of gdt -1
    dd gdt_start                                      ; starting address if the gdt


; FAR JUMP TO THE PROTECTED MODE
 protected_mode_setup:
    cli
    lgdt [gdt_descriptor]                             ; load the gdt table
    mov eax, cr0                                      ; reading the value of the control register
    or eax, 1                                         ; setting the right most bit to one
    mov cr0, eax                                      ; setting the value of the control register to the updated value
                                                      ; cr0 is the cpus main mode control registerit contains flags about how the processor behaves
                                                      ; watch https://www.youtube.com/watch?v=BQGbBCqUGCc
                                                      ; right most bit setting it to 1 enables the protection a20_not_enabled
                                                      ; tells the cpu that we are in protected mode now
                                                      ; cr0 is not the ony control register there are more registers that do various jobs
    
    jmp 0x08:protected_mode                           ; jumping to the code segment in gdt and calling protected mode lable
                                                      ; jumping to the code segment as it allows the execution of instructions


                                                      ; without declaring bits 32 we get the following error, telling assembler generate for 32 bit instruction
                                                      ; ./src/bootStageTwo.asm:157: warning: word data exceeds bounds [-w+number-overflow]
                                                      ; ./src/bootStageTwo.asm:157: warning: word data exceeds bounds [-w+number-overflow]

[bits 32]
protected_mode:                                       ; setting the stack for the protected mode
    mov ax, 0x10                                      ; setting the protected mode stack
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ebp, 0x9ffff                                  ; setting the stack at 0x9ffff in flat memory model
    mov esp, ebp

    mov esi, 0x10000                                  ; setting the stack index to 64 kb
    mov edi, 0x100000                                 ; moving the copy index to 1 mb
    mov ecx, 2048                                     ; specifying the number of bytes to copy
    rep movsd                                         ; moving double word in each copy so each copy moves 4 bytes of data to the specified location

stage2_loop:                                          ; infinite loop to stop the bootloader from crashing
    jmp 0x08:0x100000