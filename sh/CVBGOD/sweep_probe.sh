#!/bin/bash
# BGIN
# /* AVIS_COORD: AVIS://BASH/SWEEP_PROBE/1.1.CVBGOD */
# /* ROLE: Anchors to SOURCE node and executes the 1.1 Index Sweep */

echo "[BGIN] RE-ANCHORING PROBE TO SOURCE NODE..."

# 1. COMPILE FROM SOURCE COORDINATE
# Anchoring the binary to the same directory for Heavy Dependency
gcc ./SOURCE/bgin_probe.c -o ./SOURCE/bgin_probe

# 2. RUN THE SWEEP
if [ -f "./SOURCE/bgin_probe" ]; then
    chmod +x ./SOURCE/bgin_probe
    
    # Define absolute path to prevent recursion drift
    PROBE_BIN="$(pwd)/SOURCE/bgin_probe"
    
    echo "AVIS: Commencing Sweep using $PROBE_BIN..."
    
    # Scan all files, excluding .git and the probe itself
    find . -type f ! -path './.git/*' ! -name "bgin_probe" -exec "$PROBE_BIN" {} \; | tee BGIN_SWEEP.log
    
    echo "[BGIN] Sweep Complete. Results locked in BGIN_SWEEP.log"
else
    echo "[BGIN ERROR] Source Node Link Failure. Compilation aborted."
    exit 1
fi