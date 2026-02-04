bash /workspaces/Sentinel/VERSION/2.1/fire-gem/fire-gem-v2.1.sh
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.1
# ;@AUTHORITY: CVBGOD (2ED0213EFEFE9340)
# ;@DESC: Critical Jekyll Recovery & Symlink Purge
#BGIN
#!/bin/bash
set -euo pipefail
V_ROOT="/workspaces/Sentinel"

echo "[BGIN] PURGING POISONED SYMLINKS..."

# 1. REMOVE THE SYMLINK CAUSING THE REALPATH ERROR
rm -f "$V_ROOT/mz_reflector"

# 2. MANIFEST CRITICAL CONFIG TO SHIELD KERNEL PATHS
cat <<EOF > "$V_ROOT/_config.yml"
title: Sentinel-OS Authority
theme: jekyll-theme-primer

# EMERGENCY SHIELD: Prevent Jekyll from scanning kernel binaries
exclude:
  - VERSION/
  - sentinel-deb/
  - build/
  - .avis_gateway_buffer
  - "*.deb"
  - "*.o"
  - "*.asm"
  - "sentinel_v2"
  - "mz_reflector"
EOF

echo "--------------------------------------------------"
echo "[SUCCESS] JEKYLL RECOVERY COMPLETE."
echo "[SUCCESS] _config.yml CREATED. GHOST LINK REMOVED."
echo "--------------------------------------------------"
RECOVERY_SIG_MATCHED
