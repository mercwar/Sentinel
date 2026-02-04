# Compile the ASM robot
nasm -f elf64 /workspaces/Sentinel/VERSION/2.0/AI/bgin-avis/sentinel_v2.asm -o sentinel_v2.o
ld sentinel_v2.o -o sentinel_v2

# Execute the robot
./sentinel_v2
