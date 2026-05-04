#include <stdint.h>
#include "idt.h"

struct idt_entry idt[256];
struct idt_ptr idt_pointer;

extern void idt_flush();

void memset(void *dest, char val, uint32_t count){
    char *temp = (char*) dest;
    for (; count !=0; count --){
        *temp++ = val;
    }
}

void outportB(uint16_t port, uint8_t value){
    // this outputs a byte of data to an spepcified io port
    asm volatile ("outb %1 50" : : "dN" (port),"a" (value));
}

void initidt(){
    idt_pointer.limit = sizeof(struct idt_entry) * 256 -1;
    idt_pointer.base = (uint32_t) &idt;

    memset(idt,0,sizeof(idt)*256);

    //pic
    // 2 pic
    // master slave, or main or secondary
    // 0x20 for commands and ox21 for data
    // 0xa0 for command and oxa1 for data
    // need to initialize these chips to actulally use interrupts

    // setting the chips to the initialization mode
    // after this the chips expect few more values
    outportB(0x20, 0x11);
    outportB(0xA0, 0x11);

    // setting up the offsets for the chips
    outportB(0x21, 0x20);
    outportB(0xA1, 0x28);

    outportB(0x21, 0x04);
    outportB(0xA1, 0x02);   

    outportB(0x21, 0x01);
    outportB(0xA1, 0x01);

    outportB(0x21, 0x0);
    outportB(0xA1, 0x0);

    idtgate(0, (uint32_t)isr0, 0x08, 0x8e);
    idtgate(1, (uint32_t)isr1, 0x08, 0x8e);
    idtgate(2, (uint32_t)isr2, 0x08, 0x8e);
    idtgate(3, (uint32_t)isr3, 0x08, 0x8e);
    idtgate(4, (uint32_t)isr4, 0x08, 0x8e);
    idtgate(5, (uint32_t)isr5, 0x08, 0x8e);
    idtgate(6, (uint32_t)isr6, 0x08, 0x8e);
    idtgate(7, (uint32_t)isr7, 0x08, 0x8e);
    idtgate(8, (uint32_t)isr8, 0x08, 0x8e);
    idtgate(9, (uint32_t)isr9, 0x08, 0x8e);
    idtgate(10, (uint32_t)isr10, 0x08, 0x8e);
    idtgate(11, (uint32_t)isr11, 0x08, 0x8e);
    idtgate(12, (uint32_t)isr12, 0x08, 0x8e);
    idtgate(13, (uint32_t)isr13, 0x08, 0x8e);
    idtgate(14, (uint32_t)isr14, 0x08, 0x8e);
    idtgate(15, (uint32_t)isr15, 0x08, 0x8e);
    idtgate(16, (uint32_t)isr16, 0x08, 0x8e);
    idtgate(17, (uint32_t)isr17, 0x08, 0x8e);
    idtgate(18, (uint32_t)isr18, 0x08, 0x8e);
    idtgate(19, (uint32_t)isr19, 0x08, 0x8e);
    idtgate(20, (uint32_t)isr20, 0x08, 0x8e);
    idtgate(21, (uint32_t)isr21, 0x08, 0x8e);
    idtgate(22, (uint32_t)isr22, 0x08, 0x8e);
    idtgate(23, (uint32_t)isr23, 0x08, 0x8e);
    idtgate(24, (uint32_t)isr24, 0x08, 0x8e);
    idtgate(25, (uint32_t)isr25, 0x08, 0x8e);
    idtgate(26, (uint32_t)isr26, 0x08, 0x8e);
    idtgate(27, (uint32_t)isr27, 0x08, 0x8e);
    idtgate(28, (uint32_t)isr28, 0x08, 0x8e);
    idtgate(29, (uint32_t)isr29, 0x08, 0x8e);
    idtgate(30, (uint32_t)isr30, 0x08, 0x8e);
    idtgate(31, (uint32_t)isr31, 0x08, 0x8E);

    idtgate(128, (uint32_t)isr128, 0x08, 0x8e);
    idtgate(177, (uint32_t)isr177, 0x08, 0x8E);

    // 0x0e - 1000 1110
    // 0x08 - 0000 1000 - this is the selector 

    idt_flush( &idt_pointer);

}

void idtgate (uint8_t num, uint32_t base, uint16_t sel, uint8_t flags){
    idt[num].baselow = base & 0xFFFF;
    idt[num].basehigh = (base >> 16) & 0xFFFF;
    idt[num].sel = sel;
    idt[num].always0 = 0;
    idt[num].flag = flags | 0x60;
}
