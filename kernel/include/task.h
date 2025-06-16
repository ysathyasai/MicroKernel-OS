// kernel/include/task.h
#ifndef _TASK_H
#define _TASK_H

#include <common.h>

#define MAX_TASKS 4

typedef struct {
    u32 esp;
    u32 id;
} task_t;

void task_init();
void schedule();
void register_task(void (*task_func)());

#endif