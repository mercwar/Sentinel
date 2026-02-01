#!/bin/bash
#BGIN
/* AVIS_COORD_DIR: VERSION/v1.04 */
/* AVIS_COORD_FILE: asm_install.sh */
/* AVIS_ROLE: Metal_Layer_Activator_v1.04.21 */

# 1. COMPILE: Transforming Source to Binary
# Assembling bgin_mem_scan.asm for the Handshake Monitor
nasm -f elf64 -o bgin_mem_scan.o SOURCE/bgin_mem_scan.asm

# 2. LINK: Creating the Sovereign Executable
# Binding the logic gate to the Linux 64-bit kernel
ld -s -o bin/bgin_gate bgin_mem_scan.o

# 3. VERIFY: Immediate Hardware Handshake
if [ -f "./bin/bgin_gate" ]; then
    echo "[BGIN SUCCESS] METAL GATE ACTIVATED: bin/bgin_gate"
    # Running the program to verify memory integrity
    ./bin/bgin_gate
else
    echo "[BGIN ERROR] COMPILATION FAILURE."
    exit 1
fi

#!#
