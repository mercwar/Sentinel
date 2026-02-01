#!/bin/bash
#BGIN
/* AVIS_COORD: tools/avis_gen.sh */
/* AVIS_ROLE: Protocol_V1.03.33_Master_Orchestrator_v1.03.40 */

ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE")
MAP_FILE="$ROOT_DIR/VERSION/v1.03/AVIS/avis_gen.json"

# --- 1. HYDRATION: PARSE BGIN.ACK,MAP.V1.03.33 ---
if [ ! -f "$MAP_FILE" ]; then
    echo "[BGIN ERROR] PROTOCOL VOID. Map V1.03.33 not found."
    exit 1
fi

# Extracting RACKS and NACKS using Protocol-Strict regex
RACKS=($(grep -Po '(?<="RACKS": \[).*?(?=\])' "$MAP_FILE" | tr -d '",'))
NACKS=($(grep -Po '(?<="NACK": \[).*?(?=\])' "$MAP_FILE" | tr -d '",'))

echo "[BGIN] PROTOCOL V1.03.33 ACTIVE — AUTHORITY: CVBGOD"
echo "--------------------------------------------------"
echo "EOL LAW: CRLF | BATCH_CRLF: ACTIVE"

# --- 2. BUFFERING: CYCLIC TMP CAPTURE ---
TMP_OBJ=".avis_stream.tmp"
cat > "$TMP_OBJ"
FILE_SIZE=$(stat -c%s "$TMP_OBJ")
CURSOR=0

# --- 3. EXECUTION ENGINE: DETERMINISTIC SCAN ---
while [ "$CURSOR" -lt "$FILE_SIZE" ]; do
    buffer=""
    while IFS= read -r -d '' -n 1 char; do
        buffer+="$char"
        ((CURSOR++))
        
        # Check against NACK (Null Ack) first for protection
        for N in "${NACKS[@]}"; do
            if [[ "${buffer: -${#N}}" == "$N" ]]; then
                MODE="NACK"; continue 2
            fi
        done

        # Check against RACKS (Master Print + Exec)
        for R in "${RACKS[@]}"; do
            if [[ "${buffer: -${#R}}" == "$R" ]]; then
                MODE="RACKS"; break 2
            fi
        done
        
        if [ "$CURSOR" -ge "$FILE_SIZE" ]; then MODE="LAST"; break; fi
    done < <(tail -c +"$((CURSOR+1))" "$TMP_OBJ")

    # --- 4. FORMATTING & MANIFEST ---
    # Apply CRLF Law before manifest
    printf "%s" "$buffer" | sed 's/$/\r/' > ".formatted_cycle.tmp"
    
    if [[ "$MODE" == "RACKS" ]]; then
        echo -e "\n--- [PROTOCOL EXEC_PRINT ECHO] ---"
        cat ".formatted_cycle.tmp"
    fi

    RAW_PATH=$(grep -i "avis_coord:" ".formatted_cycle.tmp" | awk '{print $3}' | tr -d ',\r')
    if [ -n "$RAW_PATH" ]; then
        mkdir -p "$(dirname "$ROOT_DIR/$RAW_PATH")"
        mv ".formatted_cycle.tmp" "$ROOT_DIR/$RAW_PATH"
        echo -e "\n[BGIN SUCCESS] PROTOCOL ANCHORED: $RAW_PATH"
    fi
    if [ "$MODE" == "LAST" ]; then break; fi
done
rm -f "$TMP_OBJ" ".formatted_cycle.tmp"
#!#

