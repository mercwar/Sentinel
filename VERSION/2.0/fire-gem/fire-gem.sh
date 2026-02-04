#!/bin/bash
# /* AVIS_COORD: VERSION/2.0/fire-root.sh */
# /* AVIS_ROLE: ANCHOR_SERVICE */

# 1. ANCHOR: Force the versioned root to the physical directory
export V_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export FIRE_GEM_ADDR="0xF17E6E3"
export BGIN_HOOK="0xBE614"

cd "$V_ROOT" || exit 1
echo "[BGIN] FIRE-GEM ANCHOR LOCKED AT: $V_ROOT"
