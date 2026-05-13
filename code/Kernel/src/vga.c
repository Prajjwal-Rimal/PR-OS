# include "vga.h"
# include <stdint.h>

//initial cursor state
uint16_t column = 0;
uint16_t line = 0;
uint16_t *const vga = (uint16_t *const) 0xb8000;
const uint16_t color = (text_color<<8) | (backgtoundcolor <<12);

// funtion to reset the color
void Reset(){
    line = 0;
    column = 0 ;

    for (uint16_t y =0; y < height; y++){
        for (uint16_t x=0; x<width; x++ ){
            vga [y * width + x]= ' '| color;
        }
    }
}

// new line function
void newline() {
    column = 0;
    if (line < height - 1) {
        line++;
    } else {
        scrollUp();
    }
}

// moving the rows up to simulate scrolling
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

// function to pint to the screen and handeling specific behaviiour
void print(const char *s){
    while(*s){
        switch(*s){
            case '\n':
                newline();
                break;
            case '\r':
                newline();
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
