#!/bin/bash
# BGIN
# /* avis_coord: avis_gen.sh, role: String_Trigger_Ingestor_v1.01.9 */

echo "[BGIN] INITIALIZING STRING-TRIGGER INGESTOR v1.01.9..."
echo "--------------------------------------------------"
echo "PASTE SOURCE BELOW."
echo "TYPE 'END' ON A NEW LINE AND PRESS ENTER TO FINISH."
echo "--------------------------------------------------"

# 1. STREAM: Custom read loop to detect the "END" string
# This bypasses the need for Ctrl+D / Ctrl+Shift
rm -f .ingest.tmp
while IFS= read -r line; do
    if [[ "$line" == "END" ]]; then
        break
    fi
    echo "$line" >> .ingest.tmp
done

# 2. ANCHOR: Define the True Root Address
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE" || echo "/workspaces/Sentinel")
cd "$ROOT_DIR" || { echo "[BGIN ERROR] Cannot anchor to root."; exit 1; }

# 3. DETECT: Extraction with multi-stage sanitization
RAW_PATH=$(grep -i "avis_coord:" .ingest.tmp | sed -e 's/.*avis_coord:[[:space:]]*//' -e 's/[, ].*//' | tr -d '\r' | xargs)

# 4. CRITICAL GUARD: Block invalid or root paths
if [ -z "$RAW_PATH" ] || [[ "$RAW_PATH" == /* ]] || [[ "$RAW_PATH" == "/" ]]; then
    echo "[BGIN ERROR] Pathing Drift. Extraction returned: '$RAW_PATH'"
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
