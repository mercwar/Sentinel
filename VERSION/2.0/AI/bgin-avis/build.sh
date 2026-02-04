# #[avis] begin template bash
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.01
# ;@AUTHORITY: CVBGOD (2ED0213EFEFE9340)
# avis_coord_dir: VERSION/2.0/AI/bgin-avis
# avis_coord_file: build.sh

# --- THE FORCED BUILD PULSE ---
# Ensure we are in the correct directory for the object file
cd /workspaces/Sentinel/VERSION/2.0/AI/bgin-avis/

nasm -f elf64 sentinel_v2.asm -o sentinel_v2.o || { echo "[ERROR] NASM FAILED"; exit 1; }
ld sentinel_v2.o -o sentinel_v2 || { echo "[ERROR] LINKER FAILED"; exit 1; }

echo "[BGIN] ROBOT COMPILED SUCCESSFULLY: /workspaces/Sentinel/sentinel_v2"
# Move to root for easier execution
mv sentinel_v2 /workspaces/Sentinel/sentinel_v2
#!# RECOVERY_SIG_MATCHED
