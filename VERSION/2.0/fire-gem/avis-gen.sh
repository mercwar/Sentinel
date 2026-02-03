#!/bin/bash
# avis-gen.sh - AVIS ingestion script v1.0
# Reads AVIS block from terminal until '#!#'
# Parses AVIS_COORD_DIR and AVIS_COORD_FILE from AVIS comment block
# Writes the AVIS block bit-perfectly to the target file
# Creates directories as needed
# Prints file content and full path after writing
#BGIN
set -euo pipefail
source /workspaces/Sentinel/VERSION/2.0/fire-root.sh
echo "Kernal Avis Gen"
# Determine root directory fallback to current directory
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "${GITHUB_WORKSPACE:-$(pwd)}")
TEMP_RAW=".avis_raw_buffer"
# Clear or create TEMP_RAW file
: > "$TEMP_RAW"


while IFS= read -r line; do
    # Check for the terminator immediately
    if [[ "$line" == "#!#" || "$line" == "; #!#" ]]; then
        echo "$line" >> "$TEMP_RAW"
        break
    fi
    # Keep the line in the raw buffer
    echo "$line" >> "$TEMP_RAW"
done



# Extract AVIS comment block lines between /* and */
AVIS_COMMENT_BLOCK=$(sed -n '/\/\*/,/\*\//p' "$TEMP_RAW")

# Debug print to verify the extracted comment block
echo "[DEBUG] AVIS_COMMENT_BLOCK:"
echo "$AVIS_COMMENT_BLOCK"

# Parse AVIS_COORD_DIR from the comment block
AVIS_COORD_DIR=$(echo "$AVIS_COMMENT_BLOCK" | grep -i "avis_coord_dir" | head -n1 | \
    sed -E 's/.*avis_coord_dir[^:]*:[[:space:]]*([^ ]+).*/\1/I' | tr -d ',;\r' || echo "")

# Parse AVIS_COORD_FILE from the comment block
AVIS_COORD_FILE=$(echo "$AVIS_COMMENT_BLOCK" | grep -i "avis_coord_file" | head -n1 | \
    sed -E 's/.*avis_coord_file[^:]*:[[:space:]]*([^ ]+).*/\1/I' | tr -d ',;\r' || echo "")

# Debug prints to verify parsed values
echo "[DEBUG] AVIS_COORD_DIR='$AVIS_COORD_DIR'"
echo "[DEBUG] AVIS_COORD_FILE='$AVIS_COORD_FILE'"

# Check if either variable is empty and exit with error if so
if [[ -z "$AVIS_COORD_DIR" || -z "$AVIS_COORD_FILE" ]]; then
    echo "[ERROR] Missing AVIS_COORD_DIR or AVIS_COORD_FILE in AVIS comment block."
    rm -f "$TEMP_RAW"
    exit 1
fi

# Construct target directory and file path
TARGET_DIR="$ROOT_DIR/$AVIS_COORD_DIR"
TARGET_PATH="$TARGET_DIR/$AVIS_COORD_FILE"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Write the entire AVIS block bit-perfectly to the target file
cat "$TEMP_RAW" > "$TARGET_PATH"

echo "------------------------------------------------"
echo "[avis-gen] File written to: $TARGET_PATH"
echo "------------------------------------------------"

# Optional: print file content for verification
# echo "[avis-gen] File content:"
# cat "$TARGET_PATH"
# echo "------------------------------------------------"

# Clean up temporary raw buffer file
rm -f "$TEMP_RAW"

echo "[avis-gen] Done. your source code is installed."
#!#