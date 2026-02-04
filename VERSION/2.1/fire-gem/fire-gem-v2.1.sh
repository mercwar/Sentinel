#!/bin/bash
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.1.1
# ;@DESC: X-Ray Keyword Ingestor (Header-Aware)

set -euo pipefail
V_TARGET="/workspaces/Sentinel/VERSION/2.1/fire-gem"
TEMP_BUF="/workspaces/Sentinel/.avis_gateway_buffer"

echo "[BGIN] X-RAY GATEWAY v2.1.1 ACTIVE"
: > "$TEMP_BUF"
while IFS= read -r line || [[ -n "$line" ]]; do
    echo "$line" >> "$TEMP_BUF"
    [[ "$line" == *"RECOVERY_SIG_MATCHED"* ]] && break
done

# X-RAY DETECTION: Find first word that isn't a shebang or comment
FIRST_WORD=$(grep -vE '^#!|^[#/;]|^[[:space:]]*$' "$TEMP_BUF" | head -n 1 | awk '{print $1}' | tr -d '();')

case "$FIRST_WORD" in
    "gcc")  F_NAME="sentinel_app.c" ;;
    "nasm") F_NAME="sentinel_startup.asm" ;;
    "php")  F_NAME="sentinel_portal.php" ;;
    "sh"|"bash") F_NAME="sentinel_pulse.sh" ;;
    *)      F_NAME="pulse.raw" ;;
esac

cat "$TEMP_BUF" > "$V_TARGET/$F_NAME"
chmod +x "$V_TARGET/$F_NAME"
echo "[SUCCESS] DETECTED: $FIRST_WORD -> $V_TARGET/$F_NAME"
