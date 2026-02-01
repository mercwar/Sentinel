#!/bin/bash
#BGIN
# /* AVIS_COORD: VERSION/v1.04/push-sitemap.sh */
# /* AVIS_ROLE: SITEMAP_PUSH_COMMIT */

# 1. ANCHOR: Define the versioned root
V_ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$V_ROOT" || exit 1

# 2. SHIELD: Ensure permissions are locked
chmod +x ./*.sh

echo "[BGIN] FIRING v1.04 KERNEL FROM: $V_ROOT"
echo "--------------------------------------------------"

# 3. EXEC: Fire NAV using correct relative path
../v1.01/sh/fire_navigator.sh
#!#


