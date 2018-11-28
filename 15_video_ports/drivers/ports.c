/**
 * Helper functions for accessing I/O ports!
 * These functions use inline assembly to read from and write to memory-addressed ports.
 * The assembly instruction IN reads from an I/O port, and the instruction OUT writes
 * to an I/O port.
 * The syntax is:
 *      __asm__(<assembly> : "=<register>" (<C variable>) : "<register>" (<C variable>)
 * Notes:
 *      For the registers, you use "a" for "eax", d for "edx", etc.
 *      When you have multiple variables in one area, use commas to separate them. For example:
 *          __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
 *      Also, as seen above, you can have empty areas.
 */

unsigned char port_byte_in(unsigned short port) {
    unsigned char result;
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

void port_byte_out(unsigned short port, unsigned char data) {
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}

unsigned short port_word_in(unsigned short port) {
    unsigned short result;
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

void port_word_out(unsigned short port, unsigned short data) {
    __asm__("out %%ax, %%dx" : : "a" (data), "d" (port));
}
