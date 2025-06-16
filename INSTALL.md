# 📥 Installation Guide

This guide will help you set up your environment to build and run the MicroKernel-OS. The process is straightforward with our automated setup script, but manual installation steps are also provided.

## 📋 System Requirements

- Linux-based operating system (Ubuntu/Debian recommended)
- At least 1GB free disk space
- Internet connection for downloading packages
- Root/sudo access for package installation

## 🔧 Dependencies

The following packages are required:

| Package | Purpose |
|---------|---------|
| `gcc-multilib` | 32-bit system compilation support |
| `nasm` | Assembly code compilation |
| `qemu-system-x86` | x86 system emulation |
| `make` | Project build automation |
| `zip` | Project distribution |

## ⚡ Quick Installation

Use our automated setup script (recommended):

```bash
chmod +x setup.sh
```

2. Run the setup script:
```bash
./setup.sh
```

This script will install:
- `gcc-multilib`: For 32-bit compilation support
- `nasm`: The Netwide Assembler for assembly code
- `qemu-system-x86`: For running the kernel in an emulator
- `make`: For build automation
- `zip`: For creating archives

### Manual Installation

If you prefer to install the dependencies manually, you can use these commands:

```bash
sudo apt-get update
sudo apt-get install -y gcc-multilib nasm qemu-system-x86 make zip
```

## 🚀 Building and Running

After installing the dependencies:

1. Navigate to the microkernel directory:
```bash
cd microkernel-os
```

2. Run in QEMU:
   ```bash
   ./run.sh       # Launches kernel in QEMU
   ```

The build process:
1. Compiles bootloader and kernel source files
2. Links object files into kernel image
3. Creates bootable disk image
4. Launches QEMU with the kernel

## ❗ Troubleshooting

### Common Issues

1. **Missing Dependencies**
   ```bash
   # Verify installations
   which gcc nasm qemu-system-i386 make zip
   
   # Reinstall if needed
   sudo apt-get install --reinstall gcc-multilib nasm qemu-system-x86 make zip
   ```

2. **Permission Issues**
   ```bash
   # Make scripts executable
   chmod +x setup.sh
   chmod +x run.sh
   ```

3. **Build Errors**
   ```bash
   # Clean build and try again
   make clean
   make
   ```

4. **QEMU Issues**
   - Ensure hardware virtualization is enabled in BIOS
   - Try running QEMU with different options:
     ```bash
     qemu-system-i386 -kernel build/kernel.bin -nographic
     ```

### Getting Help

If you encounter persistent issues:
1. Check the [GitHub Issues](https://github.com/ArchieTUX/MicroKernel-OS/issues)
2. Create a new issue with:
   - Your system information
   - Complete error message
   - Steps to reproduce
