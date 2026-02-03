#!/bin/bash
# --- Sentinel V2 Auto-Repair Build Script ---

# 1. Setup Directories
mkdir -p sentinel-pkg/DEBIAN sentinel-pkg/usr/bin

# 2. Generate Debian Control File
cat > sentinel-pkg/DEBIAN/control <<EOF
Package: sentinel-v2-core
Version: 2.0.0
Architecture: amd64
Maintainer: Joseph Michael Catalano <mercwar01@gmail.com>
Description: Full Sentinel V2 Base Core signed by CVBGOD
EOF

# 3. Assemble ASM Scroll
nasm -f elf64 VERSION/2.0/sentinel_v2.asm -o sentinel_v2.o
ld sentinel_v2.o -o sentinel-pkg/usr/bin/sentinel-v2

# 4. Build and Sign
dpkg-deb --build sentinel-pkg sentinel-v2-core.deb
dpkg-sig -k 2ED0213EFEFE9340 --sign builder sentinel-v2-core.deb
dpkg-sig --verify sentinel-v2-core.deb
