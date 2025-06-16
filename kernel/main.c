// kernel/main.c
#include <common.h>
#include <task.h>
#include <mm.h>
#include <interrupts.h>

// Internal kernel functions
static void puts(const char* str) {
    // Simple implementation - assumes video memory at 0xB8000
    static int x = 0;
    static int y = 0;
    volatile char *video = (volatile char*)0xB8000;
    
    for (; *str; str++) {
        if (*str == '\n') {
            x = 0;
            y++;
            continue;
        }
        video[2 * (y * 80 + x)] = *str;
        video[2 * (y * 80 + x) + 1] = 0x07; // Light gray on black
        x++;
        if (x >= 80) {
            x = 0;
            y++;
        }
    }
}

void task_a() {
    for (;;) {
        puts("Task A");
        asm volatile("hlt");
    }
}

void task_b() {
    for (;;) {
        puts("Task B");
        asm volatile("hlt");
    }
}

void main() {
    puts("Microkernel OS Booting...");

    kmalloc_init();
    task_init();

    // Create two simple tasks
    register_task(task_a);
    register_task(task_b);

    puts("Starting scheduler...");
    enable_interrupts();
    schedule();
}