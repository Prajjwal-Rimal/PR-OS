section .data
    name db 'John doe'                  ; defining thee initial name
    lenname equ $ - name                ; length of the name
    newline db 0xa                      ; defining newline
    lenNewline equ $ - newline          ; length of newline

section .text
global _start
_start:

;using sycall4 to show the original name
    mov eax,4
    mov ebx,1
    mov ecx,name
    mov edx,lenname
    int 0x80

; using syscall 4 to add the new line
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,lenNewline
    int 0x80

; addressing using bytes and al registers to move the memory to the previous registers [direct offset addressing]
    mov [name], byte 'd'
    mov [name +1], byte 'o'
    mov [name +2], byte 'e'
    mov [name +3], byte ' '
    
    mov al, [name +4]
    mov [name+3], al
    mov al, [name+5]
    mov [name +4],al
    mov al,[name +6]
    mov [name +5],al
    mov al, [name +7]
    mov [name+6],al
    mov byte [name+7], ' '

; printing the new name from
    mov eax,4
    mov ebx,1
    mov ecx,name
    mov edx,lenname
    int 0x80

; printing newline using sycall 4
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,lenNewline
    int 0x80

; exit syscall
    mov eax,1
    mov ebx,0
    int 0x80
