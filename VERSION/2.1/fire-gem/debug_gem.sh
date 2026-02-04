#!/bin/bash
# 1. SETUP ENVIRONMENT
GEM_KEY=${GEM_KEY:-"0xf17e6e3"}
V_ROOT=${V_ROOT:-"/workspaces/Sentinel"}

echo "--------------------------------------------------"
echo "[BGIN] DEBUG-GEM MONITOR ACTIVE (v2.0.1.2)"
echo "[BGIN] TARGET: $GEM_KEY | ROOT: $V_ROOT"
echo "--------------------------------------------------"

# 2. VERIFY SEGMENT (The Grep Check)
# This is where the padding mismatch fails:
SHM_ID=$(ipcs -m | grep "$GEM_KEY" | awk '{print $2}')

if [ -z "$SHM_ID" ]; then
    echo "[ERROR] FIRE-GEM NOT FOUND. RUN mz_reflector FIRST."
    exit 1
fi

# 3. MONITOR LOOP
echo "[BGIN] MONITORING PULSE 0xBE614 [CTRL+C to EXIT]"
while true; do
    # Peek at the first 128 bytes of the SHM file
    PEEK=$(hexdump -n 128 -C /dev/shm/fire-gem-$GEM_KEY 2>/dev/null)
    
    # PULSE TRIGGER: Check if byte 0 matches MZ (0x4D 0x5A)
    if [[ "$PEEK" == *"4d 5a"* ]]; then
        clear
        echo "--------------------------------------------------"
        echo "[AVIS] CURRENT HEADER PEEK (HEX):"
        echo "$PEEK"
        echo "--------------------------------------------------"
        sleep 1
    else
        echo -ne "[WAITING FOR PULSE]\r"
    fi
    sleep 0.5
done
