#!/bin/bash
# sentinel-sitemap.sh
# Generates a sentinel-style sitemap with URLs based on your GitHub repo root URL

set -euo pipefail

# Get the root directory of the git repository
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || pwd)

# Base GitHub URL for your repo root (as provided)
BASE_URL="https://github.com/mercwar/Sentinel/blob/main"

OUTPUT_FILE="$ROOT_DIR/sitemap.fvs"

echo "[BGIN] GENERATING SENTINEL-STYLE SITEMAP WITH CORRECTED ADDRESSES..."

mkdir -p "$(dirname "$OUTPUT_FILE")"

# Write header line (optional)
echo "AVIS-DATALAKE-VERSION: 2.00.00.CVBGOD" > "$OUTPUT_FILE"

# Find all files excluding .git directory, relative to repo root
find "$ROOT_DIR" -type f -not -path "$ROOT_DIR/.git/*" | while read -r file; do
    # Get relative path to repo root
    rel_path="${file#$ROOT_DIR/}"

    # Replace spaces with %20 for URL safety
    encoded_path="${rel_path// /%20}"

    # Write in sentinel sitemap format with corrected URL
    echo "OBJECT: ${BASE_URL}/${encoded_path} .return" >> "$OUTPUT_FILE"
done

echo "[BGIN] SENTINEL SITEMAP GENERATED AT $OUTPUT_FILE"
