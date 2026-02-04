cat << 'AVIS'
# #[avis] begin template bash
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.01
# ;@AUTHORITY: CVBGOD (2ED0213EFEFE9340)
# ;@VERSION: 2.0.1
# avis_coord_dir: VERSION/2.0/fire-gem
# avis_coord_file: sentinel-chmod.sh

#BGIN
#!/bin/bash
# ;@ENGINE: BGIN.AVIS_CJS_v2.0
# ;@DESC: Universal Authority Lock (Execution-Safe)

set -euo pipefail

# 1. RESOLVE ANCHOR
V_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "${GITHUB_WORKSPACE:-$(pwd)}")"

echo "[BGIN] APPLYING UNIVERSAL AUTHORITY TO: $V_ROOT"

# 2. LOCK PERMISSIONS
# 755 for Shell Engines and 644 for Source/Config
find "$V_ROOT/VERSION/2.0" -type f -name "*.sh" -exec chmod 755 {} +
find "$V_ROOT/VERSION/2.0" -type f -name "*.asm" -exec chmod 644 {} +
find "$V_ROOT/VERSION/2.0" -type f -name "*.c" -exec chmod 644 {} +
find "$V_ROOT/VERSION/2.0" -type f -name "*.json" -exec chmod 644 {} +

# 3. SPECIAL PERMISSION: CORE EXECUTORS
chmod +x "$V_ROOT/VERSION/2.0/fire-gem/fire-gem.sh"
chmod +x "$V_ROOT/VERSION/2.0/fire-gem/fire-source-exec.sh"

echo "[SUCCESS] Sentinel-OS Permissions Synchronized via CVBGOD Authority."
#!#

#FIRE!END# DO NOT MODIFY
#!# RECOVERY_SIG_MATCHED
