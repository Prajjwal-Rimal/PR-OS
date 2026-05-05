#include <stdint.h>
// IDT IN C
// interrupt requests and service routines
// request aree something that will come in through the hardware request from the cpu keyboard, serial port, etc.
// routines that run when an os recieves an interrupt

// like divide by 0 and all

// has a specific structure associated with then
// offset: when an interrupt occurs we go to this offset and start the routine
// present bit: set to 1 to say that the descriptor is valid
// dpl :  a 2 bit value to define the cpu priviledge level
// gate type: describes the interrupt
// segment selector: specifies the code segment in the gdt that will be use for the entry

    struct idt_entry
{
    uint32_t baselow;
    uint16_t sel;
    uint8_t always0;
    uint8_t flag;
    uint16_t basehigh;
}__attribute__((packed));
//attribute packed tells to define the memory the way we have defined it doing so make it that there is no extra padding in the struct
   
struct idt_ptr
{
    uint16_t limit;
    uint32_t base;
}__attribute__((packed));

void initidt();
    
void idtgate (uint8_t number, uint32_t base, uint16_t sel, uint8_t flags);
     
void isr_handler(struct InterruptRegisters* regs);

// reference to all the functions
extern void isr0();
extern void isr1();
extern void isr2();
extern void isr3();
extern void isr4();
extern void isr5();
extern void isr6();
extern void isr7();
extern void isr8();
extern void isr9();
extern void isr10();
extern void isr11();
extern void isr12();
extern void isr13();
extern void isr14();
extern void isr15();
extern void isr16();
extern void isr17();
extern void isr18();
extern void isr19();
extern void isr20();
extern void isr21();
extern void isr22();
extern void isr23();
extern void isr24();
extern void isr25();
extern void isr26();
extern void isr27();
extern void isr28();
extern void isr29();
extern void isr30();
extern void isr31();

// interruupts for system calls
extern void isr128();
extern void isr177();

extern void irq0();
extern void irq1();
extern void irq2();
extern void irq3();
extern void irq4();
extern void irq5();
extern void irq6();
extern void irq7();
extern void irq8();
extern void irq9();
extern void irq10();
extern void irq11();
extern void irq12();
extern void irq13();
extern void irq14();
extern void irq15();