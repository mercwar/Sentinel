#!/bin/bash
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.00
# ;@FIX_ID: TERMINAL_CLIP_FLUSH

set -euo pipefail
source "$(dirname "$0")/fire-root.sh"

TEMP_RAW=".avis_raw_buffer"
: > "$TEMP_RAW"

echo "[BGIN] REINFORCED PULSE START. PASTE SCROLL NOW..."

# Loop with -t 1 (timeout) to catch the end of the paste buffer
while IFS= read -r -t 2 line || [[ -n "$line" ]]; do
    echo "$line" >> "$TEMP_RAW"
    case "$line" in
        "#!# RECOVERY_SIG_MATCHED") 
            echo "[BGIN] TERMINATOR DETECTED."
            break 
            ;;
    esac
done

# Resolve paths (Added stripping for ; and @)
COORD_DIR=$(grep -i "avis_coord_dir" "$TEMP_RAW" | sed -E 's/^[; #/!@]*avis_coord_dir[:[:space:]]+([^ ;*]+).*/\1/I' | tr -d '\r')
COORD_FILE=$(grep -i "avis_coord_file" "$TEMP_RAW" | sed -E 's/^[; #/!@]*avis_coord_file[:[:space:]]+([^ ;*]+).*/\1/I' | tr -d '\r')

TARGET_DIR="$V_ROOT${COORD_DIR:-/}"
TARGET_PATH="${TARGET_DIR%/}/$COORD_FILE"

mkdir -p "$TARGET_DIR"
cat "$TEMP_RAW" > "$TARGET_PATH"
chmod 644 "$TARGET_PATH"

echo "------------------------------------------------"
echo "[AVIS] INSTALL SUCCESS: $TARGET_PATH"
echo "[BGIN] BYTES INGESTED: $(wc -c < "$TARGET_PATH")"
echo "------------------------------------------------"
