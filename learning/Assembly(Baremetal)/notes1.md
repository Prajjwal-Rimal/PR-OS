## WHAT HAPPENS WHEN A COMPUTER STARTS

1. CPU starts in an predefined state
2. bios runs
3. bios loads the first 512 bytes from the disk
4. CPU jumps to that memory address and executes

## real mode
1. bare metal programming at least for the bootloader in 16 bit (real mode)
2. so just ax registers and all no eax and rax, we do have access to al ah
3. memory is limited to 1 MB
4. memory uses segmentation

## memory addressing (segmentation)
> physical address = segment *16 +offset

example: 
```
ds = 0x1000
si = 0x0020

0x1000 * 16 + 0x0020 = 0x10020
```

this is because earlier CPU could not handle 20 bit addresses directly

## segment registers
- cs : code segment
- ds : data segment
- ss : stack segment
- es : extra segment

it is necessary to set these to show where memory points to

## the stack
1. the stack is just a segment of memory
2. uses `ss:sp`
3. if stack is not set call,ret,push wont work 
4. example

```
mov ss, 0x0000
mov sp, 0x7C00

on push:
SP decreases
value stored at SS:SP
```

## comparison to assembly as a programming language 
mov, add, sub, cmp, jmp, je, lables, loops are all the same no changes in them

## things to note
1. no system calls
2. no memory allocation or file system
3. just **BIOS interrupts**

```nasm
; example for red key
mov ah, 0x00
int 0x16
```

```nasm
; example for read disk
mov ah, 0x02
int 0x13
```

4. memory is just bytes there are no sections like `section .data` instead `msg db "Hello", 0`
5. it is infinite execution needs manual exit `jmp $`
6. binary layout matters such as last 2 bytes must be `dw 0xAA55`
7. numbers in **hexadecimal**
8. file will be compiled from .bin, and not.asm
9. and quemu command will be 
`nasm -f bin bootloader.asm -o bootloader.bin`
`qemu-system-x86_32 -fda bootloader.bin`

