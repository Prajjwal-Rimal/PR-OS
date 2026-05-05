[global switch_to_userspace]
switch_to_userspace:
    mov ebx, [esp + 4]

    mov ax, 0x23
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    push 0x23
    push 0x80000000
    pushf
    push 0x1B
    push ebx
    iret