#!/bin/bash
# CVBGOD Sentinel - AVIS-DATALAKE Sitemap Generator
# Pattern: begin.seed.avis.spec.dispatch_spec

REPO_URL=$(git config --get remote.origin.url | sed 's/\.git$//' | sed 's/git@github.com:/https:\/\/github.com\//')
BASE_URL="${REPO_URL}/blob/main"
OUTPUT_FILE="sitemap.avis"

echo "AVIS-DATALAKE-VERSION: 1.0.CVBGOD" > $OUTPUT_FILE
echo "SPEC: Standard-C / Robo-Knight Legacy Bridge" >> $OUTPUT_FILE
echo "BEGIN_DISPATCH_MAP" >> $OUTPUT_FILE

# Find files and tag them for AVIS ingestion
find . -type f -not -path '*/.git/*' | while read -r file; do
    CLEAN_PATH="${file#./}"
    ENCODED_PATH=$(echo "$CLEAN_PATH" | sed 's/ /%20/g')
    
    # Logic: Identify the object and assign its exit capability
    echo "OBJECT: ${BASE_URL}/${ENCODED_PATH} .return" >> $OUTPUT_FILE
done

echo "END_DISPATCH_MAP" >> $OUTPUT_FILE
echo "Done! Cyborg Sitemap saved to $OUTPUT_FILE"