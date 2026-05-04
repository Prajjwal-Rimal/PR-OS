global gdt_flush

gdt_flush:
    cli
    mov eax,[esp+4]
    lgdt [eax]
    mov ax, 0x10                
    mov ds, ax
    mov es, ax
    mov gs, ax
    mov fs, ax         
    mov ss, ax     
    jmp 0x08: .flush               
    sti

.flush:
    ret