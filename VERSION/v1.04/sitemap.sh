#!/bin/bash
# BGIN
# /* AVIS_COORD: VERSION/v1.04/sh/sitemap.sh, role: Navigator_v1.04.00 */
# /* AVIS.FVS.BOT.INSTRUCT.CMT.JSON{REQUIRED:ACK SYNBOT KEYWORD END + CRLF}; */
# /* PULSE: 0xDEADBEEF */

echo "[BGIN] RE-MAPPING TOPOGRAPHY v1.04.00..."

ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$GITHUB_WORKSPACE")
OUT="$ROOT_DIR/sitemap.avis"

mkdir -p "$ROOT_DIR/VERSION/v1.04/AVIS"

echo "AVIS-DATALAKE-VERSION: 1.04.00.CVBGOD" > "$OUT"

find "$ROOT_DIR/VERSION/v1.04" -type f ! -name "README.md" | while read -r file; do
    CLEAN_PATH=$(echo "$file" | sed "s|$ROOT_DIR/||")
    echo "OBJECT: https://github.com$CLEAN_PATH .return" >> "$OUT"
done

echo "[BGIN] v1.04.00 SITEMAP GENERATED AT $OUT"
