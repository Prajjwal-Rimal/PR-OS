#include <stdint.h>

   // GDT IN C
    // describe it like a segment descriptor
    // loaded exactly the way it is defined
    // https://www.youtube.com/watch?v=jwulDRMQ53I


    struct gdt_entry
    {
        uint16_t limit;
        uint16_t baselow;
        uint8_t basemiddle;
        uint8_t access;
        uint8_t flag;
        uint8_t basehigh;
    }__attribute__((packed));
    //attribute packed tells to define the memory the way we have defined it doing so make it that there is no extra padding in the struct
   
    struct gdt_ptr
    {
        uint16_t limit;
        unsigned int base;
    }__attribute__((packed));

    void initgdt();
    
    void gdtgate (uint32_t num, uint32_t base, uint32_t limit, uint8_t access, uint8_t granularity );
    