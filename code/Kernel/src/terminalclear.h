# define vga_print_address 0xB8000
# define vga_color_scheme 0x04
# define tagline_vga_color_scheme 0x0C
# define vga_write_address 0xB8000
# define vga_width 80
# define vga_height 25
# define vga_color 0x04

// function to clear there terminal screen before printing things to the screen
void terminal_clear() {

    // shifting the vga print address to the vga 
    unsigned short *vga = (unsigned short*)vga_write_address;

    // ascii blank charater stored in the lower 8 bits, and shifting the color value in upper 8 bits
    // bitwise or operator combines the lower and upper bits into a single value
    unsigned short blank = ' ' | (vga_color << 8);

    // loop to change the character of the vga array to blank spaces
    // the height of vga array is always fixed at 80 and width at 25
    for (int i = 0; i < vga_width * vga_height; i++) {
        vga[i] = blank;
    }
}
