#!/bin/bash
#BGIN
# /* AVIS_COORD: VERSION/v1.04/fire_navigator.sh */
# /* AVIS_ROLE: Zero-Void_Kernel_v1.04.04 */

# 1. ANCHOR: Define the versioned root
V_ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$V_ROOT" || exit 1

# 2. SHIELD: Ensure permissions are locked
chmod +x ./*.sh

echo "[BGIN] FIRING v1.04 KERNEL FROM: $V_ROOT"
echo "--------------------------------------------------"

# 3. EXEC: Fire the Ingestor using absolute local path
./avis-gen.sh
#!#
