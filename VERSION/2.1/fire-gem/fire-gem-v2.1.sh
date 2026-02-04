#!/bin/bash
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.1
# ;@AUTHORITY: CVBGOD (2ED0213EFEFE9340)

set -euo pipefail
V_ROOT="/workspaces/Sentinel"
V_TARGET="$V_ROOT/VERSION/2.1/fire-gem"
TEMP_BUF="$V_ROOT/.avis_gateway_buffer"

echo "--------------------------------------------------"
echo "[BGIN] FIRE-GEM v2.1 GATEWAY ACTIVE"
echo "[READY] PASTE SOURCE + RECOVERY_SIG_MATCHED"
echo "--------------------------------------------------"

: > "$TEMP_BUF"
while IFS= read -r line || [[ -n "$line" ]]; do
    echo "$line" >> "$TEMP_BUF"
    [[ "$line" == *"RECOVERY_SIG_MATCHED"* ]] && break
done

FIRST_WORD=$(grep -v '^[#/;]' "$TEMP_BUF" | grep '[^[:space:]]' | head -n 1 | awk '{print $1}' || echo "pulse")

case "$FIRST_WORD" in
    "gcc")  F_NAME="sentinel_app.c" ;;
    "nasm") F_NAME="sentinel_startup.asm" ;;
    "php")  F_NAME="sentinel_portal.php" ;;
    *)      F_NAME="startup_pulse.raw" ;;
esac

cat "$TEMP_BUF" > "$V_TARGET/$F_NAME"
chmod +x "$V_TARGET/$F_NAME"
echo "[SUCCESS] MANIFESTED: $V_TARGET/$F_NAME"
