; bootloader/boot.asm
BITS 16
org 0x7C00

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Load 1 sector (512B) at 0x1000:0x0000 = 0x10000
    mov ah, 0x02        ; Read sectors
    mov al, 1           ; Number of sectors to read
    mov ch, 0           ; Cylinder
    mov cl, 2           ; Sector number (starts from 1)
    mov dh, 0           ; Head
    mov dl, 0           ; Drive number
    mov bx, 0x1000      ; ES:BX -> 0x1000:0000
    mov es, bx
    xor bx, bx

    int 0x13            ; BIOS Disk Read
    jc .disk_error

    jmp 0x1000:0x0000   ; Jump to loaded kernel

.disk_error:
    mov si, error_msg
    call print_string
    hlt

print_string:
    mov ah, 0x0E
.repeat:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .repeat
.done:
    ret

error_msg db "Disk read error!", 0

times 510 - ($ - $$) db 0
dw 0xAA55