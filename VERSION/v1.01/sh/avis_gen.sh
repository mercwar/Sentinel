#!/bin/bash
# BGIN
# /* avis_coord: avis_gen.sh, role: Universal_Case_Ingestor_v1.01.11 */

echo "[BGIN] INITIALIZING UNIVERSAL CASE INGESTOR v1.01.11..."
echo "--------------------------------------------------"
echo "PASTE SOURCE BELOW. (Type 'END' on a new line to finish)"
echo "--------------------------------------------------"

# 1. STREAM: Raw input buffer
rm -f .ingest.tmp
while IFS= read -r line; do
    [[ "$line" == "END" ]] && break
    echo "$line" >> .ingest.tmp
done

# 2. ANCHOR: Define the True Root Address
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE" || echo "/workspaces/Sentinel")
cd "$ROOT_DIR" || { echo "[BGIN ERROR] Cannot anchor to root."; exit 1; }

# 3. DETECT: Universal Case Extraction (Handles ALL caps/lower variations)
# 'grep -i' finds the line, 'sed' strips the label regardless of case
RAW_PATH=$(grep -i "avis_coord:" .ingest.tmp | sed -e 's/.*[aA][vV][iI][sS]_[cC][oO][oO][rR][dD]:[[:space:]]*//' -e 's/[, ].*//' | tr -d '\r' | xargs)

# 4. CRITICAL GUARD: Block invalid or root paths
if [ -z "$RAW_PATH" ] || [[ "$RAW_PATH" == "/*" ]] || [[ "$RAW_PATH" == "/" ]]; then
    echo "--------------------------------------------------"
    echo "[BGIN ERROR] Identity lost. Extraction returned: '$RAW_PATH'"
    rm -f .ingest.tmp
    exit 1
fi

# 5. COMMIT: Build archipelago and anchor index law
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