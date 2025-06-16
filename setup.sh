#!/bin/bash

echo "Installing dependencies for MicroKernel-OS..."

# Update package lists
sudo apt-get update

# Install required packages
echo "Installing build tools and dependencies..."
sudo apt-get install -y \
    gcc-multilib \
    nasm \
    qemu-system-x86 \
    make \
    zip

echo "All dependencies have been installed successfully!"
echo "You can now build and run the microkernel using:"
echo "cd microkernel-os"
echo "./run.sh"
