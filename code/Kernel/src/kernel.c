# include "gdt.h"
# include "idt.h"
# include "terminalclear.h"
# include "vga.h"
# include <stdint.h>
# include "driver.h"

# define vga_color_scheme 0x04
# define tagline_vga_color_scheme 0x0C
# define vga_print_address 0xB8000


// extern void switch_to_userspace();
extern uint16_t line;   
extern uint16_t column;

// int kstrcmp(const char *a, const char *b) {
//     int i = 0;
//     while (a[i] && b[i]) {
//         if (a[i] != b[i]) return 0;
//         i++;
//     }
//     return a[i] == b[i];
// }

// main kernel fuunction
void kernel_main() {
    terminal_clear();
    initgdt();
    initidt();
    initkeyboard();

    // defining a character of array for logo and ending it with a null terminator
    const char *logo[]={
        "PPPPPP  RRRRRR          OOOOO   SSSSS   ",
        "PP   PP RR   RR        OO   OO SS       ",
        "PPPPPP  RRRRRR  -----  OO   OO  SSSSS   ",
        "PP      RR  RR         OO   OO      SS  ",
        "PP      RR   RR         OOOOO   SSSSS   ",
        0
    };

    // defining the tagline of the project
    const char *tagline= "A Minimal OS Based on Existing Kernel Analysis";

    // defining the intro of the project    
    const char *introduction= "created by: PRAJJWAL RIMAL";

    // shifting the vga print address to the vga 
    unsigned short *vga = (unsigned short*)vga_print_address;


    // defining the row and column for the logo print
    int start_row = 5;
    int start_col = 10;

    // printing the logo
    for (int i = 0; logo[i] != 0; i++) {
        for (int j = 0; logo[i][j] != '\0'; j++) {
            // converting the 2d index to the 1d index
            int index = (start_row + i) * 80 + (start_col + j);
            vga[index] = logo[i][j] | (vga_color_scheme << 8);
        }
    }


    // defining the row and column for the tagline print
    int start_row_tagline = 7;
    int start_col_tagline = 6;

    // printing tagline
    int tagline_row = start_row_tagline + 5;
    for (int i = 0; tagline[i] != '\0'; i++) {
        int index = tagline_row * 80 + (start_col_tagline + i);
        vga[index] = tagline[i] | (tagline_vga_color_scheme << 8);
    }


    // defining the row and column for the introduction print
    int start_row_introduction = 9;
    int start_col_introduction = 15;

    // printing the introduction
    int introduction_row = start_row_introduction + 5;
    for (int i = 0; introduction[i] != '\0'; i++) {
        int index = introduction_row * 80 + (start_col_introduction + i);
        vga[index] = introduction[i] | (tagline_vga_color_scheme << 8);
    }

    for(volatile int i = 0; i < 900000000; i++) {
        __asm__("nop");
    }


    terminal_clear();
    print("\n \nPROS> ");
    
    // switch_to_userspace();
    
} 