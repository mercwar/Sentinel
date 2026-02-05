# 1. Manually pulse the Robot Data into the spine at Offset 64
printf "BGIN-ROBOT-001-PULSE-ACTIVE" | dd of=/dev/shm/fire-gem-0x0f17e6e3 bs=1 seek=64 conv=notrunc

# 2. Execute the Portal Peek
php /workspaces/Sentinel/VERSION/2.1/fire-gem/sentinel_portal.php

