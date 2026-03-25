## decimal 
- base 10
- 0-9
- each position is a power of 10

## binary 
- base 2
- only 0 and 1
- each position is  a power of 2
- in low level circuits 1 means on (electricity flows) 0 means off

## hexadecimal
- base 16
- 0-9 and a-f
- each position is a power of 16

## signed binary
- binary is grouped in sets of 4 bits, 8 bits = 1 byte
- to see if a signed bit is positive or negative see the top most bit of the number if 0 [positive] if 1[negative]

## cpu arch
- does 3 main things:  fetch, decode, execute
    1. fetch instructions from the memory
    2. Decoding or identifying the instruction
    3. Execution of the instruction
- has may components
	- registers
		-  fast storage inside the cpu, hold numbers temporarily
		- ax,bx,cx,dx,sp,bp,si,di,cs,ds,es,ss
	- alu (arithmetic logical unit) : does math and logic
		- add ax, bx -> alu adds them
	- control unit
		- tells everything else what to do
		- read instruction from memory , decodes them and singles the alu or registers what to do
	- flag
		- indicate the result of operation
		- z, zero flag indicates the result was 0
		- sf signal flag indicates the result was negative
		- cf carry flag indicates the result was overflowed
	- bus interface
		- communicate between the components, memory, and i/o

## modes of cpu
1. REAL MODE: 
	- default mode
	- 16 bit
	- uses segment:offset memory
	- can access 1 MB max memory
2. PROTECTED MODE:
	- can be 32 or 64 bit
	- full access to the memory
	- full access to multitasking
3. SYSTEM MANAGEMENT MODE:
	- used for power management and security
	- SPECIFIC FOR A CHIP

## memory access
- cpu reads and writes in addresses
- real mode: physical address = segment*16 + offset
- registers like ax,bx,si,di hold values to calculate the address

---


# Assembly basics
- Linux runs in protected 32 or 64 bit mode
- registers eax[32bit] or rax[64bit], drop the e and it becomes 16 bit
- and there is no segment:offset memory calculation it is a **flat** memory


## Basic type of registers
1. EAX: used for math and system calls
2. EBX: base, often stores address
3. ECX: counter (used for loops)
4. EDX: data, sometimes for i/o or system call parameters
5. ESI: source index (string/memory copy)
6. EDI: destination index
7. ESP: stack pointer
8. EBP:base pointer (for function frames)

segment registers: are modify ignored in protected mode but are useful for low level utilization

## structure of a program
section .data
    - static data / string, initialized data or constants
    - this data does not change at runtime
section .bss
    - uninitiated variables
    - declare variables here
section .text 
    - code
    - `global _start` is compulsory it is the entry point
    - `global _start` tells kernel where the execution stars


- cpu starts at _start
- each instruction is executed line by line
- system calls invoke kernel services
- stack is automatically used for system calls

 
**system call** is a request form the program to the kernel to do something
- in x86 they are invoked through the int 0x80 or 80h like command
- the system call number **is placed in the eax register** 
- **arguments** for the system call go inside the **ebx, ecx, edx, esi, edi, etc.** registers


common syscalls:
1: exit	: end the program
3: read	: read from file/keyboard
4: write: write to file/stdout
5: open : open file
6: close: close file
7: fd(file descriptor) (0=stdin, 1=stdout, 2=stderr)


**Interrupts** are signals to the cpu to stop the flow of the and handle something
- are of 2 types:
	1. hardware (that come from the keyboard)
	2. software (int 0x80)
- basically say look at the syscall and do something


## Processors data sizes:
1. word: 2 byte
2. double word : 4 byte
3. quadword: 8 byte
4. paragraph: 16 byte
5. kilobyte: 1024 bytes
6. Megabyte: 1,048,576 bytes

## Comments in assembly
- ; colon is for comments
- `add eax, ebx     ; adds ebx to eax`

## Assembly Language Statements
has 3 types of statements
	
1. executable instructions
- tell processors what to do
- each instruction consists of  operation code
- each executable instruction is one machine language instruction
    
2. assembler directives
- tell the assembler about various aspects of the assembly process
- non executable and do not generate machine language instruction
    
3. macros
 - text substitution mechanisms


## Syntax of assembly language 
[label] mnemonics [operands] [comments]

basic instruction has 2 parts:
1. name of the instruction [mnemonics]
2. operand or parameters

## Example statements

```nasm
inc count ; increments the memory variable count 

mov total,48 ; transfers 48 in the variable total

add ah,bh ; adds the content of bh register into ah register

and mask1,128 ; perform and operation on variable mask1 and 123

```

## nasm statements for compilation and executable

```bash
nasm -f elf [asm file name]

ld -m [arch: elf_i386] -s -o [executable file name] [ input file name]

./ [executable name]
```


---

##  Hello world Explanation
```nasm 
 section .data
      msg db 'Hello World', 0xa   ;string to be printed
                                  ;db defines the bytes
                                  ; 0xa is for new line character
      len equ $ - msg             ; length of the string
                                  ; equ defines constant
                                  ;$ for current memory address
                                  ; basically saying the current length of the memory is constant for the text above
  
  section .text
  global _start                   ; must be declared for the linker
  
   _start:                         ; tells where the program starts
       mov edx,len                 ; message length into edx register
       mov ecx,msg                 ; message to write
                                   ; pointer to the message
       mov ebx,1                   ; file descriptor
       mov eax,4                   ; system call fro write
       int 0x80                    ; interrupt calling the kernel, and then execute the syscall
   
       mov eax,1                   ; exit system call
       mov ebx,0                   ; exit system call message
       int 0x80                    ; kernel system call
   
```

## Memory segments
- we could replace `section .data` with `segment .data` and it would still work
- each section is a different memory segment 
- each segment exists to keep things organized and efficient
- the cpu and the os use these segments to manage memory safely
- THE SYSTEM MEMORY IS DIVIDED INTO GROUPS INDEPENDENT SEGMENTS, WHICH ARE REFERENCED BY THE POINTERS LOCATED IN THE SEGMENT REGISTERS

- each segment contains a specific type of data

- Code (.text) -> instructions
- Data (.data) -> known values
- BSS (.bss) -> empty variables (zeroed)
- Stack -> temporary working area


```nasm
segment .data
    msg db 'hello world',0xa    ;the message we need to print with new line
    len equ $ - msg

segment .text
global _start

_start:
    mov edx,len 
    mov ecx, msg
    
    mov eax,4 
    mov ebx,1
    int 0x80

    mov eax,1
    mov ebx,0
    int 0x80
```


## Registers
- accessing data from memory slows the processor
- processor has internal memory called **registers**
- registers store data elements without having to access the memory 
- they store data temporarily while cpu works

There are 10 32 bit and 6 16 bit registers in IA-32 architecture.

1. General Registers: used for arithmetic logic and moving data
    1. data registers
        1. eax: accmulator
        	- accumulator for main arithmetic i/o 
        2. ebx: Base
            - base used for addressing memory
        3. ecx: Count
            - used for loops and repeated operations
        4. edx: Data
            - used with eax for multiplication division and i/o handelling
    2. pointer registers
        1. EIP: Instruction pointer
        	- points to the next instruction to execute
        2. ESP: Stack Pointer
            - points to the top of the  stack
        3. EBP: Base pointer
            - reference function and parameters on the stack
    3. index registers
        1. ESI: Source Index
            - used in string operations
        2. EDI: Destination Index
            - used as destination in string to copy and move
            - If you were copying s2 to another buffer, ESI would point to s2 and EDI to the destination

2. Control Registers (FLAGS): each flags stores the status of cpu after operations, each flag is **_1 BIT_**; Arithmetic operations like ADD or SUB update these flags automatically.
    1. overflow flag: arithmetic went out of range
    2. direction flag: for the direction of the operation left - left or right - right
    3. interrupt flag: interrupt enable or disable
    4. trap flag: used for singe step debugging
    5. sign flag: positive or negative results 
    6. zero flag: used to compare two numbers Zero – result = 0?
    7. auxiliary carry flag: used for specialized arithmetic like binary coded decimal
    8. parity flag: Parity even/odd number of 1-bits used for Error checking 
    9. carry flag: overflown from the most significant bit 

3. Segment Registers: CPU looks at DS (data segment) + msg offset to find the actual memory address.
    1. code segment (CS): for instructions
    2. data segment (DS): pag for variables 
    3. stack segment (SS): pages for stack, push pop value goes here
    4. Extra segments (ES,FS,GS): optional storages


## Printing an array of 9 stars using assembly

```nasm
section .data
    initialmessage db 'printing 9 stars in assembly', 0xa   ; message with newline
    leninitialmessage equ $ - initialmessage                ; length of the initial message tells from the start($) to the end(-) of initial message
    stars times 9 db '*'                                    ; times 9 kind of defines an array of 9 db each filled with a *
    lenstars equ $ - stars                                  ; length of the stars to avoid hard coding values
    newline db 0xa                                          ; to manually insert newline where needed

section .text
global _start

_start:
    mov eax,4                   ; syscall for fd
    mov ebx,1                   ; fd stdout
    mov ecx,initialmessage      ; points to the message that needs to be written
    mov edx,leninitialmessage   ; telling that go till the end of the message
    int 0x80                    ; interrupt to call the kernel


    mov eax,4                   ; syscall for fd
    mov ebx,1                   ; fd stdout
    mov ecx,stars               ; points to the message that needs to be written
    mov edx,lenstars            ; telling that go till the end of the message
    int 0x80                    ; interrupt to call the kernel

    mov eax,4                   ;syscall for fd
    mov ebx,1                   ;syscall for stdout 
    mov ecx, newline            ; calling newline
    mov edx,1                   ; number of byte/s to write
    int 0x80                    ; calling the kernel           


    mov eax,1                   ; syscall for exit
    mov ebx,0                   ; exit code to show program was complete
    int 0x80                    ; interrupt to call the kernel

```
 

## System Calls
- way program talks to the kernel
- used to print things on the scree, read from keyboard, open or close files, and exit the program
- to get a kernel to do something use a system call

1. put the syscall number in the eax register
2. place the arguments in the necessary registers
    1. ebx: 1st argument
    2. ecx: 2nd argument
    3. edx: 3rd argument
    4. esi: 4th argument
    5. edi: 5th argument
    6. ebp: 6th argument
    7. if more than 6 argument pass the pointer to them in ebx
    8. any result comes back to eax after interrupt


## Taking use input via syscalls


```nasm
section .data
    userMsg db 'Please enter a number: '    ; asking the user to enter a number 
    lenUserMsg equ $ - userMsg              ; the length of the user messgage
    dispMsg db 'You have entered: '         ; displaying the message of the use
    lenDispMsg equ $ - dispMsg              ; length of the message of the message to display
    newline db 0xa                          ; newline code

section .bss
    usernum resb 5                          ; reserve 5 bytes for the usernum

section .text
global _start

_start:

    mov eax,4                               ; syscall 4 for fd
    mov ebx,1                               ; STDOUT fd
    mov ecx,userMsg                         ; go to the memory location of userMsg
    mov edx,lenUserMsg                      ; stay till the length of the message
    int 0x80                                ; calling the kernel

    mov eax,3                               ;syscall for read from the input
    mov ebx,0                               ; to read from the key board may work with 2 as well
    mov ecx,usernum                         ; moving the register to the beginning of the uninitialized register
    mov edx,5                               ; the size of the input
    int 0x80                                ; syscall to call the kernel

    mov eax,4                               ;syscall 4 for fd
    mov ebx,1                               ; stdout fd
    mov ecx,dispMsg                         ; start of the memory location of dispmsg
    mov edx,lenDispMsg                      ; till the end of the dispmsg
    int 0x80                                ; interrupt to call the kernel

    mov eax,4                               ; syscall 4 for fd
    mov ebx,1                               ; stdout via 1 in fd
    mov ecx,usernum                         ; go to the beginning of the usernum
    mov edx,5                               ; the next 5 bits
    int 0x80                                ; interrupt to call the kernel        

    mov eax,4                               ; syscall 4 gfor fd
    mov ebx,1                               ;stdout
    mov ecx, newline                        ; calling new line
    mov edx,1                               ; size of newline
    int 0x80                                ; interrupt to call the kernel

    mov eax,1                               ; syscall for exit
    mov ebx,0                               ; exit code
    int 0x80                                ; interrupt to call the kernel

```


## Addressing modes
addressing mode tells cpu: where the data is coming from

defines how to find the specified data

are of 3 types:

1. Register addressing (fastest)
    1. data is stored in the cpu registers 
    2. `mov ax,bx`
    3. both operand are registers
    4. super fast and no memory access needed
2. Immediate addressing (constant value)
    1. 5 and 10 are constant in the example above
    2. no lookup is needed
    3. its more of exact value addressing the value is directly written in the instructions
    2. `mov ax,5	add ax,10` 
3. Memory addressing (slower)
    1. data is stored in ram, not registers
    2. `mov ax,value`
    3. cpu must go to the memory to fetch the data and that is slower than accessing from the registers
    4. has various types
        1. direct addressing
            - we directly specify the variable name
            - address is known at compile time
            - `mov ax,value`
        2. direct offset addressing
            - access elements using an index
            - used for arrays 
            - offset = position in the memory
            - `MOV AL, ARRAY[2]			
MOV AL, ARRAY + 2`
        3. indirect addressing
            - the address is stored inside the register
            - basically saying go to that address
            - `MOV BX, ARRAY			
MOV AL, [BX]`

4. The mov instruction:
- syntax : `mov destination, source`
- valid forms of the move instruction
```nasm
MOV AX, BX        ; register ← register
MOV AX, 5         ; register ← immediate
MOV AX, VALUE     ; register ← memory
MOV VALUE, AX     ; memory ← register
MOV VALUE, 10     ; memory ← immediate
```
- rules for move instruction:
    * same size required, cant do 16 bit with 8 bit
    * memory to memory mov is not allowed
    * source doesn't change
    * when writing to memory the size must be made clear
    * `MOV [BX], BYTE 10
MOV [BX], WORD 100` 
	* byte = 1 byte, word = 2 bytes, dword =4 bytes, qword = 8 bytes, tbyte = 10 bytes

## writing and changing name using memory registers and adressing
```nasm
section .data
    name db 'John doe'					; defining thee initial name
    lenname equ $ - name				; length of the name
    newline db 0xa						; defining newline
    lenNewline equ $ - newline			; length of newline

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

```


## Variables
- variables is a reserved location in the memory
- everything is just bytes, no string, int, float, etc
- string is just an array of bytes

|directive|size|use|example|
|-|-|-|-|
|db|1|byte| DB  'y' |
|dw|2|word| DW  12345 or DW  -12345 (in 2s compliment) |
|dd|4|doubleword| DD  1.234 (32 bit number) |
|dq|8|quadword| DQ  123456789 (64 bit number) |
|dt (rarely used)|10|ten bytes|DT 0.1234567890123 (80 bit numbers) |

- data is saved as ascii bytes
- decimal numbers are converted into little-endian order
- negative numbers are 2 compliment
- floating numbers can be of 32 bit or 64 bit 
- string is an array of bytes 


|directive|size|use|
|-|-|-|
|resb|1|reserve byte|
|resw|2|reserve word|
|resd|4|reserve doubleword|
|resq|8|reserve quadword| 
|rest|10|reserve ten bytes|
- `buffer RESB 20   ; reserve 20 bytes for later use`

1. we can allocate multiple variables in the sequence, continuous memory layout (stored in a continuous sequence in the memory)

```
choice    DB  'Y'
number1   DW  12345 ; stored in a continuous sequence
number2   DD  123456789 ; stored in a continuous sequence
```

2. we can have multiple initialization with times, like arrays
```
marks TIMES 9 DW 0   ; defines 9 words, all initialized to 0
stars TIMES 9 DB '*' ; defines 9 bytes, all '*'
```
3. string are just array of bytes
    1. we can access characters using low and high registers al/ah
    2. or we can access string using the entire register like ax

> Little-endian means the lowest byte of the number goes into the lowest memory address.

## printing 10 stars
```nasm
section .data
    starsSeq times 10 db '*'
    lenStarSeq equ $ - starsSeq
    newline db 0xa

section .text
global _start
_start:

    mov eax,4
    mov ebx,1
    mov ecx,starsSeq
    mov edx,lenStarSeq
    int 0x80

    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,1
    int 0x80

    mov eax,1
    mov ebx,0
    int 0x80

```


## constants
- fixed values to use in the code
- 3 ways to define them :

    1. equ (think like equals)
        - can not be changed later 
        - can store numbers or expressions
        - `constant_name equ EXPRESSION` 
    2. %assign directive
        - this is for numeric constants that can be redefined later
        - `%assign CONSTANT_NAME value`
        - `%assign TOTAL 10`
        - `%assign TOTAL 20  ; can change the value later`
    3. %define directive
    	- can be numeric or string
    	- similar to c structure #define
    	- `%define CONSTANT_NAME value`
    	- `%define PTR [EBP+4]`
    	- `%define MSG 'Hello!'`
    	- `mov eax, PTR  ; replaces PTR with [EBP+4]`
    	- can be redefined
    	- case sensitive
    	- works with numbers, registers, memory reference, and text placement


## defining constants
```nasm
section .data
    kernel_interrupt equ  0x80
    newline equ 0xa

    sys_exit equ 1
    sys_write equ 4
    stdin equ 0
    stdout equ 1

    msg1 db	'Hello, programmers!',0xA,0xD
    len1 equ $ - msg1

    msg2 db 'Welcome to the world of,', 0xA,0xD
    len2 equ $ - msg2

    msg3 db 'Linux assembly programming! '
    len3 equ $ - msg3


section .text
global _start
_start:

    mov eax,sys_write
    mov ebx,stdout
    mov ecx,msg1
    mov edx,len1
    int kernel_interrupt

    mov eax,sys_write
    mov ebx,stdout
    mov ecx,newline
    mov edx,1
    int kernel_interrupt

    mov eax,sys_write
    mov ebx,stdout
    mov ecx,msg2
    mov edx,len2
    int kernel_interrupt
  
    mov eax,sys_write
    mov ebx,stdout
    mov ecx,newline
    mov edx,1
    int kernel_interrupt

    mov eax,sys_write
    mov ebx,stdout
    mov ecx,msg3
    mov edx,len3
    int kernel_interrupt

    mov eax,sys_write
    mov ebx,stdout
    mov ecx,newline
    mov edx,1
    int kernel_interrupt    
    
    mov eax,sys_exit
    mov ebx,0
```
