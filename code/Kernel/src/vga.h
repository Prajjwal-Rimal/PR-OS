
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

#pragma once
#include <stdint.h>

# define backgtoundcolor 0
# define text_color 0x04
# define width 80
# define height 25

void print(const char *s);
void scrollUp();
void newline();
void reset();