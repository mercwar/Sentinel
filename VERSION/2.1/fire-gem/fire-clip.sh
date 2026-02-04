#!/bin/bash
# Avis fire-end comment block

TEMP_RAW="./VERSION/2.1/fire-gem/fire-new-file.raw"
> "$TEMP_RAW"

echo "======================================================="
echo "   GITHUB PASTE LAUNCHER"
echo "======================================================="
#echo "Press [ENTER] to start..."
#read -r 

echo "[ACTIVE] Paste content. Press [ENTER] on an empty line to finish."
echo "-------------------------------------------------------"

while IFS= read -r line; do
    # Probe: If the line is ONLY a Carriage Return, break the loop
    if [[ "$line" == $'\r' ]] || [[ -z "$line" ]]; then
        break
    fi
    
    # Save the line to the raw buffer
    printf "%s\n" "$line" >> "$TEMP_RAW"
done

echo "-------------------------------------------------------"
echo "[Installation] Syncing to GitHub..."

# Push to GitHub using CLI
if gh gist create "$TEMP_RAW" --public false; then
    echo "[SUCCESS] Content synced."
else
    echo "[NO INFO] Upload failed. Check 'gh auth status'."
fi
# DO NOT REMOVE
#FIRE!END#

#!#

#FIRE!END#
# DO NOT REMOVE