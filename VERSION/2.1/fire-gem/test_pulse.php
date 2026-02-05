php
<?php
$file = "/dev/shm/fire-gem-0x0f17e6e3";
echo "
--- BGIN PHYSICAL PEEK ---
";

if (!file_exists($file)) {
    die("STATUS: [OFFLINE] File not found in /dev/shm/
");
}

// 1. OPEN PHYSICAL MEMORY FILE
$handle = fopen($file, "rb");
fseek($handle, 64); // Seek to 0x40
$data = fread($handle, 32);
fclose($handle);

echo "RAW: " . trim($data) . "
";
echo "HEX: " . strtoupper(bin2hex($data)) . "
";
echo "--------------------------
";
?>