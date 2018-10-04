; This simple boot sector will print the string at the label "the_string"

; Set offset address
[org 0x7C00]

; This sets us up to print.
preprint:
    mov ah, 0x0e                ; Put us into TTY mode
    mov al, [the_string]        ; Move the contents of the first character in the_string to al
    mov bx, 0                   ; bx will hold the offset from the address of the_string

print:
    int 0x10                    ; Call interrupt 0x10 to print whatever is in al
    add bx, 1                   ; Increment bx by 1 to move to the next character
    mov al, [the_string + bx]   ; Move the contents of the next chracter into al
    cmp al, 0x00                ; Check if al now contains the null character '0x00'...
    jne print                   ; ...if it does not, jump to the to print to continue for 
                                ; the next character
the_string:
    db "Hello! Welcome to an operating system.",0

; BOOT SECTOR SIZE + MAGIC WORD
times 510-($-$$) db 0
dw 0xaa55 


