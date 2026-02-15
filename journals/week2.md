# Week 2

**Date: 9 Feb 2026**

Completed the **_Literature review and strength analysis_**, finished with the research portion.

Starting the **training and development phase** of the project from 10 feb 2026

---

**Date: 10 Feb 2026**

**_Installations_** of **all the tools** required for this project like Rust, Rust Nightly, Cargo, QEMU, etc

Started with **Developer guidelines** outlining all the installation methods, tools, and  verification methods for the tools

---

**Date: 11 Feb 2026**

**_Finished_** with the **installation** of tools and **developer guidelines**

Need to make a **cross compiler gcc**, gonna try to use the **OSDev** wiki approach

Found **_sources_** to start the **learning process**

**_Started_** with the **presentation** for **WIP**

---

**Date: 12 Feb 2026**

**First meeting with the supervisor** discussed the **potential risk** that may occur during the development of the project, ranging from learning resources, to language integration, cross compiler gcc, and other challenges. 

**Further discussion** on what was achieved by the research and the literature review, established 3 key points to be addressed by the topic. 


---

**Date: 13 Feb 2026**

**Submitted_** the draft version of the report for **feedback** on **chapters 1-4**

> finalized some key aspects of the project 

1. bootloader
    1. bios boot
    2. load Stage 2 from disk
    3. jump to Stage 2
    4. enable A20
    5. setup temporary GDT
    6. switch to Protected Mode
    7. load kernel from disk into memory
    8. jump to kernel entry
    
2. kernel
    1. c (primary), assembly (hardware level control), rust (meory safety)
    2. gdt
    3. idt
    4. isr stubs
    5. dyscall
    6. ring 0 and ring 3
    7. tss
    8. text driver
    9. interrupt
    10. basic error handling
    11. basic memory handling

3. Userspace
    1. simple program 
    2. unix like commands are also program : help echo, etc.
4. Ring 0 and ring 3 separation **_Important_**

5. document everything

6. evaluation on the basis of 
    1. lines of assembly, c, rust, unsafe Rust
    2. runtime behavior (boot time)
    3. development difficulty comparison
    4. memory safety comparison
    5. complexity, learning curve


> Things to learn:

1. c
    1. basic syntax
    2. functions
    3. header files
    4. extern
    5. pointers
    6. structs
    7. arrays
    8. volatile keyword
    9. basic makefile usage
    10. c compilation to object files
	11. and maybe
		1. File I/O
		2. malloc/free



2. assembly
    1. Registers (eax, ebx, ecx, edx, esp, ebp)
	2. mov
	3. call / ret
	4. jmp
	5. push / pop
	6. cli / sti
	7. lgdt
	8. lidt
	9. int
	10. iret
	11. Stack behavior
	12. Real vs Protected mode
	13. maybe
		1. floating 
		2. optimization

refer to the cpu instruction manuals


4. for the bootloader 
    1. bios boot process
	2. boot sector layout
	3. disk loading via BIOS interrupt 13h
	4. a20 line
	5. Switching er0 to protected mode

5. for interrupt and syscalls
    1. pic 
    2. remapping pic
    3. isr structure
    4. int instruction
    5. eor 

6. for ring 3 and ring 0
    1. descriptor privilege level 
    2. cpl
    3. rpl
    4. tss structure
    5. stack switching on privilege change
    6. iret behavior when changing rings

7. rust 
    1. basic rust syntax
    2. ownership
    3. borrowing
    4. #![no_std]
    5. extern "C"
    6. #[no_mangle]
    7. unsafe blocks

8. final build and link
    1. what object files are
    2. what linker script does
    3. memory sections (.text, .data, .bss)
    4. entry point symbol

> what to do of the cross compiler gcc

1. try to find pre existing solutions that can work (did not find the page doesn't exist anymore)
2. build using binutils and gcc (seems the more likely option)
    - the tutorials say download a bunch of things but don't explain why should i download it
    - it is a bit intimidating 
    - only reliable process seems to be the one hiligted in the OSDev wiki