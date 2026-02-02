#!/bin/bash
#BGIN
# /* AVIS_COORD_DIR: VERSION/1.04 */
# /* AVIS_COORD_FILE: asm_install.sh */
# /* AVIS_ROLE: Metal_Layer_Activator_v1.05.34 */

V_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$V_DIR" || exit 1
mkdir -p ./bin

echo "--------------------------------------------------"
echo "[BGIN] IGNITING RECURSIVE KERNEL FUSION - 2026"
echo "--------------------------------------------------"

# 1. ASSEMBLE: Fusing the OS Rebuild Engine
SRC="../v1.05/SOURCE/bgin_kernel_fuser.asm"
if [ -f "$SRC" ]; then
    # Inject _start if missing for bit-perfect link
    if ! grep -q "global _start" "$SRC"; then
        sed -i '1i global _start' "$SRC"
    fi

    nasm -f elf64 -o ./bin/bgin_kernel_fuser.o "$SRC"
    ld -s -o ./bin/bgin_kernel_fuser ./bin/bgin_kernel_fuser.o

    if [ -f "./bin/bgin_kernel_fuser" ]; then
        echo "[BGIN SUCCESS] KERNEL FUSER ACTIVE: bin/bgin_kernel_fuser"
        chmod +x ./bin/bgin_kernel_fuser
        
        # 2. EXECUTE: Start the 1.5GB Fusion Pulse
        echo "[BGIN] COMMENCING OS REBUILD..."
        ./bin/bgin_kernel_fuser
    fi
fi
echo "--------------------------------------------------"
#!#
