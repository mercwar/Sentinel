#!/bin/bash
#BGIN
# loader.sh - Authority Interface
get_map_val() {
    jq -r "$1" "$(dirname "$0")/avis_escape_map.json"
}
#END!#
