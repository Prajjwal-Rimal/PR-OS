#include <stdint.h>
#include "idt.h"

extern void isr0();
extern void isr33();

struct registers {
    uint32_t ds;
    uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
    uint32_t int_no, err_code;
    uint32_t eip, cs, eflags, useresp, ss; 
};

struct idt_entry idt[256];
struct idt_ptr idtp;

extern void idt_load(); // Assembly function

// Port I/O for PIC communication
static inline void outb(uint16_t port, uint8_t val) {
    asm volatile ( "outb %0, %1" : : "a"(val), "Nd"(port) );
}

void idt_set_gate(uint8_t num, uint32_t base, uint16_t sel, uint8_t flags) {
    idt[num].baselow = (base & 0xFFFF);
    idt[num].basehigh = (base >> 16) & 0xFFFF;
    idt[num].sel = sel;
    idt[num].always0 = 0;
    idt[num].flag = flags;
}

void idt_handler(struct registers r) {
    if (r.int_no == 33) {
        // Keyboard Interrupt
        // Add your keyboard read logic here later
    }
    
    // Send EOI to PIC
    if (r.int_no >= 32) {
        outb(0x20, 0x20);
    }
}

void idt_init() {
    idtp.limit = (sizeof(struct idt_entry) * 256) - 1;
    idtp.base = (uint32_t)&idt;

    for(int i = 0; i < 256; i++) idt_set_gate(i, 0, 0, 0);

    // REMAP THE PIC HERE (Crucial for IRQ1 -> Int 33)
    outb(0x20, 0x11); outb(0xA0, 0x11);
    outb(0x21, 0x20); outb(0xA1, 0x28);
    outb(0x21, 0x04); outb(0xA1, 0x02);
    outb(0x21, 0x01); outb(0xA1, 0x01);
    outb(0x21, 0x0);  outb(0xA1, 0x0);

    idt_set_gate(0, (uint32_t)isr0, 0x08, 0x8E);
    idt_set_gate(33, (uint32_t)isr33, 0x08, 0x8E);
    
    idt_load();
}