mov bp, 0x8000                  ; Set stack base pointer far away
mov sp, bp                      ; Set stack pointer to base pointer because stack is empty

mov bx, 0x9000                  ; This tells the bios where to read the sector data to in memory.
                                ; It indirectly sets ES (extra segment register) to 0x9000.
                                ; You can change this and also change the 0x9000 below.

mov dh, 3                       ; Read 3 sectors
call disk_load

mov dx, [0x9000]                ; Print the first two bytes from sector 2
call prehex

mov dx, [0x9000 + 512]          ; Print the first two bytes from sector 3
call prehex

mov dx, [0x9000 + 512 + 512]    ; Print the first two bytes from sector 4
call prehex

jmp $ ; Loop forever

; Include all our print functions
%include "../05_bootloader-functions-print-hex/print_hex.asm"
%include "../05_bootloader-functions-print-hex/boot_include_file.asm"

; Also include the functions to read from sectors
%include "bootloader-sect-disk.asm"

; Make sure our bootsector looks right!
times 510 - ($ - $$) db 0
dw 0xaa55

times 256 dw 0xdada             ; Fill sector 2 with 0xdada
times 256 dw 0xface             ; Fill sector 3 with 0xface
times 256 dw 0x1010             ; Fill sector 3 with 0x1010

