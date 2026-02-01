#!/bin/bash
# fire-nav.sh
# Top-level orchestrator: calls fire-root.sh once, then fire_source, fire-map, then fire-push

set -euo pipefail

echo "[fire-nav] Starting ..."

# Root initialization
source ./VERSION/v1.04/fire-root.sh

# Now $V_ROOT is set by fire-root.sh, use it to call other scripts

# 1. Call fire_source.sh
echo "[fire-nav] Calling fire_source.sh..."
bash "$V_ROOT/fire_source.sh" || { echo "[fire-nav] fire_source.sh failed"; exit 1; }

# 2. Call fire-map.sh
echo "[fire-nav] Calling fire-map.sh..."
bash "$V_ROOT/fire-map.sh" || { echo "[fire-nav] fire-map.sh failed"; exit 1; }

# 3. Call fire-push.sh
echo "[fire-nav] Calling fire-push.sh..."
bash "$V_ROOT/fire-push.sh" || { echo "[fire-nav] fire-push.sh failed"; exit 1; }

echo "[fire-nav] Orchestration completed successfully."
