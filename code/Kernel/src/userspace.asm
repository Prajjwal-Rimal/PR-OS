[global switch_to_userspace]
switch_to_userspace:
    mov ebx, [esp + 4]   ; Address of your Rust user_main

    mov ax, 0x23         ; User Data Segment (Index 4 | RPL 3)
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    push 0x23            ; SS (User Data Segment)
    push 0x80000000      ; ESP (The 2 GB Userspace Stack)
    pushf                ; EFLAGS
    push 0x1B            ; CS (User Code Segment Index 3 | RPL 3)
    push ebx             ; EIP (Entry point of your Rust code)
    iret                 ; Perform the privilege switch