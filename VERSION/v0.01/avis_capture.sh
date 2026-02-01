#!/bin/bash
# AVIS_COORD: avis-gen/avis_capture.sh
# AVIS_ROLE: Official_Paste_Capture_v1.12
# AUTHORITY: CVBGOD

# Define paths relative to the script location
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
TEMP_RAW="$SCRIPT_DIR/avis-gen/.raw_buffer"
ORCHESTRATOR="$SCRIPT_DIR/avis-gen/avis-gen.sh"

# Ensure the avis-gen directory exists
mkdir -p "$(dirname "$TEMP_RAW")"

echo "------------------------------------------------"
echo "[AVIS-GEN] READY FOR SOURCE PASTE"
echo "Capture active... End with #!# on a new line."
echo "------------------------------------------------"

# Clear previous buffer
> "$TEMP_RAW"

# 1. READ LINE-BY-LINE (Preserving all whitespace and characters)
# IFS='' prevents trimming of leading/trailing whitespace
# -r prevents backslash escapes from being interpreted
while IFS='' read -r line; do
    # 2. STOP AT MARKER
    if [[ "$line" == "#!#" ]]; then
        printf "%s\n" "$line" >> "$TEMP_RAW"
        break
    fi
    # 3. STORE IN .RAW_BUFFER
    printf "%s\n" "$line" >> "$TEMP_RAW"
done

echo -e "\n[AVIS] #!# DETECTED. DELEGATING TO PIPELINE..."

# 4. DELEGATE TO EXISTING AVIS SYSTEM
if [[ -f "$ORCHESTRATOR" ]]; then
    # Hand off the buffer to the existing orchestrator
    bash "$ORCHESTRATOR" "$TEMP_RAW"
    echo "------------------------------------------------"
    echo "[SUCCESS] AVIS PIPELINE COMPLETE."
else
    echo "[ERROR] avis-gen.sh NOT FOUND AT: $ORCHESTRATOR"
    exit 1
fi