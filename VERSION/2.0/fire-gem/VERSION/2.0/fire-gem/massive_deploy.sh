#!/bin/bash
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.00
# ;@VERSION: 2.0.4

V_ROOT="/workspaces/Sentinel"
cd "$V_ROOT"

echo "[BGIN] REPAIRING DEBIAN CONTROL CONTRACT..."

# 1. Manifest a VALID control file
mkdir -p sentinel-deb/DEBIAN
cat <<EOF > sentinel-deb/DEBIAN/control
Package: sentinel-v2-massive
Version: 2.0.4
Section: utils
Priority: optional
Architecture: amd64
Maintainer: CVBGOD <mercwar@sentinel.os>
Depends: nasm, gcc
Description: Sentinel-OS Massive Deployment Package (AVIS-GEN v2.04)
 Pulse-aligned binary for Red Hat and Ubuntu.
EOF

# 2. Build the Debian Pulse
echo "[AVIS] BUILDING DEBIAN PACKAGE..."
dpkg-deb --build sentinel-deb sentinel-v2-massive.deb

# 3. Handle 'alien' dependency (Red Hat Reflection)
if ! command -v alien &> /dev/null; then
    echo "[AVIS] ALIEN NOT FOUND. PULLING FROM APT..."
    sudo apt-get update && sudo apt-get install -y alien
fi

# 4. Reflect to RPM
echo "[AVIS] REFLECTING TO RPM FOR RED HAT..."
sudo alien -r sentinel-v2-massive.deb --scripts

echo "--------------------------------------------------"
echo "[SUCCESS] MASSIVE DEPLOYMENT SOLIDIFIED."
echo "[SUCCESS] DEB: sentinel-v2-massive.deb"
echo "[SUCCESS] RPM: $(ls *.rpm 2>/dev/null || echo 'RPM_PENDING')"
echo "--------------------------------------------------"

