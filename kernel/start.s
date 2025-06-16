; Declare constants for the multiboot header
MBALIGN  equ  1<<0              ; align loaded modules on page boundaries
MEMINFO  equ  1<<1              ; provide memory map
FLAGS    equ  MBALIGN | MEMINFO ; this is the Multiboot 'flag' field
MAGIC    equ  0x1BADB002        ; 'magic number' lets bootloader find the header
CHECKSUM equ -(MAGIC + FLAGS)    ; checksum of above, to prove we are multiboot

; Declare a multiboot header that marks the program as a kernel
section .multiboot
align 4
    dd MAGIC
    dd FLAGS
    dd CHECKSUM

; Allocate the initial stack
section .bootstrap_stack, nobits
stack_bottom:
    resb 16384  ; 16 KiB
stack_top:

; Kernel entry point
section .text
global _start:function (_start.end - _start)
extern main

_start:
    ; Initialize stack
    mov esp, stack_top

    ; Reset EFLAGS
    push 0
    popf

    ; Call kernel main function
    push ebx    ; Multiboot info structure
    call main
    
    ; Halt the CPU
    cli
.hang:
    hlt
    jmp .hang
.end: