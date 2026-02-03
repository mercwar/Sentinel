#!/bin/bash
# fire-mod.sh
# Module script: root-driven, performs modification tasks

set -euo pipefail
# Root initialization
source /workspaces/Sentinel/VERSION/v1.04/fire-root.sh

echo "[fire-mod] Starting ..."

# Make sure key fire scripts are executable
chmod +x $V_ROOT/fire-mod.sh
chmod +x $V_ROOT/fire-nav.sh
chmod +x $V_ROOT/fire-push-exec.sh
chmod +x $V_ROOT/fire-source-exec.sh
chmod +x $V_ROOT/fire-root.sh
chmod +x $V_ROOT/fire-end.sh
chmod +x $V_ROOT/asm_install.sh
chmod +x /workspaces/Sentinel/sitemap.sh
chmod +x /workspaces/Sentinel/VERSION/1.04/asm_install.sh
echo "[fire-mod] Module task completed."
#!#
