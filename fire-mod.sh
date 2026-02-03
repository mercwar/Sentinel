#!/bin/bash
# fire-mod.sh
# Module script: root-driven, performs modification tasks

set -euo pipefail
# Root initialization
#source /workspaces/Sentinel/VERSION/v1.04/fire-root.sh

echo "[fire-mod] Starting ..."

# Make sure key fire scripts are executable
chmod +x /workspaces/Sentinel/build-sentinel.sh

echo "[fire-mod] Module task completed."
#!#
