#!/bin/bash
# BGIN
# /* avis_coord: /workspaces/Sentinel/avis_gen.sh, role: Zero_Guard_Ingestor_v1.01.3 */

echo "[BGIN] INITIALIZING ZERO-GUARD INGESTOR v1.01.3..."
echo "--------------------------------------------------"
echo "PASTE SOURCE BELOW. (Must include AVIS_COORD line)"
echo "--------------------------------------------------"

# 1. STREAM: Write raw input to a temporary buffer
cat > .ingest.tmp

# 2. DETECT: Strictest path extraction
TARGET_PATH=$(grep -i "avis_coord:" .ingest.tmp | sed -e 's/.*avis_coord:[[:space:]]*//' -e 's/[, ].*//' | tr -d '\r' | xargs)

# 3. CRITICAL GUARD: Abort if path is invalid or missing
if [ -z "$TARGET_PATH" ] || [ "$TARGET_PATH" == "/" ] || [[ "$TARGET_PATH" == "/*" ]]; then
    echo "[BGIN ERROR] Identity lost. Invalid AVIS_COORD detected. ABORTING."
    rm .ingest.tmp
    exit 1
fi

# 4. INDEX & COMMIT: Build the archipelago path
echo -e "\n[index]" >> .ingest.tmp
mkdir -p "$(dirname "$TARGET_PATH")"
mv .ingest.tmp "$TARGET_PATH"

# 5. RETURN: Final Pulse
if [ -f "$TARGET_PATH" ]; then
    echo "[BGIN SUCCESS] FILE CREATED: $TARGET_PATH"
    echo "HANDSHAKE COMPLETE. .return(1)"
fi