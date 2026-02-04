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
# ;@PROTOCOL: BGIN.AVIS-TERMINATOR.FIX
# ;@DESC: Detects CRLF (\r\n) or the RECOVERY_SIG_MATCHED string

while IFS= read -r line || [[ -n "$line" ]]; do
    # 1. Check for the literal RECOVERY_SIG_MATCHED string
    if [[ "$line" == *"RECOVERY_SIG_MATCHED"* ]]; then
        echo "$line" >> "$TEMP_RAW"
        break
    fi

    # 2. Check for empty lines or specific CRLF sequences
    # Note: Bash 'read' often strips \r; if the line is purely \r\n, 
    # it may appear as an empty string.
    if [[ "$line" == $'\r' ]] || [[ "$line" == $'\r\n' ]]; then
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