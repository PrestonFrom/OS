; Here comes the GDT!
gdt_start:

gdt_null:           ; The GDT must start with a null descriptor
    dd 0x0          ; dd is used to define a double word, which is 4 bytes
    dd 0x0

gdt_code:       ; This is the code segment descriptor
    ; base = 0x0, limit = 0xfffff
    ; First flags:  present (1) privilege (00) descriptor type (1) -> 1001b (b is for binary)
    ; Type flags:   code (1) conforming (0) readable (1) accessed (0) -> 1010b
    ; Second flags: granularity (1) 32-bit default (1) 64-bit segments (0) AVL (0) -> 1100b
    dw 0xffff       ; limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    dw 0x0          ; Base (bits 16-23)
    db 10011010b    ; first flags and type flags
    db 11001111b    ; second flags and limit (bits 16-19)
    db 0x0          ; Base (bits 24-31)

gdt_data:       ; This is the data segment descriptor
    ; Same as the code segment descriptor except for type flags
    ; Type flags:   code (0) expand down (0) writable (1) accessed (0) -> 0010b
    dw 0xffff       ; limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    dw 0x0          ; Base (bits 16-23)
    db 10010010b    ; first flags and type flags
    db 11001111b    ; second flags and limit (bits 16-19)
    db 0x0          ; Base (bits 24-31)

gdt_end:        ; This label makes it easy to calculate the size 
                ; of the GDT for the GDT descriptor

gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; The size of the GDT is always 1 less than true size
    dd gdt_start                ; Start address of the GDT

; This comment is copy-and-pasted from the PDF
; Define some handy constants for the GDT segment descriptor offsets , which
; are what segment registers must contain when in protected mode. For example ,
; when we set DS = 0 x10 in PM , the CPU knows that we mean it to use the
; segment described at offset 0 x10 ( i.e. 16 bytes ) in our GDT , which in our
; case is the DATA segment (0 x0 -> NULL ; 0x08 -> CODE ; 0 x10 -> DATA )
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
    
