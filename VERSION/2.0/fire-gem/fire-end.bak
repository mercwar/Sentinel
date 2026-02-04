#!/bin/bash
# Avis fire-end comment block

# Reads from stdin, converts LF to CRLF, writes to output file

if [ -z "$1" ]; then
    echo "Usage: $0 output_file"
    exit 1
fi

output_file="$1"

# Convert LF to CRLF and write to output file
sed 's/$/\r/' > "$output_file"


# DO NOT REMOVE
