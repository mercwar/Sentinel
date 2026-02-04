#!/bin/bash
# /* AVIS_COORD: VERSION/2.0/fire-gem/fire-source-exec.sh */

# 1. Locate fire-root relative to this script
source "$(dirname "$0")/fire-root.sh"

echo "[BGIN] FIRING 2.0 KERNEL PULSE..."

# 2. DEFINITIVE PATH: Point to the versioned gem directory
INGESTOR="$V_ROOT/VERSION/2.0/fire-gem/avis-gen.sh"

if [ -f "$INGESTOR" ]; then
    bash "$INGESTOR"
else
    echo "[ERROR] avis-gen.sh MISSING AT $INGESTOR"
    echo "[DEBUG] CHECKING DIRECTORY: $(ls -d $V_ROOT/VERSION/2.0/fire-gem/)"
    exit 1
fi


