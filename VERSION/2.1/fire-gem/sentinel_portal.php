#!/usr/bin/php
<?php
/* ;@PROTOCOL: BGIN.AVIS-GEN.V2.2.0 (PHYSICAL_BRIDGE) */
$file = "/dev/shm/fire-gem-0x0f17e6e3";

echo "\n--- SENTINEL-OS PORTAL [PHYSICAL PEEK] ---\n";

if (!file_exists($file)) {
    die("STATUS: [OFFLINE] Memory spine not found in /dev/shm\n");
}

// 1. OPEN THE PHYSICAL MEMORY FILE
$handle = fopen($file, "rb");
// 2. SEEK TO THE 64-BYTE (0x40) INGESTION POINT
fseek($handle, 64);
// 3. PULL THE 32-BYTE ROBOT SIGNATURE
$data = fread($handle, 32);
fclose($handle);

echo "RAW DATA: " . trim($data) . "\n";
echo "HEX PEEK: " . strtoupper(bin2hex($data)) . "\n";
echo "------------------------------------------\n";
?>
