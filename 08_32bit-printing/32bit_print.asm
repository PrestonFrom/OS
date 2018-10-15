; There's nothing to run for lesson 8 since we can't run it from the bootloader
; until we know how to prepare/use the Global Descriptor Table (GDT), which 
; "defines memory segments and their protected-mode attributes".

[bits 32]                       ; Using 32-bit protected mode

; This is how to define a constant:
VIDEO_MEMORY    equ 0xb80000
WHITE_ON_BLACK  equ 0x0f        ; This defines the color byte 

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx]               ; [ebs] is the address of the character to load
    mov ah, WHITE_ON_BLACK      ; Lower by has the character, upper by has the color

    cmp al, 0                   ; Check if we're at the end of the string
    je print_string_pm_done     ; If we're at the end of the string, we're done!

    mov [edx], ax               ; Store character and attribute in video memory
    add ebx, 1                  ; On to the next characer
    add edx, 2                  ; And on to the next position in video memory

print_string_pm_done:
    popa
    ret
