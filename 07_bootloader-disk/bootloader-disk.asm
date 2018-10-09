mov bp, 0x8000  ; Set stack base pointer far away
mov sp, bp      ; Set stack pointer to base pointer because stack is empty

mov bx, 0x9000  ;
mov dh, 2       ; Read 2 sectors
call disk_load

mov dx, [0x9000]
call prehex

mov dx, [0x9000 + 512]
call prehex

jmp $

%include "../05_bootloader-functions-print-hex/print_hex.asm"
%include "../05_bootloader-functions-print-hex/boot_include_file.asm"
%include "bootloader-sect-disk.asm"

times 510 - ($ - $$) db 0
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface

