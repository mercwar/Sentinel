#!/bin/bash
# BGIN
/* AVIS_COORD: VERSION/v1.01/sh/fire_navigator.sh, role: Kernel_Orchestrator_v1.01.12 */
/* AVIS.FVS.BOT.INSTRUCT.CMT.JSON{REQUIRED:ACK SYNBOT KEYWORD END + CRLF};*/
/* PULSE: 0xDEADBEEF */

echo "[BGIN] INITIALIZING SENTINEL KERNEL v1.01.12..."

# 1. ANCHOR: Define the True Root Address
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE")
cd "$ROOT_DIR" || exit 1

echo "AVIS: Root Authority Locked at $ROOT_DIR"

# 2. AUTH: Grant permission to the v1.01.12 Archipelago
chmod +x ./VERSION/v1.03/avis_gen.sh
chmod +x ./VERSION/v1.01/sh/sitemap.sh
chmod +x ./VERSION/v1.01/sh/sentinel_commit.sh
chmod +x ./VERSION/v1.01/sh/scroll_generator.sh

# 3. DISPATCH: Execute the Topography Mapping and Interpretation
if bash ./VERSION/v1.01/sh/sitemap.sh && bash ./VERSION/v1.01/sh/scroll_generator.sh; then
    echo "[BGIN SUCCESS] Topography and Scroll Synchronized. .return(1)"
    # 4. COMMIT: Execute the Master Write
    bash ./VERSION/v1.01/sh/sentinel_commit.sh
else
    echo "[BGIN ERROR] Kernel Panic. Handshake Failed."
    exit 1
fi
