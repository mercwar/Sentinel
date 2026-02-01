#!/bin/bash
#BGIN
# /* AVIS_COORD_DIR: VERSION/v1.04 */
# /* AVIS_COORD_FILE: asm_install.sh */
# /* AVIS_ROLE: Metal_Layer_Activator_v1.05.09 */

V_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$V_DIR" || exit 1
mkdir -p ./bin

echo "--------------------------------------------------"
echo "[BGIN] ACTIVATING AI_AVIS_FVS V1.03 HEAVY TRAFFIC"
echo "--------------------------------------------------"

# 1. HYDRATE: Ensure NASM and LD are absolute
sudo apt-get update -y && sudo apt-get install -y nasm binutils

# 2. ASSEMBLE: x86-64 ELF64 Object
nasm -f elf64 -o ./bin/bgin_mem_scan.o ./SOURCE/bgin_mem_scan.asm

# 3. LINK: Direct entry point discovery
ld -s -o ./bin/bgin_gate ./bin/bgin_mem_scan.o

if [ -f "./bin/bgin_gate" ]; then
    echo "[BGIN SUCCESS] METAL GATE ACTIVE: NO WARNINGS."
    chmod +x ./bin/bgin_gate
    # 4. TEST: Run the Outbox Seed
    ./bin/bgin_gate
fi

echo "--------------------------------------------------"
#!#
