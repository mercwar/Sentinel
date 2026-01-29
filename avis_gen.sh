#!/bin/bash
# BGIN
# /* AVIS_COORD: AVIS://BASH/INGESTOR/1.0.CVBGOD */
# /* ROLE: Detects filename from pasted BGIN header and writes file */

echo "--------------------------------------------------"
echo "[BGIN] READY FOR DATA INGESTION."
echo "PASTE YOUR CODE (Must include avis_coord line)."
echo "Press Ctrl+D when finished."
echo "--------------------------------------------------"

# 1. Capture the entire paste into a temp buffer
RAW_DATA=$(cat)

# 2. DETECT: Find the filename in the avis_coord tag
# Matches: /* avis_coord: path/to/file.ext ... */
TARGET_PATH=$(echo "$RAW_DATA" | grep -oP 'avis_coord:\s*\K[^, ]+')

if [ -z "$TARGET_PATH" ]; then
    echo "[BGIN ERROR] No 'avis_coord' detected in paste. Aborting."
    exit 1
fi

# 3. MKDIR: Create the versioned directory structure automatically
TARGET_DIR=$(dirname "$TARGET_PATH")
mkdir -p "$TARGET_DIR"

# 4. WRITE: Commit the data to the versioned root
echo "$RAW_DATA" > "$TARGET_PATH"

if [ -f "$TARGET_PATH" ]; then
    echo "--------------------------------------------------"
    echo "[BGIN SUCCESS] FILE CREATED: $TARGET_PATH"
    echo "HANDSHAKE COMPLETE. .return(1)"
else
    echo "[BGIN ERROR] Write failed."
fi
``` [INDEX]