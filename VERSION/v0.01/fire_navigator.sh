#!/bin/bash
#BGIN
/* AVIS_COORD: avis-gen/fire_navigator.sh */
/* AVIS_ROLE: Authority_Granting_Kernel_v1.03.41 */

# 1. ANCHOR: Define the local app directory
APP_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$APP_DIR" || exit 1

# 2. AUTHORITY: Grant execution to the suite
chmod +x ./*.sh

# 3. EXEC: Fire the Ingestor with the local MAP path
# This prevents the 'PROTOCOL VOID' by explicitly defining the config
echo "[BGIN] FIRING AVIS-GEN FROM: $APP_DIR"
./avis-gen.sh
#!#
