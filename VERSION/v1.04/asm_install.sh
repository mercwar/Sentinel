#!/bin/bash
#BGIN
# /* AVIS_COORD_DIR: VERSION/v1.04 */
# /* AVIS_COORD_FILE: asm_install.sh */
# /* AVIS_ROLE: Metal_Layer_Activator_v1.05.03 */

# 1. SHIELDED HYDRATION
APP_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$APP_DIR" || exit 1
mkdir -p ./bin

echo "--------------------------------------------------"
echo "[BGIN] ASM TOOLCHAIN: FIXING ENVIRONMENT VOID"
echo "--------------------------------------------------"

# 2. DEPENDENCY PULSE: Install NASM if missing
if ! command -v nasm &> /dev/null; then
    echo "[BGIN] NASM VOID DETECTED. FETCHING FROM APT..."
    sudo apt-get update && sudo apt-get install -y nasm binutils
fi

# 3. ATOMIC COMPILATION
if [ -f "./SOURCE/bgin_mem_scan.asm" ]; then
    echo "[BGIN] ASSEMBLING SOURCE..."
    nasm -f elf64 -o ./bin/bgin_mem_scan.o ./SOURCE/bgin_mem_scan.asm
    ld -s -o ./bin/bgin_gate ./bin/bgin_mem_scan.o
    
    if [ -f "./bin/bgin_gate" ]; then
        echo "[BGIN SUCCESS] METAL GATE ACTIVATED AT bin/bgin_gate"
    else
        echo "[BGIN ERROR] LINKER FAILURE."
        exit 1
    fi
else
    echo "[BGIN ERROR] SOURCE NOT FOUND AT ./SOURCE/bgin_mem_scan.asm"
    exit 1
fi

echo "--------------------------------------------------"
#!#

#FIRE!END#
