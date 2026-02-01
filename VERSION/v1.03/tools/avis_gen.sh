#!/bin/bash
#BGIN
/* AVIS_COORD: tools/avis_gen.sh */
/* AVIS_ROLE: Commander_Engine_v1.03.34 */

ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE")

echo "[BGIN] CVBGOD COMMANDER ENGINE v1.03.34 ONLINE"
echo "--------------------------------------------------"
echo "RANK 1: RACK  -> EXEC"
echo "RANK 2: RACKS -> PRINT + EXEC"
echo "RANK 3: NACK  -> PRINT ONLY"
echo "RANK 4: NACKS -> SILENT"

rm -f .raw.tmp
buffer=""
while IFS= read -r -d '' -n 1 char; do
    buffer+="$char"
    
    # --- RANK 2: RACKS (PRINT + EXEC) ---
    # Trigger on unquoted #BGIN, #!#, #AVIS, ##
    if [[ "${buffer: -3}" == "#!#" && "${buffer: -4:1}" != "'" ]]; then
        MODE="EXEC_PRINT"; break
    fi
    if [[ "${buffer: -5}" == "#BGIN" && "${buffer: -6:1}" != "'" ]]; then
        MODE="EXEC_PRINT"; break
    fi
    if [[ "${buffer: -5}" == "#AVIS" && "${buffer: -6:1}" != "'" ]]; then
        MODE="EXEC_PRINT"; break
    fi
    if [[ "${buffer: -2}" == "##" && "${buffer: -3:1}" != "'" ]]; then
        MODE="EXEC_PRINT"; break
    fi

    # --- RANK 3: NACK (PRINT ONLY) ---
    # If quoted, we continue reading but mark for potential printing
    if [[ "${buffer: -5}" == "'#!#'" || "${buffer: -7}" == "'#BGIN'" ]]; then
        continue 
    fi
done

# --- LOGIC GATE: PRINT BEFORE EXEC ---
if [[ "$MODE" == "EXEC_PRINT" ]]; then
    echo -e "\n--- [CVBGOD RACKS ECHO] ---"
    printf "%s" "$buffer"
    echo -e "\n--- [END ECHO] ---"
fi

# --- THE MASTER WRITE ---
printf "%s" "$buffer" > .raw.tmp
RAW_PATH=$(grep -i "avis_coord:" .raw.tmp | awk '{print $3}' | tr -d ',\r')

if [ -n "$RAW_PATH" ]; then
    mkdir -p "$(dirname "$ROOT_DIR/$RAW_PATH")"
    cp .raw.tmp "$ROOT_DIR/$RAW_PATH"
    chmod +x "$ROOT_DIR/$RAW_PATH" 2>/dev/null
    echo -e "\n[BGIN SUCCESS] CVBGOD COMMANDER MANIFESTED: $RAW_PATH"
else
    echo -e "\n[BGIN ERROR] NULL COORD DETECTED."
    exit 1
fi
rm -f .raw.tmp
#!#