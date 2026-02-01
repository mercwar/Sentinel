#!/bin/bash
#BGIN
# /* AVIS_COORD: VERSION/v1.04/fire-source.sh */
# /* AVIS_ROLE:  */
# Root initialization
source ./VERSION/v1.04/fire-root.sh
echo "[BGIN] FIRING v1.04 SOURCE FROM: $V_ROOT"
echo "--------------------------------------------------"

# Execute the ingestor script using absolute local path
"$V_ROOT/avis-gen.sh"


#!#

echo "#FIRE!END#"

echo  "# Yes # Next Sentinal asm file Gemini"
