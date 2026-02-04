sh /workspaces/Sentinel/VERSION/2.1/fire-gem/fire-gem-v2.1.sh
#/* #[avis] begin template bash */
#/* ;@PROTOCOL: BGIN.AVIS-GEN.V2.01 */
#/* ;@AUTHORITY: CVBGOD (2ED0213EFEFE9340) */
#/* ;@VERSION: 2.0.1 */
#/* avis_coord_dir: VERSION/2.0.1/fire-gem */
#/* avis_coord_file: sentinel-chmod.sh */

#BGIN
#!/bin/bash
# ;@ENGINE: BGIN.AVIS_CJS_v2.0
# ;@DESC: Universal Authority Lock for Sentinel-OS

set -euo pipefail

# 1. RESOLVE ANCHOR
V_ROOT="/workspaces/Sentinel"

echo "[BGIN] APPLYING UNIVERSAL AUTHORITY TO: $V_ROOT"

# 2. LOCK PERMISSIONS
# 755 for Engines/Scripts
find "$V_ROOT/VERSION/2.0" -type f \( -name "*.sh" -o -name "*.py" \) -exec chmod 755 {} +
find "$V_ROOT/VERSION/2.1" -type f \( -name "*.sh" -o -name "*.py" \) -exec chmod 755 {} +

# 644 for Source Authority
find "$V_ROOT/VERSION/2.0" -type f \( -name "*.asm" -o -name "*.c" -o -name "*.h" \) -exec chmod 644 {} +
find "$V_ROOT/VERSION/2.1" -type f \( -name "*.asm" -o -name "*.c" -o -name "*.h" \) -exec chmod 644 {} +

# 3. SPECIAL PERMISSION: FIRE-GEM EXECUTABLES
chmod +x "$V_ROOT/VERSION/2.0.1/fire-gem/fire-gem-v2.sh" 2>/dev/null || true
chmod +x "$V_ROOT/VERSION/2.1/fire-gem/fire-gem-v2.1.sh" 2>/dev/null || true

echo "[SUCCESS] Sentinel-OS Permissions Synchronized."
RECOVERY_SIG_MATCHED
