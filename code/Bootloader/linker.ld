/*telling the linker script to look for the   _start lable in the specified file*/
ENTRY(_start)

/*output of the file*/
OUTPUT_FORMAT(binary)

SECTIONS
{
    /*kernel load address*/
    . = 0x100000;

    /*code section*/
    .text : ALIGN(4096)
    {
        *(.text)
    }

    /*read only data section*/
    .rodata : ALIGN(4096)
    {
        *(.rodata)
    }

    /*variables with values/initialized data*/
    .data : ALIGN(4096)
    {
        *(.data)
    }

    /* section to store unitialized data*/
    .bss : ALIGN(4096)
    {
        *(COMMON)
        *(.bss)
    }
}

/*things are in 4096 blocks or 4kb as paging supports 4kb blocks and future memory management depends on the blocks being 4kb*/