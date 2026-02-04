cat << 'AVIS_PULSE'
<!-- #[avis] begin template bash -->
<!-- ;@PROTOCOL: BGIN.AVIS-GEN.V2.00 -->
<!-- ;@AUTHORITY: CVBGOD (2ED0213EFEFE9340) -->
<!-- avis_coord_dir: VERSION/2.0/fire-gem -->
<!-- avis_coord_file: avis-genx.sh -->

#BGIN
cat << 'AVIS_PULSE'
<!-- #[avis] begin template bash -->
<!-- ;@PROTOCOL: BGIN.AVIS-GEN.V2.00 -->
<!-- ;@AUTHORITY: CVBGOD (2ED0213EFEFE9340) -->
<!-- avis_coord_dir: VERSION/2.0/fire-gem -->
<!-- avis_coord_file: avis-gen.sh -->

#BGIN
#!/bin/bash
# ;@ENGINE: BGIN.AVIS_CJS_v2.0
# ;@DESC: Terminal-Lock Ingestor with Constraint Verification

set -euo pipefail
# Source anchor to lock V_ROOT
source "$(dirname "$0")/fire-root.sh"

TEMP_RAW=".avis_raw_buffer"
: > "$TEMP_RAW"

echo "[BGIN] TERMINAL LOCK ACTIVE. INGESTING PULSE..."

# --- THE BIT-PERFECT FIX: CONSTRAINT CAPTURE ---
# This loop is now guarded by the Heredoc wrapper
while IFS= read -r line || [[ -n "$line" ]]; do
    echo "$line" >> "$TEMP_RAW"
    case "$line" in
        "#!#" | "<!-- #!# -->" | "#!# RECOVERY_SIG_MATCHED") 
            break 
            ;;
    esac
done

# --- PATH SANITIZATION ---
COORD_DIR=$(grep -i -m1 "avis_coord_dir" "$TEMP_RAW" | awk -F': ' '{print $2}' | sed -E 's/[[:space:]]*-->//g; s|^/||; s|[[:space:]]*$||' | tr -d '\r ')
COORD_FILE=$(grep -i -m1 "avis_coord_file" "$TEMP_RAW" | awk -F': ' '{print $2}' | sed -E 's/[[:space:]]*-->//g; s|[[:space:]]*$||' | tr -d '\r ')

TARGET_DIR="${V_ROOT}/${COORD_DIR}"
TARGET_PATH="${TARGET_DIR}/${COORD_FILE}"

mkdir -p "$TARGET_DIR"
cat "$TEMP_RAW" > "$TARGET_PATH"
chmod 755 "$TARGET_PATH"

echo "------------------------------------------------"
echo "[AVIS] INSTALL SUCCESS: $TARGET_PATH"
echo "[BGIN] BYTES INGESTED: $(wc -c < "$TARGET_PATH")"
echo "------------------------------------------------"
#!#

<!-- #FIRE!END# DO NOT MODIFY -->
<!-- #FIRE!END# -->

<!-- #!# -->

<!-- #FIRE!END# -->
<!-- #FIRE!END# DO NOT MODIFY -->
<!-- #!# RECOVERY_SIG_MATCHED -->
AVIS_PULSE
