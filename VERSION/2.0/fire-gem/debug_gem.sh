# #[avis] begin template bash
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.01
# ;@AUTHORITY: CVBGOD (2ED0213EFEFE9340)
# ;@VERSION: 2.0.1
# avis_coord_dir: VERSION/2.0/fire-gem
# avis_coord_file: debug_gem.sh

#BGIN
#!/bin/bash
# ;@ENGINE: BGIN.AVIS_CJS_v2.0
# ;@DESC: Real-time FIRE-GEM Monitor (Naked Execution)

# 1. ATTACH ANCHOR
# Fix: Ensure BASH_SOURCE is handled correctly for direct execution
V_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
GEM_KEY="0xf17e6e3"

echo "--------------------------------------------------"
echo "[BGIN] DEBUG-GEM MONITOR ACTIVE (v2.0.1.2)"
echo "[BGIN] TARGET: $GEM_KEY | ROOT: $V_ROOT"
echo "--------------------------------------------------"

# 2. VERIFY SEGMENT
SHM_ID=$(ipcs -m | grep -E "${GEM_KEY#0x}|${GEM_KEY}" | awk '{print $2}')

if [ -z "$SHM_ID" ]; then
    echo "[ERROR] FIRE-GEM NOT FOUND. RUN mz_reflector FIRST."
    exit 1
fi

# 3. MONITOR LOOP
while true; do
    clear
    echo "[BGIN] MONITORING PULSE 0xBE614 [CTRL+C to EXIT]"
    echo "--------------------------------------------------"
    ipcs -m -i "$SHM_ID" | grep -A 5 "Shared Memory"
    echo "--------------------------------------------------"
    echo "[AVIS] CURRENT HEADER PEEK (HEX):"
    hexdump -n 128 -C /dev/shm/fire_gem_pulse 2>/dev/null || echo "[WAITING FOR PULSE]"
    sleep 1
done
#!#

#FIRE!END# DO NOT MODIFY
#!# RECOVERY_SIG_MATCHED
