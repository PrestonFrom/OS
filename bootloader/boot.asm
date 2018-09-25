
mov ah, 0x0e
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10
mov al, ' '
int 0x10

mov ah, 0x0e
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10
mov al, ' '
int 0x10

mov ah, 0x0e
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10
mov al, ' '
int 0x10

mov ah, 0x0e
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10
mov al, ' '
int 0x10

mov ah, 0x0e
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10
mov al, ' '
int 0x10

; This is an infinite loop. It works because $ evaluates to the beginning of the current line
jmp $ 

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; 
; Magic number below indicates to BIOS that this is a boot sector.
; This point confused me at first: We are literally putting 0xaa55 at the end of 510 bytes
; (so it fills out the 511 and 512 byes in the sector). Everything *before* this is still
; part of the same sector -- the BIOS will read the machien code an execute whatever it finds
; as long as we still have 0xaa55 in the last two bytes of the 512-byte vector. That's why we
; the `times 510-($-$$) db 0` line above.
; You could, alternatively, just fill the space by repeating the code to printe 'Hello' over
; and over until we get to to 510 bytes. Fun fact: if you manage to get MORE than 510 bytes,
; the above times line will fail to compile because it becomes a negative!
; All this makes a lot more sense if you look at the actual hex with the command `xxd boot.bin`
dw 0xaa55 


