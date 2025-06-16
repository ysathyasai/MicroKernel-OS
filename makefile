CC = gcc
AS = nasm
LD = ld
OBJCOPY = objcopy
CFLAGS = -m32 -fno-pie -nostdlib -nodefaultlibs -Wall -Wextra -I./kernel/include -I/usr/include
ASFLAGS = -f elf32
LDFLAGS = -m elf_i386 -T link.ld
OBJDIR = build

# Source files
C_SOURCES = $(wildcard kernel/*.c) $(wildcard lib/*.c)
ASM_SOURCES = kernel/start.s kernel/switch.s kernel/interrupts.s
HEADERS = $(wildcard kernel/include/*.h) $(wildcard lib/*.h)

# Object files
C_OBJECTS = $(C_SOURCES:%.c=$(OBJDIR)/%.o)
ASM_OBJECTS = $(ASM_SOURCES:%.s=$(OBJDIR)/%.o)

KERNEL_ELF = $(OBJDIR)/kernel.elf
KERNEL_BIN = $(OBJDIR)/kernel.bin
BOOTLOADER = $(OBJDIR)/boot.bin

all: $(KERNEL_BIN) $(BOOTLOADER)

$(OBJDIR):
	mkdir -p $(OBJDIR)/kernel
	mkdir -p $(OBJDIR)/lib
	mkdir -p $(OBJDIR)/bootloader

# Compile C files
$(OBJDIR)/%.o: %.c $(HEADERS) | $(OBJDIR)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Assemble assembly files
$(OBJDIR)/%.o: %.s | $(OBJDIR)
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) $< -o $@

# Build bootloader
$(BOOTLOADER): bootloader/boot.asm | $(OBJDIR)
	@mkdir -p $(dir $@)
	$(AS) -f bin $< -o $@

$(KERNEL_ELF): $(C_OBJECTS) $(ASM_OBJECTS)
	$(LD) $(LDFLAGS) $^ -o $@

$(KERNEL_BIN): $(KERNEL_ELF)
	$(OBJCOPY) -O binary $< $@

$(BOOTLOADER): bootloader/boot.asm
	$(AS) -f bin $< -o $@

$(OBJDIR)/os-image.bin: $(BOOTLOADER) $(KERNEL_BIN)
	cat $(BOOTLOADER) $(KERNEL_BIN) > $@

run: $(KERNEL_ELF)
	qemu-system-i386 -kernel $< -display curses -nographic

clean:
	rm -rf $(OBJDIR)/*

.PHONY: all run clean