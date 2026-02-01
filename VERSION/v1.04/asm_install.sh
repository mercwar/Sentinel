#!/bin/bash
#BGIN
# /* AVIS_COORD_DIR: VERSION/v1.04 */
# /* AVIS_COORD_FILE: asm_install.sh */
# /* AVIS_ROLE: Metal_Layer_Activator_v1.05.07 */

V_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$V_DIR" || exit 1
mkdir -p ./bin

echo "--------------------------------------------------"
echo "[BGIN] EXECUTING ZERO-WARNING MANIFEST..."
echo "--------------------------------------------------"

# 1. SURGERY: Inject 'global _start' if missing to satisfy the linker
if ! grep -q "global _start" "./SOURCE/bgin_mem_scan.asm"; then
    echo "[BGIN] INJECTING ENTRY SYMBOL..."
    sed -i '1i global _start' "./SOURCE/bgin_mem_scan.asm"
fi

# 2. ASSEMBLE
echo "[BGIN] ASSEMBLING: SOURCE/bgin_mem_scan.asm"
nasm -f elf64 -o ./bin/bgin_mem_scan.o ./SOURCE/bgin_mem_scan.asm

# 3. LINK: No more warnings
echo "[BGIN] LINKING: bin/bgin_gate"
ld -s -o ./bin/bgin_gate ./bin/bgin_mem_scan.o

if [ -f "./bin/bgin_gate" ]; then
    echo "--------------------------------------------------"
    echo "[BGIN SUCCESS] METAL GATE ACTIVE: NO WARNINGS."
    echo "--------------------------------------------------"
    chmod +x ./bin/bgin_gate
fi
#!#

#FIRE!END#