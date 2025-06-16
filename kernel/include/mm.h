// kernel/include/mm.h
#ifndef _MM_H
#define _MM_H

#include <stddef.h>
#include <common.h>

void kmalloc_init();
void* kmalloc(size_t size);
void kfree(void *ptr);

#endif