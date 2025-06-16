// kernel/include/ipc.h
#ifndef _IPC_H
#define _IPC_H

#include <common.h>

typedef struct {
    int sender;
    int receiver;
    int type;
    char data[128];
} msg_t;

int send(int dest, msg_t *msg);
int recv(int src, msg_t *msg);

#endif