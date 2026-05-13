[global switch_to_userspace]
switch_to_userspace:
; getting the entry point to the userspace
    mov ebx, [esp + 4]

; setting upp the registers by using the value of the user data segment
    mov ax, 0x23
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

; simulating an interrupt to go back to the userspace code
    push 0x23
    push 0x80000000
    pushf
    push 0x1B
    push ebx

; returning tyo rung 3 priviledge mode
    iret
    