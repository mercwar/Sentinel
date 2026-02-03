#!/bin/bash
# fire-mod.sh
# Module script: root-driven, performs modification tasks

set -euo pipefail
# Root initialization
source /workspaces/Sentinel/VERSION/2.0/fire-gem/fire-root.sh

echo "[fire-mod] Starting ..."

# Make sure key fire scripts are executable

#chmod +x /workspaces/Sentinel/VERSION/2.0/fire-mod.sh
#source /workspaces/Sentinel/VERSION/v2.0/fire-mod.sh

chmod +x $V_ROOT/fire-gem.sh

echo "[fire-mod] Module task completed..."
echo ""
echo "[AVIS] You can run fire-gem now!"
#!#
