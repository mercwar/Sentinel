#!/usr/bin/php
<?php
/* ;@PROTOCOL: BGIN.AVIS-GEN.V2.1.2 */
/* ;@AUTHORITY: CVBGOD (2ED0213EFEFE9340) */

$shm_key = 0x0f17e6e3;
$offset = 0x40; // 64 decimal

$shm_id = @shmop_open($shm_key, "a", 0, 0);

echo "\n--- SENTINEL-OS PORTAL PULSE ---\n";
if (!$shm_id) {
    echo "STATUS: [OFFLINE] SHM 0x0f17e6e3 NOT FOUND\n";
} else {
    $raw_data = shmop_read($shm_id, $offset, 32);
    $hex_data = bin2hex($raw_data);
    echo "RAW: " . trim($raw_data) . "\n";
    echo "HEX: " . strtoupper(chunk_split($hex_data, 2, ' ')) . "\n";
    shmop_close($shm_id);
}
echo "--------------------------------\n";
?>
