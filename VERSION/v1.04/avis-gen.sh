#!/bin/bash
# avis-gen.sh - AVIS ingestion script v1.0
# Reads AVIS block from terminal until '#!#'
# Parses AVIS_COORD_DIR and AVIS_COORD_FILE from AVIS comment block
# Writes the AVIS block bit-perfectly to the target file
# Creates directories as needed
# Prints file content and full path after writing

set -euo pipefail
source /workspaces/Sentinel/VERSION/v1.04/fire-root.sh
echo "Kernal Avis Gen"
# Determine root directory fallback to current directory
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "${GITHUB_WORKSPACE:-$(pwd)}")

TEMP_RAW=".avis_raw_buffer"
> "$TEMP_RAW"

echo "------------------------------------------------"
echo "[avis-gen] Paste AVIS block, end with '#!#' on a line by itself."
echo "------------------------------------------------"

# Read input lines until terminator '#!#'
while IFS= read -r line; do
    echo "$line" >> "$TEMP_RAW"
    [[ "$line" == "#!#" ]] && break
done

TEMP_RAW+="/VERSION/v1.04/fire-end.sh\""$'\n'


# Extract AVIS comment block lines between /* and */
AVIS_COMMENT_BLOCK=$(sed -n '/\/\*/,/\*\//p' "$TEMP_RAW")

# Parse AVIS_COORD_DIR and AVIS_COORD_FILE from comment block
AVIS_COORD_DIR=$(echo "$AVIS_COMMENT_BLOCK" | grep -i "avis_coord_dir" | head -n1 | sed -E 's/.*avis_coord_dir[^:]*:[[:space:]]*([^ ]+).*/\1/I' | tr -d ',;\r' || echo "")
AVIS_COORD_FILE=$(echo "$AVIS_COMMENT_BLOCK" | grep -i "avis_coord_file" | head -n1 | sed -E 's/.*avis_coord_file[^:]*:[[:space:]]*([^ ]+).*/\1/I' | tr -d ',;\r' || echo "")

if [[ -z "$AVIS_COORD_DIR" || -z "$AVIS_COORD_FILE" ]]; then
    echo "[ERROR] Missing AVIS_COORD_DIR or AVIS_COORD_FILE in AVIS comment block."
    rm -f "$TEMP_RAW"
    exit 1
fi

TARGET_DIR="$ROOT_DIR/$AVIS_COORD_DIR"
TARGET_PATH="$TARGET_DIR/$AVIS_COORD_FILE"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Write the entire AVIS block bit-perfectly to the target file
cat "$TEMP_RAW" > "$TARGET_PATH"

echo "------------------------------------------------"
echo "[avis-gen] File written to: $TARGET_PATH"
echo "------------------------------------------------"
#echo "[avis-gen] File content:"
#cat "$TARGET_PATH"
#echo "------------------------------------------------"

# Clean up
rm -f "$TEMP_RAW"

echo "[avis-gen] Done. your source code is installed."