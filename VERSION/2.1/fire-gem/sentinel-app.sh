# 1. Compile the Kernel
gcc -nostdlib -o /workspaces/Sentinel/sentinel_v2_kern /workspaces/Sentinel/VERSION/2.1/fire-gem/sentinel_app.c

# 2. Execute the Authority
/workspaces/Sentinel/sentinel_v2_kern

# 3. Verify the Portal Peek
php /workspaces/Sentinel/VERSION/2.1/fire-gem/sentinel_portal.php
