#!/bin/bash
#BGIN
# /* AVIS_COORD_DIR: VERSION/v1.04 */
# /* AVIS_COORD_FILE: asm_install.sh */
# /* AVIS_ROLE: Metal_Layer_Activator_v1.05.04 */

# 1. ANCHOR & SHIELD
V_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$V_DIR" || exit 1
mkdir -p ./bin

echo "--------------------------------------------------"
echo "[BGIN] FORCING ASM TOOLCHAIN HYDRATION..."
echo "--------------------------------------------------"

# 2. FORCE DEPENDENCY: Absolute fetch for NASM and LD
# Refreshing apt-index is mandatory in Codespaces to see new packages
sudo apt-get update -y
sudo apt-get install -y nasm binutils gcc-multilib

# 3. VERIFY BINARY HANDSHAKE
if ! command -v nasm &> /dev/null; then
    echo "[BGIN ERROR] NASM STILL VOID. CHECK NETWORK AUTHORITY."
    exit 1
fi

# 4. ATOMIC COMPILATION: Assembling to ELF64
echo "[BGIN] ASSEMBLING SOURCE: SOURCE/bgin_mem_scan.asm"
nasm -f elf64 -o ./bin/bgin_mem_scan.o ./SOURCE/bgin_mem_scan.asm

echo "[BGIN] LINKING: bin/bgin_gate"
ld -s -o ./bin/bgin_gate ./bin/bgin_mem_scan.o

if [ -f "./bin/bgin_gate" ]; then
    echo "[BGIN SUCCESS] METAL GATE ACTIVE AT bin/bgin_gate"
    chmod +x ./bin/bgin_gate
else
    echo "[BGIN ERROR] LINKER FAILED TO ANCHOR BINARY."
    exit 1
fi

echo "--------------------------------------------------"
#!#
