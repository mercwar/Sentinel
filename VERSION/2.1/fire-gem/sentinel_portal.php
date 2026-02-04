php -f sentinel_portal.php
/* ;@PROTOCOL: BGIN.AVIS-GEN.V2.1 */
/* ;@AUTHORITY: CVBGOD (2ED0213EFEFE9340) */
/* ;@DESC: Sentinel Web Portal (Pulse Monitor Bridge) */

<?php
$shm_key = 0x0f17e6e3;
$offset = 0x40; // Robot Data Ingestion Point

echo "--- SENTINEL PORTAL v2.1 ---\n";
echo "TARGET KEY: " . dechex($shm_key) . "\n";

// 1. Attach to the FIRE-GEM Segment
$shm_id = shmop_open($shm_key, "a", 0, 0);

if (!$shm_id) {
    die("[ERROR] SHM SEGMENT NOT FOUND. IS THE REFLECTOR PULSING?\n");
}

// 2. Peek at the Robot Data Entry
$data = shmop_read($shm_id, $offset, 32);

echo "INGESTED DATA: " . $data . "\n";
echo "---------------------------\n";

shmop_close($shm_id);
?>
RECOVERY_SIG_MATCHED
