#!/bin/bash
/* 
 * AVIS_SPEC: START_SITEMAP_GEN
 * IDENT: CVBGOD_SENTINEL_NODE
 * LAKE_VER: AVIS-DATALAKE-V1.0
 * PATTERN: BEGIN -> SEED -> AVIS -> SPEC -> DISPATCH -> RETURN
 * ROLE: Layer 4 Handshake - Data Lake Mapping Engine
 * avis_coord: sitemap.sh, layer: DISPATCH, role: Navigator
 */

# Handshake validation check
echo "[cyb_pulse] Initializing Sitemap Generator..."
echo "AVIS_GUIDE: Validating 0xDEADBEEF Pulse..."

REPO_URL=$(git config --get remote.origin.url | sed 's/\.git$//' | sed 's/git@github.com:/https:\/\/github.com\//')
BASE_URL="${REPO_URL}/blob/main"
OUTPUT_FILE="sitemap.avis"

# Build the Data Lake Map
{
    echo "AVIS-DATALAKE-VERSION: 1.0.CVBGOD"
    echo "SPEC: Standard-C / Robo-Knight Legacy Bridge"
    echo "BEGIN_DISPATCH_MAP"
} > $OUTPUT_FILE

# Find files and tag them for AVIS ingestion with .return capability
find . -type f -not -path '*/.git/*' | while read -r file; do
    CLEAN_PATH="${file#./}"
    ENCODED_PATH=$(echo "$CLEAN_PATH" | sed 's/ /%20/g')
    
    # AVIS_GUIDE: Ingesting object into Sentinel logic
    echo "OBJECT: ${BASE_URL}/${ENCODED_PATH} .return" >> $OUTPUT_FILE
done

echo "END_DISPATCH_MAP" >> $OUTPUT_FILE
echo "[cyb_pulse] .return executed. Cyborg Sitemap saved to $OUTPUT_FILE"

# AVIS_SPEC: END_SITEMAP_GEN
