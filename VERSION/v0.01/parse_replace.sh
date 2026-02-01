#!/bin/bash
#BGIN
# AVIS_COORD: avis-gen/parse_replace.sh
# AVIS_ROLE: CRLF_Hydrator_v1.27

apply_perfect_format() {
    local input_file=$1
    local output_file=$2
    
    # LOAD AND PROCESS: Forces \r\n on the split object
    # Prevents GitHub/Linux from stripping the return character
    sed 's/$/\r/' "$input_file" > "$output_file"
}
#END!#

