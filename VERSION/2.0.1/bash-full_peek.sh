cat << 'EOF' > full_peek.sh
#!/bin/bash
TARGET_FILE="/dev/shm/fire-gem-0x0f17e6e3"

echo "--------------------------------------------------"
echo "[BGIN] FULL SEGMENT PEEK: $TARGET_FILE"
echo "--------------------------------------------------"

if [ ! -f "$TARGET_FILE" ]; then
    echo "[ERROR] Shared memory file not found."
    exit 1
fi

# Dump the critical first 256 bytes (Header + Pulse Zone)
echo "[AVIS] HEADER ZONE (0x00 - 0xFF):"
hexdump -C -n 256 "$TARGET_FILE"

echo -e "\n[AVIS] SEGMENT FOOTER (Tail check):"
hexdump -C -s 16300 "$TARGET_FILE"
EOF

chmod +x full_peek.sh
./full_peek.sh
