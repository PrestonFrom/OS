; ; This file is essentially copied from 
; ; https://github.com/cfenollosa/os-tutorial/tree/master/10-32bit-enter
; 
; [org 0x7c00]                    ; bootloader offset
;     mov     bp, 0x9000          ; Set stack
;     mov     sp, bp
; 
;     mov     bx, MSG_REAL_MODE   ; Print the real mode message
;     call    print
; 
;     call    switch_to_pm        ; This is in boot_print_func.asm
;     jmp     $                   ; Should never actually get here...
; 
; %include "../05_bootloader-functions-strings/print.asm"
; %include "../09_32bit-gdt/32bit-gdt.asm"
; %include "../08_32bit-printing/32bit_print.asm"
; %include "32bit-switch.asm"
; 
; [bits 32]
; BEGIN_PM:
;     mov     ebx, MSG_PROT_MODE  ; Print 32 bit mode message
;     call    print_string_pm
;     jmp     $                   ; Loop here forever
; 
; MSG_REAL_MODE db "Started in 16-bit real mode", 0
; MSG_PROT_MODE db "Loaded 32-bit protected mode", 0
; 
; ; bootsector
; times 510-($-$$) db 0
; dw 0xaa55


[org 0x7c00] ; bootloader offset
    mov bp, 0x9000 ; set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print ; This will be written after the BIOS messages

    call switch_to_pm
    jmp $ ; this will actually never be executed

%include "../05_bootloader-functions-strings/print.asm"
%include "../09_32bit-gdt/32bit-gdt.asm"
%include "../08_32bit-printing/32bit_print.asm"
%include "32bit-switch.asm"

[bits 32]
BEGIN_PM: ; after the switch we will get here
    mov ebx, MSG_PROT_MODE
    call print_string_pm ; Note that this will be written at the top left corner
    jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

; bootsector
times 510-($-$$) db 0
dw 0xaa55
