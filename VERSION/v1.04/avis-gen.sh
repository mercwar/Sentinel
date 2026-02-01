#!/bin/bash
# avis-gen.sh - AVIS ingestion script v1.0
# Reads AVIS block from terminal until '#!#'
# Parses AVIS_COORD_DIR and AVIS_COORD_FILE from AVIS comment block
# Writes the AVIS block bit-perfectly to the target file
# Creates directories as needed
# Prints file content and full path after writing
#BGIN
set -euo pipefail
source /workspaces/Sentinel/VERSION/v1.04/fire-root.sh
echo "Kernal Avis Gen"
# Determine root directory fallback to current directory
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "${GITHUB_WORKSPACE:-$(pwd)}")
LINE_IN=0
FIRE_END=0
TEMP_RAW=".avis_raw_buffer"
# Clear or create TEMP_RAW file
: > "$TEMP_RAW"



while IFS= read -r line; do
    printf '%s\r\n' "$line" >> "$TEMP_RAW"

    echo "Read line: '$line' (length: ${#line})"

    trimmed_line=$(echo "line$" | xargs)

    if [[ "$line" == "#!#" ]]; then
        LINE_IN=1
        echo "LINE_IN sentinel found"
    fi

    echo "LINE_IN = $LINE_IN"

    if [[ $LINE_IN -eq 1 ]]; then
        echo "Both sentinels found, breaking loop."
        break
    fi
done



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
#!#