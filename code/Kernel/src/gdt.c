#include "gdt.h"
#include <stdint.h>


extern void gdt_flush(uint32_t);
// extern void tss_flush();

struct gdt_entry gdt_entries[5];
struct gdt_ptr gdt_pointer;
// struct tss_entry_struct tss_entry;

void initgdt(){
    gdt_pointer.limit = (sizeof(struct gdt_entry) *6) - 1;
    gdt_pointer.base = (uint32_t)&gdt_entries;

    gdtgate(0,0,0,0,0); //null segment
    gdtgate(1,0,0xffffffff,0x9a,0xcf); //kernel code segment
    gdtgate(2,0,0xffffffff,0x92,0xcf); //kernel data segment
    // f represents the user segment
    gdtgate(3,0,0xffffffff,0xfa,0xcf); //user code segment
    gdtgate(4,0,0xffffffff,0xf2,0xcf); //user data segment
    // writeTSS(5,0x10, 0x0);

    gdt_flush((uint32_t)&gdt_pointer);
    // tss_flush();
}


// void writeTSS(uint32_t num, uint16_t ss0, uint32_t esp0){
//     uint32_t base = (uint32_t) &tss_entry;
//     uint32_t limit = base + sizeof(tss_entry);

//     gdtgate(num, base, limit, 0xE9, 0x00);
//     memset(&tss_entry, 0, sizeof(tss_entry));

//     tss_entry.ss0 = ss0;
//     tss_entry.esp0 = esp0;

//     tss_entry.cs = 0x08 | 0x3;
//     tss_entry.ss = tss_entry.ds = tss_entry.es = tss_entry.fs = tss_entry.gs = 0x10 | 0x3;
// }


void gdtgate (uint32_t num, uint32_t base, uint32_t limit, uint8_t access, uint8_t granularity ){
    gdt_entries[num].baselow = (base & 0xffff);
    gdt_entries[num].basemiddle = (base >> 16) & 0xff;
    gdt_entries[num].basehigh = (base >> 24) & 0xff;

    gdt_entries[num].limit = (limit & 0xffff);
    gdt_entries[num].flag = (limit >> 16) & 0x0f;
    gdt_entries[num].flag |= (granularity & 0xf0);

    gdt_entries[num].access = access;
}