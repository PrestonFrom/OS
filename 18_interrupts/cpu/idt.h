#ifndef IDT_H
#define IDT_h

#include "types.h"

/* Segment selectors */
#define KERNEL_CS 0x08

// This is how interrupt gates (handlers) are defined
typedef struct {
    u16 low_offset; // Lower 16 bits of handler function address
    u16 sel;        // Kernel segment selector
    /************
     * First byte:
     * Bit 7: "Interrupt present"
     * Bit 6-5: Privilege level of caller (0=kernel..3=user)
     * Bit 4: Set to 0 for interrupt gates
     * Bit 3-0: Bits 1110 = decimal 14, which means '32 bit interrupt gate'
     ************/
    u8  always0;
    u8  flags;
    u16 high_offset;
}

typedef struct{
    u16 limit;
    u32 base;
} __attribute__((packed)) idt_register_t;

// CPU requires 256 entries, even if some are null.
#define IDT_ENTRIES 256
idt_gate_t idt[ITD_ENTRIES];
idt_register_t idt_reg;

void set_idt_gate(int n, u32 handler);
void set_idt();

#endif
