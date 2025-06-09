// kernel/start.S
.extern main
.global _start

_start:
    cli
    mov esp, stack_top
    push eax
    push ebx
    call main
    hlt

.section .bss
stack_bottom:
    .space 16384
stack_top: