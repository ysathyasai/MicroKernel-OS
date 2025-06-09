// kernel/task.c
#include <task.h>
#include <mm.h>
#include <interrupts.h>
#include <stdio.h>

static task_t tasks[MAX_TASKS];
static int current_task = -1;

extern void task_switch(u32 *old_esp, u32 new_esp);

void task_init() {
    for (int i = 0; i < MAX_TASKS; i++) {
        tasks[i].id = i;
        tasks[i].esp = (u32)kmalloc(4096) + 4096; // Allocate stack
    }
    current_task = 0;
}

void schedule() {
    if (current_task == -1) return;
    int next = (current_task + 1) % MAX_TASKS;
    u32 old_esp = tasks[current_task].esp;
    tasks[current_task].esp = get_current_esp(); // Assume implemented
    current_task = next;
    task_switch(&old_esp, tasks[next].esp);
}