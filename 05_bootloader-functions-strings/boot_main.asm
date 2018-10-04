; This simple bootsector prints stuff!

[org 0x7c00]

jmp start           ; We need to jump over the print label so we don't automatically 
                    ; run the "function"

%include "boot_include_file.asm"    ; This includes the contents of "boot_include_file.asm"
                                    ; directly in this file, replacing this line.
                                    ; Since it's literally just adding in the assembly in the
                                    ; other file, we still need the 'jmp start' line above!

start:
    mov bp, 0x8000  ; Set the stack's base pointer
    mov sp, bp      ; And set the stack pointer to the same location

    mov bx, the_string      ; Store the address of the_string in bx to be accessed by preprint
    call preprint           ; Call the print function!
    mov bx, another_string  ; Repeat for another_string
    call preprint           ; Call it again


the_string:
    db "This is a string to print. ",0

another_string:
    db "Here's another one!",0


jmp $ ; infinite loop

; zero padding and magic bios number
times 510-($-$$) db 0
dw 0xaa55
