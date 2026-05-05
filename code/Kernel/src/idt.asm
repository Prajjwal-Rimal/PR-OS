global idt_flush

idt_glush:
    mov eax, [esp+4]
    lidt [eax]
    sti
    ret

; 2 different type of interrupt routines, one with error code, and one without error code

%macro ISR_NOERRORCODE 1
    global isr%1
    isr%1:
        cli
        push long 0
        push long %1
        jmp isr_common_stub
%endmacro


%macro ISR_ERRORCODE 1
    global isr%1
    isr%1:
        cli
        push long %1
        jmp isr_common_stub
%endmacro

%macro IRQ 2
    global irq%1
    irq%1:
        cli
        push long 0
        push long %2
        jmp irq_common_stub
%endmacro

; setting up interrupt service routine with error codes
ISR_NOERRORCODE 0
ISR_NOERRORCODE 1
ISR_NOERRORCODE 2
ISR_NOERRORCODE 3
ISR_NOERRORCODE 4
ISR_NOERRORCODE 5
ISR_NOERRORCODE 6
ISR_NOERRORCODE 7
ISR_ERRORCODE 8
ISR_NOERRORCODE 9
ISR_ERRORCODE 10
ISR_ERRORCODE 11
ISR_ERRORCODE 12
ISR_ERRORCODE 13
ISR_ERRORCODE 14
ISR_NOERRORCODE 15
ISR_NOERRORCODE 16
ISR_NOERRORCODE 17
ISR_NOERRORCODE 18
ISR_NOERRORCODE 19
ISR_NOERRORCODE 20
ISR_NOERRORCODE 21
ISR_NOERRORCODE 22
ISR_NOERRORCODE 23
ISR_NOERRORCODE 24
ISR_NOERRORCODE 25
ISR_NOERRORCODE 26
ISR_NOERRORCODE 27
ISR_NOERRORCODE 28
ISR_NOERRORCODE 29
ISR_NOERRORCODE 30
ISR_NOERRORCODE 31
ISR_NOERRORCODE 128
ISR_NOERRORCODE 177

IRQ   0,    32
IRQ   1,    33
IRQ   2,    34
IRQ   3,    35
IRQ   4,    36
IRQ   5,    37
IRQ   6,    38
IRQ   7,    39
IRQ   8,    40
IRQ   9,    41
IRQ  10,    42
IRQ  11,    43
IRQ  12,    44
IRQ  13,    45
IRQ  14,    46
IRQ  15,    47

extern isr_handler
isr_common_stub:
    pusha
    mov eax,ds
    push eax
    mov eax, cr2
    push eax
    mov ax,0x10
    mov ds,ax
    mov es,ax
    mov fs,ax
    mov gs,ax

    push esp
    call isr_handler
    add esp,8
    pop ebx
    mov ds,bx
    mov es,bx
    mov fs,bx
    mov gs,bx

    popa
    add esp,8
    sti
    iret


extern irq_handler
irq_common_stub:
    pusha
    mov eax,ds
    push eax
    mov eax, cr2
    push eax
    mov ax,0x10
    mov ds,ax
    mov es,ax
    mov fs,ax
    mov gs,ax

    push esp
    call irq_handler
    add esp,8
    pop ebx
    mov ds,bx
    mov es,bx
    mov fs,bx
    mov gs,bx

    popa
    add esp,8
    sti
    iret
