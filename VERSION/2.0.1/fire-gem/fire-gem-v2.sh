#!/bin/bash
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.01
# ;@DESC: Keyword-Aware Ingestor (Fixed Path Anchor)

set -euo pipefail
V_ROOT="/workspaces/Sentinel"
TEMP_RAW="$V_ROOT/.avis_gateway_buffer"

echo "[BGIN] KEYWORD GATEWAY V2.0.1 ACTIVE"
echo "[AVIS] DETECTING: gcc, sh, bash, apt, nasm..."

: > "$TEMP_RAW"

while IFS= read -r line || [[ -n "$line" ]]; do
    echo "$line" >> "$TEMP_RAW"
    [[ "$line" == *"RECOVERY_SIG_MATCHED"* ]] && break
done

FIRST_WORD=$(grep -v '^[#/;]' "$TEMP_RAW" | grep '[^[:space:]]' | head -n 1 | awk '{print $1}')

case "$FIRST_WORD" in
    "gcc")  COORD_FILE="compile.sh" ;;
    "nasm") COORD_FILE="build.sh" ;;
    "apt")  COORD_FILE="install.sh" ;;
    "sh"|"bash") COORD_FILE="script.sh" ;;
    *)      COORD_FILE="pulse.raw" ;;
esac

TARGET_PATH="$V_ROOT/VERSION/2.0/AI/bgin-avis/$COORD_FILE"
mkdir -p "$(dirname "$TARGET_PATH")"
cat "$TEMP_RAW" > "$TARGET_PATH"

echo "--------------------------------------------------"
echo "[SUCCESS] KEYWORD '$FIRST_WORD' DETECTED."
echo "[SUCCESS] SAVED TO: $TARGET_PATH"
echo "--------------------------------------------------"