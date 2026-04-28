/* AVIS_FILE_NAME: sentinel_v1.c */
/* AVIS_BINARY_SIG: MERC  ÿ */

#include <stdio.h>

int main() {
    // Exact signature: MERC (4D 45 52 43), two spaces (20 20), and ÿ (FF)
    unsigned char avis_sig[] = {0x4D, 0x45, 0x52, 0x43, 0x20, 0x20, 0xFF};

    FILE *f = fopen("Beacon/mercwar_discovery.bin", "wb");
    if (f == NULL) {
        printf("BASH: [NACK] AVIS_ERR: Beacon path unreachable.\n");
        return 1;
    }

    fwrite(avis_sig, 1, sizeof(avis_sig), f);
    fclose(f);

    printf("BASH: [ACK] AVIS: mercwar_discovery.bin (MERC  ÿ) dropped.\n");
    return 0;
}
