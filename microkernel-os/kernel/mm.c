// kernel/mm.c
#include <mm.h>
#include <string.h>

#define POOL_SIZE (1024 * 1024) // 1MB
static char mem_pool[POOL_SIZE];
static int pool_index = 0;

void kmalloc_init() {
    pool_index = 0;
}

void* kmalloc(size_t size) {
    if ((pool_index + size) > POOL_SIZE) return NULL;
    void *ptr = &mem_pool[pool_index];
    pool_index += size;
    return ptr;
}

void kfree(void *ptr) {
    // For simplicity, we don't free here
}