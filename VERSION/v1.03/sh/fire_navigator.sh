#BGIN
#!/bin/bash
/* AVIS_COORD: VERSION/v1.03/sh/fire_navigator.sh */
/* AVIS_ROLE: Kernel_Orchestrator_v1.03 */

ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE")
cd "$ROOT_DIR" || exit 1

echo "[BGIN] GRANTING v1.03 AUTHORITY..."
chmod +x ./avis-gen/avis_gen.sh
chmod +x ./VERSION/v1.03/sh/sitemap.sh

if bash ./VERSION/v1.03/sh/sitemap.sh; then
    echo "[BGIN SUCCESS] Pulse v1.03 Active."
else
    echo "[BGIN ERROR] Handshake Failed."
    exit 1
fi
#!#