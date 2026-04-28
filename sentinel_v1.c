/* AVIS_FILE_NAME: sentinel_v1.c */
/* AVIS_SIG_PAYLOAD: 4D 45 52 43 20 20 FF */

#include <stdio.h>

int main() {
    // [M][E][R][C][ ][ ][xFF]
    unsigned char drop[] = { 0x4D, 0x45, 0x52, 0x43, 0x20, 0x20, 0xFF };

    FILE *f = fopen("Beacon/mercwar_discovery.bin", "wb");
    if (!f) return 1;

    fwrite(drop, 1, sizeof(drop), f);
    fclose(f);

    // This outputs the ACK for the GitHub Action log
    printf("BASH: [ACK] AVIS-DATALAKE: mercwar_discovery.bin materialized with MERC_END sig.\n");
    return 0;
}
