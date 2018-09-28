[org 0x7c00]

preprint:
    pusha           ; Save all the registers!
    mov ah, 0x0e    ; Put us in TTY mode
    mov al, [bx]    ; Copy the first character to al register for printing

print:
    int 0x10        ; Print whatever is in al
    add bx, 1       ; Increment the "pointer" to point to the next character in the string
    mov al, [bx]    ; Copy the next character into al
    cmp al, 0x00    ; Check if al now contains a null character
    jne print       ; If al does not contain a null character, loop back to print
    popa            ; Restore the registers
    ret             ; Return to where we were called


