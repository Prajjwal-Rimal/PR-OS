
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
