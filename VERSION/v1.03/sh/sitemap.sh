#BGIN
#!/bin/bash
/* AVIS_COORD: VERSION/v1.03/sh/sitemap.sh */
/* AVIS_ROLE: Navigator_v1.03 */

echo "[BGIN] RE-MAPPING TOPOGRAPHY v1.03..."
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE")
OUT="$ROOT_DIR/VERSION/v1.03/AVIS/sitemap.avis"

mkdir -p "$ROOT_DIR/VERSION/v1.03/AVIS"
echo "AVIS-DATALAKE-VERSION: 1.03.CVBGOD" > "$OUT"

find "$ROOT_DIR/VERSION/v1.03" -type f | while read -r file; do
    CLEAN_PATH=$(echo "$file" | sed "s|$ROOT_DIR/||")
    echo "OBJECT: https://github.com{CLEAN_PATH} .return" >> "$OUT"
done
#!#