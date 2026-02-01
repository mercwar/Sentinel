#!/bin/bash
# fire-mod.sh
# Module script: root-driven, performs modification tasks

set -euo pipefail
# Root initialization
source ./VERSION/v1.04/fire-root.sh

echo "[fire-mod] Starting ..."

# Make sure key fire scripts are executable
chmod +x $V_ROOT/fire-mod.sh
chmod +x $V_ROOT/fire-nav.sh
chmod +x $V_ROOT/fire-push.sh
chmod +x $V_ROOT/fire-source.sh
chmod +x $V_ROOT/fire-root.sh
chmod +x $V_ROOT/fire-end.sh

echo "[fire-mod] Module task completed."
#!#
