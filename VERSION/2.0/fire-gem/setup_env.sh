apt install -y nasm gcc build-essential
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.01
# ;@AUTHORITY: CVBGOD (2ED0213EFEFE9340)
# ;@AVIS_COORD_DIR: VERSION/v1.04
# ;@AVIS_COORD_FILE: asm_install.sh
# ;@AVIS_ROLE: INSTALLER_STUB

set -euo pipefail
V_ROOT="/workspaces/Sentinel"

echo "[BGIN] INITIALIZING VERSION v1.04 & v1.05 SOURCE ANCHORS..."

# 1. Manifest the Authority Directories
mkdir -p "$V_ROOT/VERSION/v1.04/SOURCE"
mkdir -p "$V_ROOT/VERSION/v1.05/SOURCE"

# 2. Link the Keyword Gateway to the Legacy Root
ln -sf "$V_ROOT/VERSION/2.0.1/fire-gem/fire-gem-v2.sh" "$V_ROOT/VERSION/v1.04/fire-gem-v2.sh"

# 3. Secure the Ingestion Path
chmod +x "$V_ROOT/VERSION/v1.04/fire-gem-v2.sh"

echo "--------------------------------------------------"
echo "[SUCCESS] v1.04 INSTALLER ACTIVE."
echo "[AVIS] PATHS ANCHORED AT: $V_ROOT/VERSION/v1.04/SOURCE"
echo "--------------------------------------------------"
RECOVERY_SIG_MATCHED
