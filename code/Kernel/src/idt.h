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
     