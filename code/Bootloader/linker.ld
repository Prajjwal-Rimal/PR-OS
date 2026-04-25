/*telling the linker script to look for the   _start lable in the specified file*/                                                                        start lable in the specified file*/
ENTRY(_start)

/*output of the file*/
OUTPUT_FORMAT(binary)

SECTIONS
{
    . = 0x100000;

    .text : ALIGN(4096)
    {
        *(.text)
    }

    .rodata : ALIGN(4096)
    {
        *(.rodata)
    }

    .data : ALIGN(4096)
    {
        *(.data)
    }

    .bss : ALIGN(4096)
    {
        *(COMMON)
        *(.bss)
    }
}