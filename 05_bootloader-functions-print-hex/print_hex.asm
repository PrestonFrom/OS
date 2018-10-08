[org 0x7c00]

prehex:
    pusha                   ; Save all the registers!
    mov ah, 0x0e            ; Put us in TTY mode
    mov cx, 0               ; cx is loop counter
    
hex_loop:
    cmp cx, 4               ; loop 4 times
    je  done
    
    mov ax, dx              ; dx holds the value to hexify, ax is where do work
    and ax, 0x000f          ; get the last 16 bits
    add al, 0x30            ; Convert to number
    cmp al, 0x39            ; If the conversion is actually a number...
    jle add_to_string       ; ...add it to the string
    add al, 7               ; Otherwise, we need to add 7 to bump it up to A-F

add_to_string:
    mov bx, HEX_OUT + 5     ; Get the address of last byte in HEX_OUT into bx
    sub bx, cx              ; Move to the left from the end by the number in the counter
    mov [bx], al            ; Set the value pointed at by bx to whatever is in al
    ror dx, 4               ; Rotate dx to the right four places to get the next item

    add cx, 1               ; Increment the loop counter
    jmp hex_loop            ; Go back to the beginning of the loop

done:
    mov bx, HEX_OUT         ; Move the address of HEX_OUT to bx
    call preprint           ; Now print the string in HEX_OUT


    popa                    ; Restore the registers
    ret                     ; Return to where we were called

HEX_OUT:
    db '0x0000', 0



