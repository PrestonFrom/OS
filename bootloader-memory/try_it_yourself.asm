[org 0x7C00]

mov ah, 0x0e
mov al, the_secret
int 0x10
mov al, [the_secret]
int 0x10
mov bx, the_secret
; Uncomment the next line if not using the org directive at the top of the file.
; "org" indicates the global offset, so we don't need to add 0x7c00 to get to the right
; place in memory. (0x7C00 is where the boot sector is loaded into memory. Not the 0 byte, since
; the BIOS has other stuff it needs to load and access as well.)
;add bx, 0x7C00
mov al, [bx]
int 0x10

; This is an infinite loop. It works because $ evaluates to the beginning of the current line
jmp $ 

the_secret:
    db "X"

; BOOT SECTOR SIZE + MAGIC WORD
times 510-($-$$) db 0
dw 0xaa55 


