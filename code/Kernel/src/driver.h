//https://wiki.osdev.org/PS/2_Keyboard
// https://www.youtube.com/watch?v=b2_W0wIed_A&list=PL2EF13wm-hWAglI8rRbdsCPq_wRpYvQQy&index=9

# include "vga.h"
#include "idt.h"

// defining th port where the instuction is gonna be read from
char inportb(uint16_t port);
// defining the void hand the handler
void initkeyboard();
void keyboardhandeler(struct InterruptRegisters *regs);
