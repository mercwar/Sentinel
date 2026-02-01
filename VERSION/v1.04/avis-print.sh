#!/bin/bash
# avis-print.sh
# Writes AVIS content from a raw buffer file to the target file
# Requires environment variables or parameters:
#   TEMP_RAW - path to raw AVIS input file
#   AVIS_COORD_DIR - target directory relative to ROOT_DIR
#   AVIS_COORD_FILE - target file name
#   ROOT_DIR - base directory (defaults to current directory if unset)

set -euo pipefail

# Check required variables or parameters
if [[ -z "${TEMP_RAW:-}" || -z "${AVIS_COORD_DIR:-}" || -z "${AVIS_COORD_FILE:-}" ]]; then
    echo "[ERROR] Required variables TEMP_RAW, AVIS_COORD_DIR, or AVIS_COORD_FILE are not set."
    echo "Please set them before running this script."
    exit 1
fi

ROOT_DIR="${ROOT_DIR:-$(pwd)}"

TARGET_DIR="$ROOT_DIR/$AVIS_COORD_DIR"
TARGET_PATH="$TARGET_DIR/$AVIS_COORD_FILE"

mkdir -p "$TARGET_DIR"

# Write the AVIS content bit-perfectly
cat "$TEMP_RAW" > "$TARGET_PATH"

echo "------------------------------------------------"
echo "[avis-print] File written to: $TARGET_PATH"
echo "------------------------------------------------"
echo "[avis-print] File content:"
cat "$TARGET_PATH"
echo "------------------------------------------------"
