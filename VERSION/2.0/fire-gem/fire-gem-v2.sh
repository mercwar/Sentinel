#!/bin/bash
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.01
set -euo pipefail
V_ROOT="/workspaces/Sentinel"
TEMP_RAW="$V_ROOT/.avis_gateway_buffer"
: > "$TEMP_RAW"
while IFS= read -r line || [[ -n "$line" ]]; do
    echo "$line" >> "$TEMP_RAW"
    [[ "$line" == *"RECOVERY_SIG_MATCHED"* ]] && break
done
FIRST_WORD=$(grep -v '^[#/;]' "$TEMP_RAW" | grep '[^[:space:]]' | head -n 1 | awk '{print $1}')
case "$FIRST_WORD" in
    "gcc")  COORD_FILE="sentinel_monitor.c" ;;
    "nasm") COORD_FILE="sentinel_v2.asm" ;;
    "apt")  COORD_FILE="setup_env.sh" ;;
    "sh"|"bash") COORD_FILE="sentinel_pulse.sh" ;;
    *)      COORD_FILE="pulse.raw" ;;
esac
TARGET_PATH="$V_ROOT/VERSION/2.0/fire-gem/$COORD_FILE"
mkdir -p "$(dirname "$TARGET_PATH")"
cat "$TEMP_RAW" > "$TARGET_PATH"
echo "[SUCCESS] ALIGNED TO: $TARGET_PATH"
