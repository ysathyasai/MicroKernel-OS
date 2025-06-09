// kernel/ipc.c
#include <ipc.h>
#include <stdio.h>
#include "task.h"

msg_t mailbox[MAX_TASKS];

int send(int dest, msg_t *msg) {
    if (dest < 0 || dest >= MAX_TASKS) return -1;
    mailbox[dest] = *msg;
    return 0;
}

int recv(int src, msg_t *msg) {
    if (src < 0 || src >= MAX_TASKS) return -1;
    *msg = mailbox[src];
    return 0;
}