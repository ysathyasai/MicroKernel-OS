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
│   └── boot.asm          ← Real-mode BIOS bootloader (0x7C00)
├── kernel/
│   ├── include/          ← All public kernel headers
│   │   ├── common.h
│   │   ├── task.h
│   │   ├── ipc.h
│   │   ├── mm.h
│   │   └── interrupts.h
│   ├── start.S           ← Assembly entry point + CPU setup
│   ├── main.c            ← Kernel init + test harness
│   ├── task.c            ← Scheduler implementation (PIT interrupt)
│   ├── ipc.c             ← Message-passing primitives
│   └── mm.c              ← Physical memory pool allocator
├── lib/                  ← Helper modules
│   ├── string.c
│   └── util.c            (inb/outb, etc.)
├── Makefile              ← Build + run targets
├── link.ld               ← 32-bit flat binary linker script
├── run.sh                ← Shell convenience script to launch QEMU
└── README.md

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

| Feature                    |   Status  |
| -------------------------- | :-------: |
| Paging / Virtual Memory    | ❌ Planned |
| User‑Space Drivers & Shell | ❌ Planned |
| System Call API            | ❌ Planned |
| Virtual FS                 | ❌ Planned |
| Real Hardware Support      | ❌ Planned |
| SMP (Multi-Core Support)   | ❌ Planned |
| ELF Binary Loader          | ❌ Planned |

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
