; This file is essentially copied from 
; https://github.com/cfenollosa/os-tutorial/tree/master/10-32bit-enter

[org 0x7c00]                    ; bootloader offset
    mov     bp, 0x9000          ; Set stack
    mov     sp, bp

    mov     bx, MSG_REAL_MODE   ; Print the real mode message
    call    print

    call    switch_to_pm        ; This is in boot_print_func.asm
    jmp     $                   ; Should never actually get here...

%include "print.asm"
%include "32bit-gdt.asm"
%include "32bit_print.asm"
%include "32bit-switch.asm"

[bits 32]
BEGIN_PM:
    mov     ebx, MSG_PROT_MODE  ; Print 32 bit mode message
    call    print_string_pm
    jmp     $                   ; Loop here forever

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

; bootsector
times 510-($-$$) db 0
dw 0xaa55
