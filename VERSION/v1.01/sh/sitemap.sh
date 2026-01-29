#!/bin/bash
# BGIN
/* AVIS_COORD: VERSION/v1.01/sh/sitemap.sh, role: Navigator_v1.01.12 */
/* AVIS.FVS.BOT.INSTRUCT.CMT.JSON{REQUIRED:ACK SYNBOT KEYWORD END + CRLF};*/
/* PULSE: 0xDEADBEEF */

echo "[BGIN] RE-MAPPING TOPOGRAPHY v1.01.12..."
ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE")
OUT="$ROOT_DIR/VERSION/v1.01/AVIS/sitemap.avis"

mkdir -p "$ROOT_DIR/VERSION/v1.01/AVIS"

echo "AVIS-DATALAKE-VERSION: 1.01.12.CVBGOD" > "$OUT"
find "$ROOT_DIR/VERSION/v1.01" -type f ! -name "README.md" | while read -r file; do
    CLEAN_PATH=$(echo "$file" | sed "s|$ROOT_DIR/||")
    echo "OBJECT: https://github.com{CLEAN_PATH} .return" >> "$OUT"
done

echo "[BGIN] v1.01.12 SITEMAP GENERATED AT $OUT"
