#!/bin/bash
# sentinel-sitemap.sh
# Generates a sentinel-style sitemap listing repo files with URLs in the OBJECT: ... .return format

set -euo pipefail

# Get the root directory of the git repository
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || pwd)

# Base GitHub URL prefix (adjust "CONSOLE" to your actual repo or folder name)
# For example, if your repo or folder is named "CONSOLE", keep it as is.
# Otherwise, replace "CONSOLE" with your repo or organization name.
BASE_URL="https://github.comCONSOLE"

OUTPUT_FILE="$ROOT_DIR/sitemap.avis"

echo "[BGIN] GENERATING SENTINEL-STYLE SITEMAP..."

mkdir -p "$(dirname "$OUTPUT_FILE")"

# Write header line (optional)
echo "AVIS-DATALAKE-VERSION: 1.04.00.CVBGOD" > "$OUTPUT_FILE"

# Find all files excluding .git directory, relative to repo root
find "$ROOT_DIR" -type f -not -path "$ROOT_DIR/.git/*" | while read -r file; do
    # Get relative path to repo root
    rel_path="${file#$ROOT_DIR/}"

    # Replace spaces with %20 for URL safety
    encoded_path="${rel_path// /%20}"

    # Write in sentinel sitemap format
    echo "OBJECT: ${BASE_URL}/${encoded_path} .return" >> "$OUTPUT_FILE"
done

echo "[BGIN] SENTINEL SITEMAP GENERATED AT $OUTPUT_FILE"
