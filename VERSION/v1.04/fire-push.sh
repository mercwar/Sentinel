#!/bin/bash
# fire-push.sh
# Calls sentinel_commit.sh to commit and push changes

set -euo pipefail
echo "[fire-nav] Starting ..."

# Root initialization
source ./VERSION/v1.04/fire-root.sh

echo "[fire-push] Starting push process..."


"$V_ROOT/sentinel_commit.sh"

echo "[fire-push] Push process completed."

#!#
