# 1. Create the physical file anchor
touch /dev/shm/fire-gem-0x0f17e6e3

# 2. Inject the Robot Data at Offset 64 (0x40)
printf "BGIN-PULSE-2026-ACTIVE-AUTHORITY" | dd of=/dev/shm/fire-gem-0x0f17e6e3 bs=1 seek=64 conv=notrunc

# 3. Verify the file now exists and contains data
hexdump -C -s 64 -n 32 /dev/shm/fire-gem-0x0f17e6e3
