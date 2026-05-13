global gdt_flush

gdt_flush:
; setting the eax register to the gdt pointer
; setting up the stack for the new gdt
    mov eax, [esp+4]    
    lgdt [eax]          
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov gs, ax
    mov fs, ax         
    mov ss, ax     
    jmp 0x08:.flush

; finalizing the gdt by using jump to update the value ofd the registers
; and returning back to the stack and the c code
.flush:
    ret

; global tss_flush
; tss_flush:
;     mov ax, 0x2B
;     ltr ax
;     ret

