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

//     struct tss_entry_struct{
// 	uint32_t prev_tss;
// 	uint32_t esp0;
// 	uint32_t ss0;
// 	uint32_t esp1;
// 	uint32_t ss1;
// 	uint32_t esp2;
// 	uint32_t ss2;
// 	uint32_t cr3;
// 	uint32_t eip;
// 	uint32_t eflags;
// 	uint32_t eax;
// 	uint32_t ecx;
// 	uint32_t edx;
// 	uint32_t ebx;
// 	uint32_t esp;
// 	uint32_t ebp;
// 	uint32_t esi;
// 	uint32_t edi;
// 	uint32_t es;
// 	uint32_t cs;
// 	uint32_t ss;
// 	uint32_t ds;
// 	uint32_t fs;
// 	uint32_t gs;
// 	uint32_t ldt;
// 	uint32_t trap;
// 	uint32_t iomap_base;
// } __attribute__((packed));


    void initgdt();
    
    void gdtgate (uint32_t num, uint32_t base, uint32_t limit, uint8_t access, uint8_t granularity );
    
    // void writeTSS(uint32_t num, uint16_t ss0, uint32_t esp0);