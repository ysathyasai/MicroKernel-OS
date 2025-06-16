# 🚀 MicroKernel-OS

A lightweight x86 microkernel written in C and Assembly that demonstrates fundamental operating system concepts. This educational project implements core OS features like task scheduling, memory management, and inter-process communication.

## 🎯 What It Is

A **fully-functional microkernel** showcasing:
- 🌀 Preemptive, round-robin task scheduling via PIT interrupts  
- 💬 Inter-Process Communication (IPC) with `send()`/`recv()` APIs  
- 🧱 Physical memory allocator with `kmalloc()`/`kfree()`  
- 🛠 x86 Interrupt handling & modular hardware I/O  
- 🔌 Bootloader loading -> protected mode transition  
- ⚙️ Modular architecture ready to extend with drivers or FS

## 🚀 Getting Started

```bash
# Clone the repository
git clone https://github.com/ArchieTUX/MicroKernel-OS.git
cd MicroKernel-OS

# Install dependencies
chmod +x setup.sh
./setup.sh

# Build and run
./run.sh
```

## 🎯 Features

Our microkernel implements these key operating system concepts:

- 🌀 **Task Scheduling**: Preemptive round-robin scheduling via PIT interrupts
- 💬 **IPC**: Inter-Process Communication with `send()`/`recv()` APIs
- 🧱 **Memory Management**: Physical memory allocation via `kmalloc()`/`kfree()`
- 🛠️ **Interrupt Handling**: x86 interrupt management and hardware I/O
- 🔌 **Protected Mode**: Bootloader transition to 32-bit protected mode
- ⚙️ **Modular Design**: Extensible architecture ready for drivers or filesystem

## 🧩 Project Structure Overview

```
MicroKernel-OS/
├── bootloader/
│   └── boot.asm         # Real-mode BIOS bootloader (loads at 0x7C00)
│
├── kernel/
│   ├── include/         # Public kernel headers
│   │   ├── common.h     # Common macros and typedefs
│   │   ├── task.h      # Task management declarations
│   │   ├── ipc.h       # IPC interface
│   │   ├── mm.h        # Memory management
│   │   └── interrupts.h # Interrupt handling
│   │
│   ├── start.s         # Assembly entry point
│   ├── main.c          # Kernel initialization
│   ├── task.c          # Scheduler implementation
│   ├── ipc.c          # Message-passing primitives
│   └── mm.c           # Physical memory allocator
│
├── lib/                # Helper utilities
│   ├── string.c       # String operations
│   └── util.c         # General utilities
│
├── setup.sh           # Dependency installation script
├── link.ld           # Linker script for 32-bit kernel
├── makefile          # Build configuration
└── run.sh            # Build and run script
```

## 🔧 System Overview

1. **Bootloader**
   - BIOS loads `boot.asm` at 0x7C00
   - Transitions to protected mode
   - Loads and jumps to kernel

2. **Kernel Entry**
   - Sets up stack and registers
   - Initializes core systems
   - Launches initial tasks

3. **Task Scheduler**
   - Preemptive round-robin scheduling
   - PIT timer-based task switching
   - Context save/restore

4. **Memory Management**
   - Physical memory allocation
   - Simple but effective heap management
   - Memory pool allocation strategies

5. **Inter-Process Communication**
   - Message passing between tasks
   - Synchronous send/receive operations
   - Task coordination primitives

## 📋 Prerequisites

All prerequisites can be installed using the setup script:

```bash
./setup.sh
```

This installs:
- gcc-multilib (32-bit support)
- nasm (assembler)
- qemu-system-x86 (emulator)
- make (build system)
- zip (for distribution)

See [INSTALL.md](INSTALL.md) for manual installation instructions.

## 🛠️ Building and Running

1. Clean the build directory:
   ```bash
   make clean
   ```

2. Build the kernel:
   ```bash
   make
   ```

3. Run in QEMU:
   ```bash
   ./run.sh
   ```

## 🧪 What Happens Under the Hood

1. **Bootloader**
   - BIOS loads `boot.asm` at 0x7C00
   - Reads kernel sector
   - Jumps to protected mode

2. **Kernel Entry (`start.s`)**
   - Disables interrupts
   - Sets up stack
   - Switches to 32-bit mode
   - Calls main

3. **Kernel Init (`main.c`)**
   - Initializes memory allocator
   - Initializes IPC
   - Registers initial tasks
   - Enables PIT timer & interrupts

4. **Task Scheduler (`task.c`)**
   - PIT triggers IRQ0
   - Saves current task context
   - Round-robin task selection
   - Restores and resumes next task

5. **IPC (`ipc.c`)**
   - Implements message passing
   - Provides send(pid, msg) / recv() APIs
   - Handles task synchronization

6. **Memory Manager (`mm.c`)**
   - Manages physical memory
   - Implements kmalloc()/kfree()
   - Pool-based memory allocation

## 🎭 Demo Tasks

The kernel demonstrates multitasking with two test tasks:

- **Task A**: Prints "Task A" periodically
- **Task B**: Prints "Task B" periodically

This shows:
- Task creation and management
- Context switching
- Scheduler fairness

## 🧪 Testing

The kernel runs two test tasks to demonstrate multitasking:
- Task A: Prints "Task A" periodically
- Task B: Prints "Task B" periodically

This demonstrates:
- Successful task creation
- Context switching
- Scheduler fairness
- IPC functionality

## 📘 Documentation

- [INSTALL.md](INSTALL.md) - Detailed installation guide
- Code comments explain implementation details
- Header files document public interfaces

## 📈 Roadmap — What’s Next?

Boots successfully
✅
Multitasking support
✅
IPC between tasks
✅
Memory allocation
✅
Modular design
✅
Runs on QEMU
✅
Virtual memory / paging
❌ (Planned/Optional)
User-space processes
❌ (Planned/Optional)
System calls
❌ (Planned/Optional)

## 🤝 Contributing

Contributions are welcome! Areas for improvement:
- Enhanced memory management
- Additional device drivers
- Filesystem support
- Network stack
- User-space process support

## 📝 License

See the [LICENSE](LICENSE) file for details.

## 🌟 Show Some Love

Click the ⭐️ on the repo if this microkernel revs your engine

## ❓ Support

- Check [INSTALL.md](INSTALL.md) for setup troubleshooting
- Open an issue for bugs or questions
- Submit pull requests for improvements

## 📞 Questions?

Drop an issue or say hi. Let’s build the tiniest, meanest OS in history.