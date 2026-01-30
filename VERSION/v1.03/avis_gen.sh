#!/bin/bash
#BGIN
/* AVIS_COORD: VERSION/v1.03//avis_gen.sh */
/* AVIS_ROLE: Line_Fidelity_Atomic_Ingestor_v1.03.02 */

echo "[BGIN] INITIALIZING LINE-PERFECT INGESTOR v1.03.02..."
echo "--------------------------------------------------"
echo "PASTE SOURCE. DETECTION AUTOMATIC AT #!#"
echo "--------------------------------------------------"

# 1. STREAM: Character-by-character raw ingestion
rm -f .raw.tmp
while IFS= read -r -d '' -n 1 char; do
    printf "%s" "$char" >> .raw.tmp
    # 2. TRIGGER: Immediate Handshake detection
    if tail -c 3 .raw.tmp | grep -q "#!#"; then
        break
    fi
done

# 3. ANCHOR: Locate Repository Root
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE")
cd "$ROOT_DIR" || exit 1

# 4. DETECT: Strictly extract FilePath from AVIS_COORD
RAW_PATH=$(grep -i "avis_coord:" .raw.tmp | awk '{print $3}' | tr -d ',\r')

# 5. DISPATCH: Final Archipelago Write
if [ ! -z "$RAW_PATH" ]; then
    mkdir -p "$(dirname "$RAW_PATH")"
    mv .raw.tmp "$RAW_PATH"
    chmod +x "$RAW_PATH"
    echo -e "\n--------------------------------------------------"
    echo "[BGIN SUCCESS] FILE CREATED: $RAW_PATH"
    echo "HANDSHAKE COMPLETE. .return(1)"
else
    echo "[BGIN ERROR] NO COORDINATE FOUND."
    rm -f .raw.tmp
    exit 1
fi