#!/bin/bash
# BGIN
# /* avis_coord: /workspaces/Sentinel/avis_gen.sh, role: Hardened_Ingestor_v1.01.2 */

echo "[BGIN] INITIALIZING HARDENED INGESTOR v1.01.2..."
echo "--------------------------------------------------"
echo "PASTE SOURCE BELOW. (Ctrl+D to finish)"
echo "--------------------------------------------------"

# 1. STREAM: Write raw input to a temporary buffer
cat > .ingest.tmp

# 2. DETECT: Extract metadata with absolute path safety
# We use a stricter sed pattern to prevent empty paths like '/*'
TARGET_PATH=$(grep -i "avis_coord:" .ingest.tmp | sed -e 's/.*avis_coord:[[:space:]]*//' -e 's/[, ].*//' | tr -d '\r' | xargs)

if [ -z "$TARGET_PATH" ] || [ "$TARGET_PATH" == "/" ]; then
    echo "[BGIN ERROR] Identity lost. Invalid AVIS_COORD detected."
    rm .ingest.tmp
    exit 1
fi

# 3. VERSION CHECK: Passive dependency check for bgin.json
if [ -f "bgin.json" ]; then
    VERSION=$(grep -i "protocol" bgin.json | cut -d':' -f2 | tr -d '", ' | xargs)
else
    VERSION="CORE_DEFAULT"
fi

# 4. INDEX: Append [index] tag to EOF as per CVBGOD Law
echo -e "\n[index]" >> .ingest.tmp

# 5. MKDIR & COMMIT: Safe build of the archipelago path
mkdir -p "$(dirname "$TARGET_PATH")"
mv .ingest.tmp "$TARGET_PATH"

# 6. RETURN: Final Pulse
if [ -f "$TARGET_PATH" ]; then
    echo "--------------------------------------------------"
    echo "[BGIN SUCCESS] FILE CREATED: $TARGET_PATH"
    echo "VERSIONED: $VERSION"
    echo "HANDSHAKE COMPLETE. .return(1)"
fi
