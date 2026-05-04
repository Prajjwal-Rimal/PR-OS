#include "gdt.h"
#include <stdint.h>


extern void gdt_flush(uint32_t);

struct gdt_entry gdt_entries[5];
struct gdt_ptr gdt_pointer;

void initgdt(){
    gdt_pointer.limit = (sizeof(struct gdt_entry) *5) - 1;
    gdt_pointer.base = (uint32_t)&gdt_entries;

    gdtgate(0,0,0,0,0); //null segment
    gdtgate(1,0,0xffffffff,0x9a,0xcf); //kernel code segment
    gdtgate(2,0,0xffffffff,0x92,0xcf); //kernel data segment
    // f represents the user segment
    gdtgate(3,0,0xffffffff,0xfa,0xcf); //user code segment
    gdtgate(4,0,0xffffffff,0xf2,0xcf); //user data segment

    gdt_flush((uint32_t)&gdt_pointer);
}

void gdtgate (uint32_t num, uint32_t base, uint32_t limit, uint8_t access, uint8_t granularity ){
    gdt_entries[num].baselow = (base & 0xffff);
    gdt_entries[num].basemiddle = (base >> 16) & 0xff;
    gdt_entries[num].basehigh = (base >> 24) & 0xff;

    gdt_entries[num].limit = (limit & 0xffff);
    gdt_entries[num].flag = (limit >> 16) & 0x0f;
    gdt_entries[num].flag |= (granularity & 0xf0);

    gdt_entries[num].access = access;
}