#!/bin/bash

# Check if QEMU is installed
if ! command -v qemu-system-i386 &> /dev/null; then
    echo "Error: qemu-system-i386 is not installed"
    echo "Please install QEMU first. On Ubuntu/Debian, run:"
    echo "sudo apt-get install qemu-system-x86"
    exit 1
fi

# Run using make run target
make run
