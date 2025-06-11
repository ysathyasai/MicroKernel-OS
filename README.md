```markdown
# 🚀 MicroKernel‑OS

### A razor‑thin x86 microkernel prototype in C + Assembly that boots, multicasts tasks, and handles low-level hardware — all in under 1M lines by an 18-year-old badass.

---

## 🎯 What It Is

A **fully-functional microkernel** showcasing:
- 🌀 Preemptive, round-robin task scheduling via PIT interrupts  
- 💬 Inter-Process Communication (IPC) with `send()`/`recv()` APIs  
- 🧱 Physical memory allocator with `kmalloc()`/`kfree()`  
- 🛠 x86 Interrupt handling & modular hardware I/O  
- 🔌 Bootloader loading -> protected mode transition  
- ⚙️ Modular architecture ready to extend with drivers or FS  

Runs perfectly in **QEMU** via `Makefile` or `run.sh` — extendable to real hardware.

---

## 🧩 Project Structure Overview

```

MicroKernel-OS/
├── bootloader/
│   └── boot.asm         # Real-mode BIOS bootloader (loads at 0x7C00)
│
├── kernel/
│   ├── include/          # Public kernel headers
│   │   ├── common.h      # Common macros, typedefs, and includes
│   │   ├── task.h        # Task management and scheduling declarations
│   │   ├── ipc.h         # Inter-process communication (IPC) interface
│   │   ├── mm.h          # Memory management declarations
│   │   └── interrupts.h  # Interrupt handling declarations
│   │
│   ├── start.S           # Assembly entry point; sets up CPU in protected mode
│   ├── main.c            # Kernel initialization + test harness
│   ├── task.c            # Scheduler implementation (uses PIT interrupt)
│   ├── ipc.c             # Message-passing primitives for inter-task communication
│   └── mm.c              # Physical memory pool allocator
│
├── lib/                  # Helper/utility modules
│   ├── string.c          # String manipulation functions (strcpy, strlen, etc.)
│   └── util.c            # Utility functions: inb(), outb(), io_wait(), etc.
│
├── Makefile              # Build system: compiles, links, and creates image
├── link.ld               # Linker script for 32-bit flat binary
├── run.sh                # Convenience script to launch OS in QEMU
└── README.md             # Project overview and usage instructions

````

---

## ⚙️ Build & Launch — Step by Step

**1️⃣ Prerequisites**

Ensure you have:
```bash
sudo apt install build-essential nasm qemu-system-x86 gcc-multilib make
````

**2️⃣ Clone the Repo**

```bash
git clone https://github.com/ArchieTUX/MicroKernel-OS.git
cd MicroKernel-OS
```

**3️⃣ Build Everything**

```bash
make
```

**4️⃣ Run It**

```bash
make run
# or:
./run.sh
```

Watch QEMU boot, register interrupts, spawn tasks, and execute!

**5️⃣ Clean Build**

```bash
make clean
```

---

## 🧪 What Happens Under the Hood

1. **Bootloader**

   * BIOS → loads `boot.asm` @0x7C00 → reads kernel sector → jumps to protected mode

2. **Kernel Entry (`start.S`)**

   * Disables interrupts, sets up stack, switches to 32-bit, calls `main`

3. **Kernel Init (`main.c`)**

   * Init memory allocator
   * Init IPC
   * Register tasks A & B
   * Enable PIT timer & interrupts

4. **Task Scheduler (`task.c`)**

   * PIT triggers IRQ0
   * Save current task context
   * Round-robin next task
   * Restore and resume

5. **IPC (`ipc.c`)**

   * Tasks can `send(pid, msg)` / `recv()` synchronously

6. **Memory Manager (`mm.c`)**

   * Pool-based allocator: `kmalloc()`/`kfree()` for kernel heap

---

## 🎭 Demo: Task A / Task B

Your kernel runs two test tasks:

* **Task A**: prints `"Task A"` every tick
* **Task B**: prints `"Task B"` on alternate ticks

⚙️ This proves:

* Task creation
* Context-switching
* Scheduler fairness

---

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

---

## 🙌 Want to Contribute?

1. **Fork** the repo
2. `git checkout -b feature/my-awesome-ext`
3. `git commit -am "Add new scheduler strategy"`
4. `git push origin feature/my-awesome-ext`
5. **Open a pull request**

We hunger for better task management, IPC robustness, memory pooling, and nifty drivers.

---

## 🧾 License

MIT — Hack it, break it, remake it. Just keep the credits.

---

## 🌟 Show Some Love

Click the ⭐️ on the repo if this microkernel revs your engine!

---

## 📞 Questions?

Drop an issue or say hi. Let’s build the tiniest, meanest OS in history.
