#!/bin/bash
#BGIN
# CVBGOD_Stream-Splitter_v1.24

TARGET_FILE="avis_test_output.txt"
TEMP_RAW=".raw_buffer"
> "$TEMP_RAW"

echo "------------------------------------------------"
echo "[CVBGOD] READ-SPLIT MODE: PASTE NOW"
echo "End with #!# on a new line"
echo "------------------------------------------------"

# 1. LOAD AND SPLIT
# We read the file stream until the #!# marker is hit
while IFS= read -r line; do
    # Check for the terminator immediately
    if [[ "$line" == "#!#" ]]; then
        echo "$line" >> "$TEMP_RAW"
        break
    fi
    # Keep the line in the raw buffer
    echo "$line" >> "$TEMP_RAW"
done

echo -e "\n[AUTO-PROC] SPLIT COMPLETE. REPLACING \n WITH \r\n..."

# 2. GLOBAL REPLACE & WRITE
# This takes the split lines and joins them with CRLF
sed 's/$/\r/' "$TEMP_RAW" > "$TARGET_FILE"

# 3. PRINT OUT THE WAY IT IS
echo "------------------------------------------------"
echo "[FILE CONTENT OUT]:"
cat "$TARGET_FILE"
echo "------------------------------------------------"

# Clean up
rm -f "$TEMP_RAW"
#END!#