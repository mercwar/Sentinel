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
V_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "${GITHUB_WORKSPACE:-$(pwd)}")"

chmod +x /workspaces/Sentinel/VERSION/2.0.1/sentinel-chmod.sh

echo "[BGIN] APPLYING UNIVERSAL AUTHORITY TO: $V_ROOT"

# 2. LOCK PERMISSIONS (644 for Source, 755 for Engines)
# This ensures the 10-Stage Pipeline can read all robots
find "$V_ROOT/VERSION/2.0.1" -type f -name "*.sh" -exec chmod 755 {} +
find "$V_ROOT/VERSION/2.0.1" -type f -name "*.asm" -exec chmod 644 {} +
find "$V_ROOT/VERSION/2.0.1" -type f -name "*.c" -exec chmod 644 {} +

find "$V_ROOT/VERSION/2.0" -type f -name "*.sh" -exec chmod 755 {} +
find "$V_ROOT/VERSION/2.0" -type f -name "*.asm" -exec chmod 644 {} +
find "$V_ROOT/VERSION/2.0" -type f -name "*.c" -exec chmod 644 {} +

find "$V_ROOT/VERSION/2.1" -type f -name "*.sh" -exec chmod 755 {} +
find "$V_ROOT/VERSION/2.1" -type f -name "*.asm" -exec chmod 644 {} +
find "$V_ROOT/VERSION/2.1" -type f -name "*.c" -exec chmod 644 {} +
find "$V_ROOT/VERSION/2.1" -type f -name "*.php" -exec chmod 755 {} +

# 3. SPECIAL PERMISSION: FIRE-GEM EXECUTABLES
chmod +x /workspaces/Sentinel/VERSION/2.0.1/fire-gem.sh
chmod +x /workspaces/Sentinel/VERSION/2.1/fire-gem/fire-gem-v2.1.sh

echo "[SUCCESS] Sentinel-OS Permissions Synchronized."
#!#

#/* #FIRE!END# DO NOT MODIFY */
#/* #FIRE!END# */

#/* #!# */

#/* #FIRE!END# */
#/* #FIRE!END# DO NOT MODIFY */
#/* #!# RECOVERY_SIG_MATCHED */
