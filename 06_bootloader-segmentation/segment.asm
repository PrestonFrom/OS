mov ah, 0x0e ; enter tty mode

mov al, [the_secret]
int 0x10                        ; This won't work because the address of the_secret is based 
                                ; on the wrong offset (since no offset is set, it's currently 
                                ; 0, but we need it to be 0x7c00

mov al, [0x7c00 + the_secret]   ; This would work though, because we got the offset right.
int 0x10

mov bx, 0x7c0                   ; We use 0x7c0 instead of 0x7c0 because it automatically
                                ; shifts 4 bits to the left for us. 
                                ; OS Dev PDF explains why!
                                ; To calculate the absolute address the CPU multiplies the 
                                ; value in the segment register by 16 and then adds your 
                                ; offset address; and because we are working with hexadecimal,
                                ; when we multiple a number by 16, we simply shift it a digit 
                                ; to the left (e.g. 0x42 * 16 = 0x420). So if we set ds to 
                                ; 0x4d and then issue the statement mov ax, [0x20], the
                                ; value stored in ax will actually be loaded from address 
                                ; 0x4d0 (16 * 0x4d + 0x20).

mov ds, bx                      ; We can't set ds directly, so we use another general-purpose 
                                ; register. All memory references now use offset in ds.

mov al, [the_secret]            ; Now we can easily access the secret!
int 0x10


mov al, [es:the_secret]         ; This will not work yet because es is still 0x0000
int 0x10                    

; But if we set es to 0x7c00 (we only move in 0x7c0 though), it will work!
mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10

jmp $

the_secret:
    db "X"

times 510 - ($ - $$) db 0
dw 0xaa55
