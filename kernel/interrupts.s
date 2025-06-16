; kernel/interrupts.s
section .text
    global enable_interrupts

enable_interrupts:
    sti     ; Set interrupt flag (enable interrupts)
    ret
