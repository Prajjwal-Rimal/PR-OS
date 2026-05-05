# include "gdt.h"
# include "idt.h"
# include "terminalclear.h"
# include <stdint.h>

# define vga_color_scheme 0x04
# define tagline_vga_color_scheme 0x0C
# define vga_print_address 0xB8000

// https://www.wasilzafar.com/pages/series/kernel-development/kernel-dev-phase-04-display-input.html
// vga mode 1987 
// has 80 columns and 25 rows 
// 16 foreground and background vga_colors
// 256 characters
// memory mapped i/o at 0xB8000 any write to this address instantly appear on the screen
// each character on the screen is two bytes: one byte is for the vga_color and the other one is for the character
// address range for the vga mode is Address Range: 0xB8000 - 0xB8F9F (80×25×2 = 4000 bytes)

// vga vga_color scheme:  
//  0 = Black           8 = Dark Gray (bright black)
//  1 = Blue            9 = Light Blue
//  2 = Green          10 = Light Green
//  3 = Cyan           11 = Light Cyan
//  4 = Red            12 = Light Red
//  5 = Magenta        13 = Light Magenta
//  6 = Brown          14 = Yellow (bright brown)
//  7 = Light Gray     15 = White (bright light gray)

// control characters:
// '\n' (LF)     0x0A    Move to start of next line (newline)
// '\r' (CR)     0x0D    Move to start of current line
// '\t' (TAB)    0x09    Move to next 8-column boundary
// '\b' (BS)     0x08    Move cursor back, erase character
// '\f' (FF)     0x0C    Clear screen (form feed)
// Printable    0x20-7E  Display character at cursor position


// main kernel fuunction
void kernel_main() {

    initgdt();

    initidt();

    // clearing the terminal before printing to the screen
    terminal_clear();

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

    // INTERRUPT HANDELLING IN RUST
    // DRIVER IN RUST
    // FOUNDATION OF MEMORY MANAGEMENT IN RUST
    // SYSCALL IN RUST
    
    // ECHO AND HELP COMMAND IN RUST IN THE USERSPACE
    // BASIC TEXT EDITOR IN THE USERSPACE IN RUST
    // NUMBER GUESSING GAME IN THE USERSPACE IN RUST
} 