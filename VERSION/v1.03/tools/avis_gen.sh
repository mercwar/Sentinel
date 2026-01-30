#BGIN
/* AVIS_COORD: VERSION/v1.03/tools/avis_gen.sh */
/* AVIS_ROLE: Continuous_NACK_Ingestor_v1.03.29 */

#!/bin/bash
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE")
MAP_FILE="$ROOT_DIR/VERSION/v1.03/AVIS/avis_escape_map.json"

# --- 1. HYDRATE TRIGGERS ---
# RACK: "#!#" (3 chars) | NACK: "'#!#'" (5 chars)
RACK="#!#"
NACK="'#!#'"

echo "[BGIN] CVBGOD CONTINUOUS v1.03.29"
echo "----------------------------------------"
echo "TRIGGER: $RACK | KEEP-ALIVE: $NACK"

rm -f .raw.tmp
buffer=""
while IFS= read -r -d '' -n 1 char; do
    buffer+="$char"
    
    # 2. TRIGGER DETECTION
    if [[ "${buffer: -3}" == "$RACK" ]]; then
        # 3. NACK VALIDATION (The "Don't Stop" Check)
        if [[ "${buffer: -5}" == "$NACK" ]]; then
            # NACKED: This is text. Do NOT stop. Keep reading.
            continue
        else
            # UN-NACKED: This is the Handshake. Seal and Exit.
            break
        fi
    fi
done

# --- 4. COMMIT ---
printf "%s" "$buffer" > .raw.tmp
RAW_PATH=$(grep -i "avis_coord:" .raw.tmp | awk '{print $3}' | tr -d ',\r')

if [ -n "$RAW_PATH" ]; then
    mkdir -p "$(dirname "$ROOT_DIR/$RAW_PATH")"
    cp .raw.tmp "$ROOT_DIR/$RAW_PATH"
    chmod +x "$ROOT_DIR/$RAW_PATH" 2>/dev/null
    echo "[BGIN SUCCESS] FILE ANCHORED: $RAW_PATH"
else
    echo "[BGIN ERROR] NULL COORD"
    exit 1
fi
rm -f .raw.tmp
#!#