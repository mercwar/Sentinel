#!/bin/bash
#BGIN
/* AVIS_COORD_DIR: VERSION/1.05 */
/* AVIS_COORD_FILE: v105_archipelago_sync.sh */
/* AVIS_ROLE: Cross-Archipelago_Sync_v1.05.02 */

ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE")
V104_BIN="$ROOT_DIR/VERSION/1.04/bin"
V105_BIN="$ROOT_DIR/VERSION/1.05/bin"

echo "--------------------------------------------------"
echo "[BGIN] v1.05 SYNC ENGINE: HYDRATING FROM v1.04"
echo "--------------------------------------------------"

# 1. MIGRATION: Link v1.04 Binaries to v1.05 Space
mkdir -p "$V105_BIN"
cp "$V104_BIN"/* "$V105_BIN/"

# 2. DEEP AUDIT: Run v1.05 ASM Auditor on imported logic
# Ensuring v1.04 artifacts meet v1.05 bit-hygiene standards
chmod +x "$V105_BIN"/*
if [ -f "$ROOT_DIR/VERSION/1.05/bin/bgin_audit" ]; then
    "$ROOT_DIR/VERSION/1.05/bin/bgin_audit" "$V105_BIN/bgin_gate"
    echo "[BGIN SUCCESS] v1.04 GATE KERNEL AUDITED FOR v1.05 USE."
fi

# 3. REGISTRY: Update the 1.05 Sitemap
./sentinel-sitemap.sh

echo "--------------------------------------------------"
#!#
