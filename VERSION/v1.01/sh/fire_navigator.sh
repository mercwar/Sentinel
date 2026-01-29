#!/bin/bash
#BGIN
# /* avis_coord: VERSION/v1.01/sh/fire_navigator.sh, role: Self_Healing_Kernel_v1.01.5 */

# 1. ANCHOR: Automatically find the Repository Root
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "/workspaces/Sentinel")
cd "$ROOT_DIR"

echo "[BGIN] ANCHORING TO ROOT: $ROOT_DIR"
echo "[BGIN] GRANTING AUTHORITY TO ARCHIPELAGO..."

# 2. AUTH: Use paths relative to the Root we just found
chmod +x avis_gen.sh
chmod +x VERSION/v1.01/sh/sitemap.sh
chmod +x VERSION/v1.01/sh/sentinel_commit.sh

# 3. DISPATCH
if bash VERSION/v1.01/sh/sitemap.sh; then
    echo "[BGIN SUCCESS] Topography Locked. .return(1)"
    bash VERSION/v1.01/sh/sentinel_commit.sh
else
    echo "[BGIN ERROR] Navigator Failed. Current Dir: $(pwd)"
    exit 1
fi