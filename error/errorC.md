# C Error Log

|#| what | why | fix |
| - | ---- | --- | --- |
| 1 | used `const char *tagline[] = "..."` | this declares an array of pointers, but you assigned a single string | use `const char *tagline = "..."` |
| 2 | used `start_col_tagline << 8` for color | column value is not a color, so VGA showed wrong colors | use `tagline_vga_color_scheme << 8` |
| 3 | wrote logo text without quotes | C treats unquoted text as variables, causing syntax errors | wrap each line in quotes `"..."` |
| 4 | missing function declaration for `terminal_clear` | compiler saw function call before its definition | add prototype `void terminal_clear();` or move function above |
| 5 | misunderstanding VGA write | writing only character without proper 16-bit format breaks display | combine char + color using `char \| (color << 8)`|
| 6 | Physical Memory Mismatch |	Pointing ESP to an address (e.g., 1 GB or 4 GB) that does not exist in the emulator's allocated RAM. | Allocate sufficient physical RAM in QEMU using the -m flag (e.g., -m 4096) to back the logical stack address. |
|7 | Unpacked GDT Structures | The C compiler added hidden padding bytes to the GDT struct to align memory, which corrupted the table format the CPU expected| Added `__attribute__((packed))` to the GDT structures to force the compiler to keep the binary layout exact |
| 8 | Makefile Error | Using spaces instead of Tabs for command indentation in the Makefile | Replaced leading spaces with a single Tab character for every rule command |
| 9 | GDT Flush Crash | Updated the Code Segment (CS) using a standard mov instruction, which is prohibited in Protected Mode | Implemented a Far Jump `jmp 0x08:` in assembly to force the CPU to reload the CS register with the new descriptor |