## Assembly as a language

| # | What | Why|Fix|
| - | --- | --- |--- |
| 1 | bad syntax for EQU | Tried to make lenstars include the newline like $ - stars, 0xA. NASM doesn’t like that. | Just made a separate newline variable and kept lenstars simple.|
| 2 | Symbol not found for initialmessage | Typo! Sometimes wrote intitialmessage instead of initialmessage. | Fixed all the typos so everything matches.|
| 3 | Weird output like .shstrt after running | 32-bit code on a 64-bit system got linked wrong. | Assembled with -f elf32 and linked with -m elf_i386.|
| 4 | No newline after stars, so terminal prompt mashed with stars| Forgot to print a newline after the stars.| Added a separate newline variable and printed it after the stars. |
| 5 | Tried to print newline by just changing ecx/edx without new int 0x80 | Only the last values before the interrupt count, so the stars didn’t print.| Made a **second sys_write call** just for the newline.|
| 6 | Confused about why edx was needed for the newline | Thought maybe eax/ebx/ecx was enough.  | Learned: edx always needs the length of bytes to write, even if it’s 1 char. |
| 7 | Tried times 10 db '*' to include newline | times just fills everything with *, so newline never worked.| Either define newline separately, or manually put it as the last byte.|
| 8 | 32-bit syscalls acting weird on modern 64-bit Linux | Because the environment defaults to 64-bit.| Always assemble for 32-bit and link as 32-bit, problem solved.|
|9| Segmentation fault when reading input| tried to read or write more bytes than reserved in .bss | either reserve enough space or track how many bytes were actually read|

## Bare metal programming in assembly

| # | What | Why|Fix|
| - | --- | --- |--- |
|1| bit 16 | nasm doesn't need the bit 16 declaration it throws an error | remove that line for bare metal programming in nasm |
|2| made the first section of the bootloader more than 512 bytes| `times 512 - ($ - $$) db 0 & dw 0xaa55` |`times 510 - ($ - $$) db 0 & dw 0xaa55`|
| 3 | `program origin redefined` | Multiple `org` directives in the file | Keep only one `org` per file (stage 1 vs stage 2 separate) |
| 4 | `parser: instruction expected` | Invalid instruction or comment not prefixed with `;` | Fix typos or add `;` for comments |
| 5 | `org value must be a critical expression` | `org` was not a numeric constant | Use `org 0x7C00` or `org 0x8000` only |
| 6 | `invalid combination of opcode and operands` | Far jump used incorrectly (`jmp 0x0000:0x8000`) | Use `jmp far 0x0000:0x8000` |
| 7 | byte data exceeds bounds| Bootloader size exceeded 512 bytes| reduce the code size|
| 8 | symbol `loop_exit` not defined| assembler failed before reaching the level | fix the size of the bootloader |
| 9 | symbol `jump_stage2` not defined| assembler failed before reaching the level | fix the size of the bootloader |
| 10 | missing `print` label after `a20_not_supported` label | `jmp a20_not_supported_print` jumps to a non existant lable|`_print` label or use a single loop label for printing |
| 11 |  `SI` inside loop | `mov si,message` is inside the print loop, so `SI` is reset each iteration, |  `SI` separate from the print loop loop label|
