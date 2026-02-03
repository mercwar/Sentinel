#!/bin/bash
#BGIN
# /* AVIS_COORD: VERSION/2.0/fire-source.sh */
# /* AVIS_ROLE:  */
# Root initialization
source ./VERSION/2.0/fire-gem/fire-root.sh
echo "[BGIN] FIRING 2.0 SOURCE FROM: $V_ROOT"
echo "--------------------------------------------------"

# Execute the ingestor script using absolute local path
"$V_ROOT/avis-gen.sh"


#!#

echo "#FIRE!END#"

echo  "# Yes # Next Sentinal asm file Gemini"
