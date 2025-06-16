// kernel/include/interrupts.h
#ifndef _INTERRUPTS_H
#define _INTERRUPTS_H

#include <common.h>

// Enable hardware interrupts
void enable_interrupts();

typedef struct {
    u32 ds;
    u32 edi, esi, ebp, esp, ebx, edx, ecx, eax;
    u32 int_no, err_code;
    u32 eip, cs, eflags, useresp, ss;
} registers_t;

void isr_install();
void irq_install();
void fault_handler(registers_t *r);

#endif