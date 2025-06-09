CC = gcc
AS = nasm
LD = ld
OBJCOPY = objcopy
CFLAGS = -m32 -fno-pie -nostdinc -nostdlib -nodefaultlibs -Wall -Wextra -I./kernel/include
LDFLAGS = -m elf_i386 -T link.ld
OBJDIR = build

KERNEL_ELF = $(OBJDIR)/kernel.elf
KERNEL_BIN = $(OBJDIR)/kernel.bin
BOOTLOADER = $(OBJDIR)/boot.bin

all: $(KERNEL_BIN)

$(OBJDIR):
    mkdir -p $@

$(OBJDIR)/%.o: kernel/%.c | $(OBJDIR)
    $(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/%.o: kernel/%.S | $(OBJDIR)
    $(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/%.o: lib/%.c | $(OBJDIR)
    $(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/start.o: kernel/start.S
    $(CC) $(CFLAGS) -c $< -o $@

$(KERNEL_ELF): $(OBJDIR)/start.o $(OBJDIR)/main.o $(OBJDIR)/task.o $(OBJDIR)/mm.o $(OBJDIR)/ipc.o $(OBJDIR)/util.o
    $(LD) $(LDFLAGS) $^ -o $@

$(KERNEL_BIN): $(KERNEL_ELF)
    $(OBJCOPY) -O binary $< $@

$(BOOTLOADER): bootloader/boot.asm
    $(AS) -f bin $< -o $@

run: all
    cat $(BOOTLOADER) $(KERNEL_BIN) > $(OBJDIR)/os-image.bin
    qemu-system-i386 -kernel $(OBJDIR)/os-image.bin

clean:
    rm -rf $(OBJDIR)/*

.PHONY: all run clean