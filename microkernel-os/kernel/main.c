// kernel/main.c
#include <common.h>
#include <task.h>
#include <mm.h>
#include <stdio.h>

void task_a() {
    for (;;) {
        puts("Task A");
    }
}

void task_b() {
    for (;;) {
        puts("Task B");
    }
    hlt;
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