# include <stdint.h>

// read a vlaue from the specidfied port to rv and return it
char inportb(uint16_t port){
    char rv;
    asm volatile("inb %1, %0":"=a"(rv):"dn"(port));
    return rv;
}

void initkeyboard(){
    irq_install_handler();
    
};
void keyboardhandeler(struct interruptregisters *regs){

};
