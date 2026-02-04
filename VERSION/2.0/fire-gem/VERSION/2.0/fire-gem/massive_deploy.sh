#!/bin/bash
# #[avis] begin template bash
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.00
# ;@VERSION: 2.0.4
# avis_coord_dir: /VERSION/2.0/fire-gem/
# avis_coord_file: massive_deploy.sh

source ./VERSION/2.0/fire-gem/fire-root.sh

#BGIN
echo "[BGIN] Initiating Universal Pulse for Red Hat & Ubuntu..."

# DEBIAN BUILD (Using dpkg-deb)
mkdir -p sentinel-deb/DEBIAN
echo "Package: sentinel-v2-massive" > sentinel-deb/DEBIAN/control
echo "Version: 2.0.4" >> sentinel-deb/DEBIAN/control
echo "Depends: sentinel-v1-core (= 1.05)" >> sentinel-deb/DEBIAN/control
dpkg-deb --build sentinel-deb sentinel-v2-massive.deb

# RED HAT BUILD (Using Alien for RPM reflection)
# Alien converts the AVIS-GEN compliant .deb into a .rpm
sudo alien -r sentinel-v2-massive.deb --scripts

echo "[BGIN] Massive Deployment Complete. Pulse Ingested."
#!#
