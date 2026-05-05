# include "vga.h"
# include <stdint.h>

uint16_t column = 0;
uint16_t line = 0;
uint16_t *const vga = (uint16_t *const) 0xb8000;
const uint16_t color = (text_color<<8) | (backgtoundcolor <<12);

void Reset(){
    line = 0;
    column = 0 ;

    for (uint16_t y =0; y < height; y++){
        for (uint16_t x=0; x<width; x++ ){
            vga [y * width + x]= ' '| color;
        }
    }
}

void newline(){
    if (line<height -1){
        line++;
        column =0;
    }else{
        scrollUp();
        column =0;
    }
}

void scrollUp(){
    for (uint16_t y =0; y<height; y++){
        for (uint16_t x =0; x<width;x++){
            vga[(y-1)*width +x] = vga [y*width+x];
        }
    }

    for (uint16_t x=0; x<width; x++){
        vga [(height -1) * width + x] = ' ' | color;
    }
}

void print(const char *s){
    while(*s){
        switch(*s){
            case '\n':
                newline();
                break;
            case '\r':
                column =0;
                break;
            default:
                if (column == width){
                    newline();
                }

                vga[line *width + (column)] = *s | color;
                column++;
                break;
        }
        s++;
    }
}