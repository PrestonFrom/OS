; This simple function prints stuff!
print:
    pusha           ; Save all the registers!

start:
    mov al, [bx]    ; Copy the next character into al
    cmp al, 0x00    ; Check if al now contains a null character
    jne done        ; If al does not contain a null character, loop back to print

    mov ah, 0x0e
    int 0x10        ; Print whatever is in al

    add bx, 1       ; Increment the "pointer" to point to the next character in the string
    jmp start

done:
    popa            ; Restore the registers
    ret             ; Return to where we were called

print_nl:
    pusha

    mov ah, 0x0e
    mov al, 0x0a ; newline char
    int 0x10
    mov al, 0x0d ; carriage return
    int 0x10

    popa
    ret


