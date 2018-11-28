#include "../drivers/ports.h"

void main() {
    /**
     * First, we'll get the cursor position.
     * We start by asking the VGA control register (0x3d4) for:
     *  1) the high byte of the cursor (14)
     *  2) the low byte of the cursor (15)
     */
    port_byte_out(0x3d4, 14); // Please give me the high byte of cursor position

    // The result is returned in the VGA data register (0x3d5)
    int position = port_byte_in(0x3d5); // The result is stored in position, but...
    position = position << 8; // ...we just get a single byte. Since it's the high byte,
                              // we have to move it into the correct position (i.e. move it
                              // over by the width of one byte (8 bits).

    port_byte_out(0x3d4, 15); // Please give me the low byte of the cursor position.
    position += port_byte_in(0x3d5); // Since this is the low byte, we can just add it to
                                     // position and it now contaings two bytes in the
                                     // correct order!

    /**
     * Position needs to be doubled because each "cell" is two bytes long -- 
     * the character and the control data for that character.
     */
    int offset_from_vga = position * 2;

    // Now, we can print a white X on a black background where the cursor is!
    char* vga = 0xb8000;
    vga[offset_from_vga] = 'X';
    vga[offset_from_vga + 1] = 0x0f;

    // Or in the next position...
    vga[offset_from_vga + 2] = 'X';
    vga[offset_from_vga + 3] = 0x0f;

    // Or in the previous position...
    vga[offset_from_vga - 2] = 'X';
    vga[offset_from_vga - 1] = 0x0f;
}
