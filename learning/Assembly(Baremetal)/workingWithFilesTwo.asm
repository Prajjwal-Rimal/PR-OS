; STAGE 2
org 0x8000
start:

    cli                 
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ax, 0x9000
    mov ss, ax
    mov sp, 0x9FFF  

    mov si,msghellow

loop_hello_message:         
    lodsb                   
    cmp al,0                
    je loop_exit_stage_2         
    mov ah, 0x0e            
    int 0x10                
    jmp loop_hello_message  

loop_exit_stage_2:          
    jmp $                   
    
msghellow db "hello from stage 2 ",0