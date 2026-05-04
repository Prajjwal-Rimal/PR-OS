[bits 32]
global idt_load
global isr0
global isr33
extern idtp
extern idt_handler

idt_load:
    lidt [idtp]
    sti             ; Enable interrupts
    ret

; Division by Zero
isr0:
    push byte 0
    push byte 0
    jmp isr_common_stub

; Keyboard IRQ
isr33:
    push byte 0
    push byte 33
    jmp isr_common_stub

isr_common_stub:
    pusha
    mov ax, ds
    push eax
    mov ax, 0x10    ; Kernel Data Segment
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    call idt_handler
    pop eax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    popa
    add esp, 8
    iret