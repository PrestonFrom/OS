disk_load:
    pusha                   ; Save all general purpose registers
    push dx                 ; Save dx since it contains our input value

    mov ah, 0x02            ; 0x02 is needed to call the BIOS read sector function
    mov al, dh              ; This tells the BIOS how many sectors to read
    mov cl, 0x02            ; cl tells the BIOS which sector to start the read at. 
                            ; (1 is the boot sector so we start at the second sector.)
    mov ch, 0x00            ; ch contains the cylinder to read
    mov dh, 0x00            ; dh contains the head number

    int 0x13                ; BIOS interrupt
    jc disk_error           ; Jump to disk_error if there is an error
                            ; (An error is indicated by setting the cary flag)

    pop dx                  ; Restore dx
    cmp al, dh              ; Check how many sectors were actually read (al) to the
                            ; the expected number to read (dh)
    jne sectors_error       ; If they're not the same, print an error

    popa                    ; Otherwise, restore regisers and return
    ret

disk_error:
    mov bx, DISK_ERROR      ; Set bx to point at the DISK_ERROR string
    call preprint           ; And print it.
    mov dh, ah              ; ah contains the error code and dl contains the disk drive
                            ; that had the error, so dx = dh (error) and dl (which drive)
    call prehex             ; Print as hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR   ; Just print it!
    call preprint

disk_loop:
    jmp $                   ; Nothing else we can do

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0
