; This file is essentially copied from 
; https://github.com/cfenollosa/os-tutorial/tree/master/10-32bit-enter

[bits 16]
switch_to_pm:
    cli                         ; disable interrupts
    lgdt    [gdt_descriptor]    ; Load the GDT descriptor
    mov     eax, cr0            ; Set 32-bit mode in cr0
    or      eax, 0x1
    mov     cr0, eax            ; Move result back into cr0
    jmp     CODE_SEG:init_pm    ; Execute a far jump by using a different segment

[bits 32]
init_pm:                        ; Hey, we're using 32-bit instructions now!
    mov     ax, DATA_SEG        ; Update all the segment registers
    mov     ds, ax
    mov     ss, ax
    mov     es, ax
    mov     fs, ax
    mov     gs, ax

    mov     ebp, 0x90000         ; update the stack right at the top of the free space
    mov     esp, ebp
    
    call    BEGIN_PM            ; Call a label with useful code!
