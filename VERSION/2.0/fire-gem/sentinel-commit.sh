#!/bin/bash
# BGIN
# /* AVIS_COORD: VERSION/2.0/sh/sentinel_commit.sh, role: Auto_Committer_v2.0 */
# /* PULSE: 0xDEADBEEF */

echo "[BGIN] INITIALIZING SENTINEL DISPATCH..."

RES_FILE="/workspaces/Sentinel/VERSION/2.0/commit_msg.tmp"
DEFAULT_MSG="BGIN: Sentinel v2.0 Alpha Pulse [skip ci]"

# 1. READ: Extract description from the resource file
if [ -s "$RES_FILE" ]; then
    COMMIT_MSG=$(cat "$RES_FILE")
    echo "AVIS: Resource found. Using description from $RES_FILE"
else
    COMMIT_MSG="$DEFAULT_MSG"
    echo "AVIS: Resource empty. Reverting to Default Law."
fi

# 2. STAGE: Sync the Data Lake
git add .

# 3. DISPATCH: Perform the Master Write
echo "BGIN: Committing as Sentinel-Bot..."
git commit -m "$COMMIT_MSG"

if git push origin main; then
    echo "[BGIN SUCCESS] Pulse Delivered to GitHub. .return(1)"
    # Clear the tmp file for the next cycle
    > "$RES_FILE"
else
    echo "[BGIN ERROR] Dispatch failed. Check Network/Auth."
    exit 1
fi

