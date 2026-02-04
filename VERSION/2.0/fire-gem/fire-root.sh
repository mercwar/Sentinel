#!/bin/bash
# /* AVIS_COORD: VERSION/2.0/fire-gem/fire-root.sh */

# Fix: Go up TWO levels to reach /workspaces/Sentinel from /fire-gem
export V_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
export FIRE_GEM_ADDR="0xF17E6E3"

# Navigate to the real root
cd "$V_ROOT" || exit 1
echo "[BGIN] FIRE-GEM ANCHOR LOCKED AT: $V_ROOT"
