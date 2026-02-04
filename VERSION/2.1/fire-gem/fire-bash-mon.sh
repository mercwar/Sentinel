#!/bin/bash
# ;@PROTOCOL: BGIN.AVIS-GEN.V2.1
# ;@AUTHORITY: CVBGOD (2ED0213EFEFE9340)

ipcrm -m 0
/workspaces/Sentinel/VERSION/2.0/fire-gem/mz_reflector --init --key 0x0f17e6e3 --root /workspaces/Sentinel
# Set the signature in the mapped file
printf "MZ" | dd of=/dev/shm/fire-gem-0x0f17e6e3 bs=1 conv=notrunc

# Launch monitor with the forced key
GEM_KEY="0x0f17e6e3" bash /workspaces/Sentinel/VERSION/2.0.1/bash-debug_gem.sh
