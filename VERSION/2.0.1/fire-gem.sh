#!/bin/bash
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.01
# ;@FIX_ID: GLOB_PROTECTION_V2

set -euo pipefail
V_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "${GITHUB_WORKSPACE:-$(pwd)}")"

echo "[BGIN] FIRE-GEM GATEWAY V2.0.1.2 [GLOB-LOCKED]"
echo "[AVIS] PASTE SCROLL NOW..."

TEMP_RAW=".avis_gateway_buffer"
: > "$TEMP_RAW"

# --- THE FIX: Use read -r and avoid any unquoted expansion ---
while IFS= read -r line || [[ -n "$line" ]]; do
    # Use double quotes to prevent /* from turning into /bin
    echo "$line" >> "$TEMP_RAW"
    if [[ "$line" == *"RECOVERY_SIG_MATCHED"* ]]; then
        break
    fi
done

# --- SECURE PATH EXTRACTION ---
# We strip the comments AFTER the buffer is safely away from the shell
COORD_DIR=$(grep -i "avis_coord_dir" "$TEMP_RAW" | awk -F': ' '{print $2}' | tr -d '\r ' | sed 's|\*/||')
COORD_FILE=$(grep -i "avis_coord_file" "$TEMP_RAW" | awk -F': ' '{print $2}' | tr -d '\r ' | sed 's|\*/||')

TARGET_PATH="${V_ROOT}/${COORD_DIR}/${COORD_FILE}"
mkdir -p "$(dirname "$TARGET_PATH")"
cat "$TEMP_RAW" > "$TARGET_PATH"

echo "[SUCCESS] PULSE Installed: $TARGET_PATH"
