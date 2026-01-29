#!/bin/bash
# BGIN
# /* avis_coord: avis_gen.sh, role: Hardened_Root_Ingestor_v1.01.8 */

echo "[BGIN] INITIALIZING HARDENED ROOT INGESTOR v1.01.8..."
echo "--------------------------------------------------"
echo "PASTE SOURCE BELOW. (Ctrl+D to finish)"
echo "--------------------------------------------------"

# 1. STREAM: Write raw input to a temporary buffer to avoid shell interpretation
cat > .ingest.tmp

# 2. ANCHOR: Define the True Root Address
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE" || echo "/workspaces/Sentinel")
cd "$ROOT_DIR" || { echo "[BGIN ERROR] Cannot anchor to root."; exit 1; }

# 3. DETECT: Extraction with multi-stage sanitization to prevent empty/root paths
# This specifically targets the "avis_coord:" tag regardless of casing
RAW_PATH=$(grep -i "avis_coord:" .ingest.tmp | sed -e 's/.*avis_coord:[[:space:]]*//' -e 's/[, ].*//' | tr -d '\r' | xargs)

# 4. CRITICAL GUARD: Block invalid, absolute, or system-root paths
if [ -z "$RAW_PATH" ] || [[ "$RAW_PATH" == /* ]] || [[ "$RAW_PATH" == "/" ]]; then
    echo "[BGIN ERROR] Pathing Drift Detected. Extraction returned: '$RAW_PATH'"
    echo "ABORTING to prevent unauthorized Root write."
    rm .ingest.tmp
    exit 1
fi

# 5. COMMIT: Build directory and move file from buffer
mkdir -p "$(dirname "$RAW_PATH")"
echo -e "\n[index]" >> .ingest.tmp
mv .ingest.tmp "$RAW_PATH"

# 6. AUTH: Grant immediate execution authority
chmod +x "$RAW_PATH" 2>/dev/null

# 7. RETURN: Final Pulse
if [ -f "$RAW_PATH" ]; then
    echo "--------------------------------------------------"
    echo "[BGIN SUCCESS] FILE CREATED: $RAW_PATH"
    echo "HANDSHAKE COMPLETE. .return(1)"
fi
