mov ah, 0x0e

; Set the stack "bottom"
mov bp, 0x8000
; And since there's nothing in the stack, set the stack pointer to the same location
mov sp, bp

; Push "A" to the top of the stack -- note that the stack grows down, so this is
; actually stored in 0x7FFE (i.e. 0x8000 - 2).
; This memory can also be accessed directly using 0x7FFE.
push 'A'
; Push "B" to the top of the stack
; Still growing down, so now 0x7FFC (i.e. 0x8000 - 4)
push 'B'
; Push "B" to the top of the stack
; Still growing down, so now 0x7FFA (i.e. 0x8000 - 6)
push 'C'

; Get the characters out of the stack by accessing the directly!
; This prints "ABC"
mov al, [0x7FFE]
int 0x10
mov al, [0x7FFC]
int 0x10
mov al, [0x7FFA]
int 0x10

; And in case you were skeptical, now you can see that there's nothing in at 
; the "base" of the stack...
mov al, [0x8000]
int 0x10

; Next, let's pop everything out of the stack.
; Since the stack is using 16-bits, we pop to bx (which is a 16-bit register) and then
; mov the lower 8 bits of bx (i.e. from bl) to al.
; And then print with interrupt 0x10
pop bx
mov al, bl
int 0x10

; Same as above!
pop bx
mov al, bl
int 0x10

; Same as above!
pop bx
mov al, bl
int 0x10

; Still nothing in the memory pointed to by the stack's base pointer.
mov al, [0x8000]
int 0x10

; If you print from the memory addresses that were previously part of the stack,
; you now get junk!
mov al, [0x7FFE]
int 0x10
mov al, [0x7FFC]
int 0x10
mov al, [0x7FFA]
int 0x10

; Still nothing in the memory pointed to by the stack's base pointer.
mov al, [0x8000]
int 0x10

; But if you push back into the stack, there's stuff there again!
push 'A'
push 'B'
push 'C'

mov al, [0x7FFE]
int 0x10
mov al, [0x7FFC]
int 0x10
mov al, [0x7FFA]
int 0x10

; Infinite loop and boot sector memory magic!
jmp $
times 510-($-$$) db 0
dw 0xaa55
