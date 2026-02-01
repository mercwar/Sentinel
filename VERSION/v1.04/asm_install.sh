#!/bin/bash
#BGIN
/* AVIS_COORD_DIR: VERSION/v1.04 */
/* AVIS_COORD_FILE: asm_install.sh */
/* AVIS_ROLE: ASM_Installer_v1.04.15 */

ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE")

echo "--------------------------------------------------"
echo "[BGIN] ASM INSTALLER v1.04: INITIALIZING METAL LAYER"
echo "--------------------------------------------------"

# 1. DEPENDENCY: Install NASM and GCC Toolchain
if ! command -v nasm &> /dev/null; then
    echo "[BGIN] INSTALLING NASM COMPILER..."
    sudo apt-get update && sudo apt-get install -y nasm gcc-multilib
else
    echo "[BGIN] NASM DETECTED: $(nasm --version)"
fi

# 2. COMPILE: Binary Handshake Execution
# Compiles the bgin_gate.asm into an ELF64 object
if [ -f "$ROOT_DIR/VERSION/v1.04/SOURCE/bgin_gate.asm" ]; then
    echo "[BGIN] COMPILING bgin_gate.asm..."
    nasm -f elf64 "$ROOT_DIR/VERSION/v1.04/SOURCE/bgin_gate.asm" -o "$ROOT_DIR/VERSION/v1.04/bin/bgin_gate.o"
    ld -s -o "$ROOT_DIR/VERSION/v1.04/bin/bgin_gate" "$ROOT_DIR/VERSION/v1.04/bin/bgin_gate.o"
    echo "[BGIN SUCCESS] METAL GATE ACTIVE AT: bin/bgin_gate"
else
    echo "[BGIN ERROR] SOURCE NOT FOUND."
fi

echo "--------------------------------------------------"
#!#
