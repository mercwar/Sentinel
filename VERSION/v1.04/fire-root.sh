#!/bin/bash
#BGIN
# /* AVIS_COORD: VERSION/v1.04/fire-root.sh */
# /* AVIS_ROLE:  */

# 1. ANCHOR: Define the versioned root directory (directory of the current script)
V_ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$V_ROOT" || exit 1

echo "[BGIN] FIRING v1.04 KERNEL FROM: $V_ROOT"
echo "--------------------------------------------------"



#!#